-- Java LSP (jdtls) setup. Runs automatically whenever you open a .java file.
-- Requires JDK 17+ available as `java` on your PATH (jdtls itself needs it).

local ok, jdtls = pcall(require, "jdtls")
if not ok then
	return
end

local home = os.getenv("HOME")
local mason = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason .. "/packages/jdtls"

-- Launcher jar (version wildcard)
local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
if launcher == "" then
	vim.notify("jdtls not installed. Run :Mason and install 'jdtls'.", vim.log.levels.WARN)
	return
end

-- Pick the right platform config folder (macOS Intel vs Apple Silicon)
local os_config = "config_mac"
if vim.loop.os_uname().machine == "arm64" then
	os_config = "config_mac_arm"
end

-- Per-project isolated workspace
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "settings.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir or root_dir == "" then
	root_dir = vim.fn.getcwd()
end
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- Debug + test bundles (from Mason) so nvim-dap can debug/run JUnit tests
local bundles = {}
local java_debug =
	vim.fn.glob(mason .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if java_debug ~= "" then
	table.insert(bundles, java_debug)
end
vim.list_extend(bundles, vim.split(vim.fn.glob(mason .. "/packages/java-test/extension/server/*.jar", true), "\n"))

-- IMPORTANT: tell jdtls to send auto-import edits (additionalTextEdits)
-- during completionItem/resolve. Without this, selecting `List` completes
-- the word but never adds `import java.util.List;` at the top.
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher,
		"-configuration",
		jdtls_path .. "/" .. os_config,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	capabilities = require("nvchad.configs.lspconfig").capabilities,
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
	settings = {
		java = {
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			references = { includeDecompiledSources = true },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.Assert.*",
					"org.mockito.Mockito.*",
					"java.util.Objects.requireNonNull",
				},
			},
			sources = {
				organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
			},
		},
	},
	on_attach = function(_, bufnr)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Java " .. desc })
		end

		-- Enable DAP for Java (debugging + test running)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		pcall(function()
			require("jdtls.dap").setup_dap_main_class_configs()
		end)

		-- Java-only refactors/actions
		map("n", "<leader>jo", jdtls.organize_imports, "organize imports")
		map("n", "<leader>jv", jdtls.extract_variable, "extract variable")
		map("v", "<leader>jm", function()
			jdtls.extract_method(true)
		end, "extract method")
		map("n", "<leader>jc", jdtls.extract_constant, "extract constant")
		map("n", "<leader>jt", jdtls.test_nearest_method, "test method")
		map("n", "<leader>jT", jdtls.test_class, "test class")
	end,
}

jdtls.start_or_attach(config)

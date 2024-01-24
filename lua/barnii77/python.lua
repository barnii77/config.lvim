-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  local conda_prefix = os.getenv("CONDA_PREFIX")
  if conda_prefix then  -- if conda_prefix is not nil, use conda python
    require("dap-python").setup(conda_prefix .. "/bin/python")
  else
    require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
  end
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

function InitPyrightConfig()
  local content = '{"executionEnvironments": [{"root": "./"}]}'
  local filepath = "pyrightconfig.json"
  local file = io.open(filepath, "r")
  if not file then
    -- If the file does not exist, create and write to it
    file = io.open(filepath, "w")
    if file == nil then
      vim.api.nvim_command('echo "error creating pyrightconfig.json"')
    else
      file:write(content)
      file:close()
      vim.api.nvim_command('echo "pyrightconfig.json created"')
    end
  else
    -- If the file already exists, close it and notify the user
    vim.api.nvim_command('echo "file already exists"')
    file:close()
  end
end

vim.api.nvim_create_user_command('InitPyrightConfig', InitPyrightConfig, { nargs = 0 })

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


-- binding for switching
lvim.builtin.which_key.mappings["P"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
  d = { "<cmd>Docstring<cr>", "Docstring" },
  i = { "<cmd>PyrightOrganizeImports<cr>", "Organize Imports" },
  r = { "<cmd>terminal python %<cr>", "Run current file" },
  a = { "<cmd>InitPyrightConfig<cr>", "Auto-init pyrightconfig" },
}

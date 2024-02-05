-- This file handles all dap stuff (because there are conflicts between the individual language files so the on_config_done functions have to be fused)

function VirtualTextDisplayCallback(variable, buf, stackframe, node, options)
  if options.virt_text_pos == 'inline' then
    return ' = ' .. variable.value
  else
    return ' => ' .. variable.name .. ' = ' .. variable.value
  end
end

require("nvim-dap-virtual-text").setup {
  display_callback = VirtualTextDisplayCallback,
}

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local codelldb_path = mason_path .. "bin/codelldb"
local liblldb_path = mason_path .. "packages/codelldb/extension/lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname

-- The path in windows is different
if this_os:find "Windows" then
  codelldb_path = mason_path .. "packages\\codelldb\\extension\\adapter\\codelldb.exe"
  liblldb_path = mason_path .. "packages\\codelldb\\extension\\lldb\\bin\\liblldb.dll"
else
  -- The liblldb extension is .so for linux and .dylib for macOS
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end


lvim.builtin.dap.on_config_done = function(dap)
  -- codelldb
  dap.adapters.codelldb = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

  -- Rust
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  -- C/C++
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local path
        vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
          path = input
        end)
        vim.cmd [[redraw]]
        return path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp
end

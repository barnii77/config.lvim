-- collect plugins
local plugin_data = require("barnii77.plugins")
lvim.plugins = plugin_data.plugins

-- Initialize different languages + general setup
require("barnii77.dap")
require("barnii77.python")
require("barnii77.cpp")
require("barnii77.rust")
require("barnii77.setup").setup(plugin_data.states)

-- NOTE: might come back to this later but for now, just put all plugins in a separate file

-- now fuse the plugins the individual modules require into one
-- NOTE: I am sorting the plugins from least to most important (left = least, right = most)
-- This is because the rightmost will always overwrite the leftmost, and the most important
-- should overwrite the least important
-- lvim.plugins = vim.tbl_deep_extend("force", python_plugins, rust_plugins, general_plugins)

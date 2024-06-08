-- collect plugins
local plugin_data = require("barnii77.plugins")
lvim.plugins = plugin_data.plugins

-- Initialize different languages + general setup
require("barnii77.dap")
-- require("barnii77.haskell")
require("barnii77.python")
require("barnii77.cpp")
require("barnii77.rust")
require("barnii77.setup").setup(plugin_data.states)

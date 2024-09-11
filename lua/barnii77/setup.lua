local M = {}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999 -- this makes it so the cursor is always centered
vim.opt.undofile = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "toml",
}

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.keymap.set("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>")

-- custom keybindings
vim.keymap.set("i", "<C-l>", "<Esc>")
vim.keymap.set("v", "<C-l>", "<Esc>")

vim.opt.linebreak = true

-- google search functionality with w3m

local function ProcessGoogleSearch(query)
  -- replace spaces with + in query
  if query == nil or query == "" then
    return
  end
  query = query:gsub(" ", "+")
  local url = "https://www.google.com/search?q=" .. query
  vim.cmd.terminal("w3m " .. url)
end

local function Google()
  vim.ui.input({ prompt = "Query: " }, ProcessGoogleSearch)
end

vim.api.nvim_create_user_command('Google', Google, { nargs = 0 })

-- custom keybindings in treesitter
lvim.builtin.which_key.mappings["U"] = {
  "<cmd>UndotreeToggle<cr>", "UndoTree"
}

-- swap model for chatgpt plugin

function M.setup(plugin_states)
  local function ChatGPTSetInfo(model, api_key, endpoint)
    local chatgpt_api = require("chatgpt.api")
    chatgpt_api.CHAT_COMPLETIONS_URL = endpoint
    chatgpt_api.OPENAI_API_KEY = api_key
    chatgpt_api.AUTHORIZATION_HEADER = "Authorization: Bearer " .. chatgpt_api.OPENAI_API_KEY
    plugin_states.chatgpt_plugin_state.model = model
  end

  -- create chatgpt user commands
  vim.api.nvim_create_user_command('ChatGPTUse4',
    function()
      ChatGPTSetInfo("gpt-4o", os.getenv("OPENAI_API_KEY"),
        "https://api.openai.com/v1/chat/completions")
    end, { nargs = 0 })
  vim.api.nvim_create_user_command('ChatGPTUse3x5',
    function()
      ChatGPTSetInfo("gpt-3.5-turbo-16k", os.getenv("OPENAI_API_KEY"),
        "https://api.openai.com/v1/chat/completions")
    end, { nargs = 0 })
  vim.api.nvim_create_user_command('ChatGPTUseMixtral8x7bGroq',
    function()
      ChatGPTSetInfo("llama3-70b-8192", os.getenv("GROQ_API_KEY"),
        "https://console.groq.com/openai/v1/chat/completions")
    end, { nargs = 0 })
  vim.api.nvim_create_user_command('ChatGPTPrintModel',
    function() vim.notify("Currently using " .. plugin_states.chatgpt_plugin_state.model .. " for ChatGPT") end,
    { nargs = 0 })
end

-- toggle function
local function VimOptToggle(opt)
  local message = opt
  if vim.opt[opt]:get() then
    vim.opt[opt] = false
    message = message .. " Disabled"
  else
    vim.opt[opt] = true
    message = message .. " Enabled"
  end
  vim.notify(message)
end

vim.api.nvim_create_user_command('ToggleWrap', function() VimOptToggle("wrap") end, { nargs = 0 })

-- set shortcuts for utils category

lvim.builtin.which_key.mappings["r"] = { "<cmd>mod<cr>", "clear & redraw" }

lvim.builtin.which_key.mappings["u"] = {
  name = "Utils",
  t = {
    "<cmd>terminal<cr>", "Terminal"
  },
  c = {
    name = "ChatGPT utils",
    a = { "<cmd>ChatGPTUse4<cr>", "use GPT-4" },
    b = { "<cmd>ChatGPTUse3x5<cr>", "use GPT-3.5" },
    c = { "<cmd>ChatGPTUseMixtral8x7bGroq<cr>", "use Mixtral-8x7b (Groq)" },
    k = { "<cmd>ChatGPT<cr>", "new chat" }, -- note that k doesn't stand for anything, it is simple a comfortable key
    p = { "<cmd>ChatGPTPrintModel<cr>", "print model" },
  },
  w = { "<cmd>ToggleWrap<cr>", "Toggle wrapping" },
  g = { "<cmd>Google<cr>", "Google" },
  f = {
    name = "Typofix",
    c = {
      "<cmd>TypoFixCreate<cr>", "Create TypoFix"
    },
    r = {
      "<cmd>TypoFixDelete<cr>", "Remove TypoFix"
    },
    e = {
      "<cmd>TypoFixEnable<cr>", "Enable TypoFix"
    },
    d = {
      "<cmd>TypoFixDisable<cr>", "Disable TypoFix"
    },
    l = {
      "<cmd>TypoFixList<cr>", "List TypoFixes"
    }
  },
}

return M

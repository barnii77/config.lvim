vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999 -- this makes it so the cursor is always centered
vim.opt.undofile = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "toml",
}

vim.keymap.set("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>")

-- custom keybindings
vim.keymap.set("i", "<c-l>", "<Esc>")
vim.keymap.set("v", "<c-l>", "<Esc>")
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Leader>sg", vim.cmd.Google)
vim.keymap.set("n", "<Leader>t", vim.cmd.terminal)


-- google search functionality with w3m

function ProcessGoogleSearch(query)
  -- replace spaces with + in query
  query = query:gsub(" ", "+")
  local url = "https://www.google.com/search?q=" .. query
  vim.cmd.terminal("w3m " .. url)
end

function Google()
  vim.ui.input({ prompt = "Query: " }, ProcessGoogleSearch)
end

vim.api.nvim_create_user_command('Google', Google, { nargs = 0 })

-- custom keybindings in treesitter
lvim.builtin.which_key.mappings["U"] = {
  "<cmd>UndotreeToggle<cr>", "UndoTree"
}

lvim.builtin.which_key.mappings["sg"] = {
  "<cmd>Google<cr>", "Google"
}

-- swap model for chatgpt plugin

function SetModelGPT4()
  require("chatgpt").setup({
    openai_params = {
      model = "gpt-4-1106-preview",
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4095,
      temperature = 0.2,
      top_p = 0.1,
      n = 1,
    }
  })
end

function SetModelGPT3_5()
  require("chatgpt").setup({
    openai_params = {
      model = "gpt-3.5-turbo-16k",
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4095,
      temperature = 0.2,
      top_p = 0.1,
      n = 1,
    }
  })
end

-- create chatgpt user commands
vim.api.nvim_create_user_command('ChatGPTUse4', SetModelGPT4, { nargs = 0 })
vim.api.nvim_create_user_command('ChatGPTUse3x5', SetModelGPT3_5, { nargs = 0 })

-- set shortcuts for utils category

lvim.builtin.which_key.mappings["u"] = {
  name = "Utils",
  t = {
    "<cmd>terminal<cr>", "Terminal"
  },
  c = {
    name = "ChatGPT utils",
    a = { "<cmd>ChatGPTUse4<cr>", "use GPT-4" },
    b = { "<cmd>ChatGPTUse3x5<cr>", "use GPT-3.5" },
    k = { "<cmd>ChatGPT<cr>", "new chat" }, -- note that k doesn't stand for anything, it is simple a comfortable key
  }
}

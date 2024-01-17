vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999  -- this makes it so the cursor is always centered
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
lvim.builtin.which_key.mappings["u"] = {
  "<cmd>UndotreeToggle<cr>", "UndoTree"
}

lvim.builtin.which_key.mappings["s"]["g"] = {
  "<cmd>Google<cr>", "Google"
}

lvim.builtin.which_key.mappings["t"] = {
  "<cmd>terminal<cr>", "Terminal"
}

local harpoon = require("harpoon")
harpoon:setup()

vim.api.nvim_create_user_command('HarpoonAppend', function() harpoon:list():append() end, { nargs = 0 })

lvim.builtin.which_key.mappings["a"] = {
  "<cmd>HarpoonAppend<cr>", "Append to Harpoon"
}
vim.keymap.set("n", "<C-s>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-y>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-x>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-m>", function() harpoon:list():select(3) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)

This repository contains my lunarvim config. I am new to neovim, so it is very minimalistic. I used starter.lvim as a starting point, then added my own plugins and adjustments to it.

# Setup
In case anyone wants to copy this, they might first need to manually install codelldb somewhere and adjust the path in the beginning of the file (variables codelldb_path and liblldb_path, potentially also remove mason_path and replace with some other hardcoded one).
Apart from that, a lot of things should work out of the box, others might require some setup. For example, the chatgpt plugin requires you to give it access to your openai api key, and my Google command requires w3m.

# Keymaps
I added <C-l> (Ctrl + l) as an alias to <Esc> (Escape) because <C-c> (Ctrl + c) has some special properties and doesnt work properly with the autosave plugin, whereas Escape does.

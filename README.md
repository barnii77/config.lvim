# General Info
This repository contains my lunarvim config. I am new to neovim, so it is very minimalistic. I used starter.lvim as a starting point, then added my own plugins and adjustments to it.

# Setup
In case anyone wants to copy this, they might first need to manually install codelldb somewhere and adjust the path in the beginning of the file (variables codelldb_path and liblldb_path, potentially also remove mason_path and replace with some other hardcoded one).
Apart from that, a lot of things should work out of the box, others might require some setup. For example, the chatgpt plugin requires you to give it access to your openai api key, and my Google command requires w3m.

# Keymaps
I added <C-l> (Ctrl + l) as an alias to <Esc> (Escape) because <C-c> (Ctrl + c) has some special properties and doesnt work properly with the autosave plugin, whereas Escape does.
Also, <Leader>sg is google and <Leader>u toggles the undo tree.

| Key Mapping  | Description              |
|--------------|--------------------------|
| `<C-l>`      | Alias for `<Esc>`        |
| `<Leader>sg` | Google search            |
| `<Leader>u`  | Toggle the undo tree     |

# Plugins
| Plugin                                           | Type                   | Configuration                                                                                                                                                      |
|--------------------------------------------------|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ChristianChiarulli/swenv.nvim                    | Python                 | -                                                                                                                                                                  |
| stevearc/dressing.nvim                            | Python                 | -                                                                                                                                                                  |
| mfussenegger/nvim-dap-python                      | Python                 | -                                                                                                                                                                  |
| nvim-neotest/neotest                              | Python                 | -                                                                                                                                                                  |
| nvim-neotest/neotest-python                       | Python                 | -                                                                                                                                                                  |
| simrat39/rust-tools.nvim                          | Rust                   | -                                                                                                                                                                  |
| saecki/crates.nvim                                | Rust                   | Version: v0.3.0<br>Dependencies: nvim-lua/plenary.nvim<br>Config: `crates` setup with null_ls and popup configurations                                              |
| j-hui/fidget.nvim                                 | Rust                   | Config: `fidget` setup                                                                                                                                            |
| 0x00-ketsu/autosave.nvim                          | Language Independent   | Lazy-loading on events: "InsertLeave", "TextChanged"<br>Config: `autosave` setup                                                                                   |
| zbirenbaum/copilot-cmp                           | Language Independent   | Event: "InsertEnter"<br>Dependencies: zbirenbaum/copilot.lua<br>Config: Github copilot setup                                                                      |
| jackMort/ChatGPT.nvim                             | Language Independent   | Event: "VeryLazy"<br>Config: ChatGPT setup with openai_params<br>Dependencies: MunifTanjim/nui.nvim, nvim-lua/plenary.nvim, nvim-telescope/telescope.nvim         |
| smoka7/multicursors.nvim                          | Language Independent   | Event: "VeryLazy"<br>Dependencies: smoka7/hydra.nvim<br>Cmd: MCstart, MCvisual, MCclear, MCpattern, MCvisualPattern, MCunderCursor                                  |
| folke/noice.nvim                                  | Language Independent   | Event: "VeryLazy"<br>Opts: -<br>Routes: View "notify" with filter event "msg_showmode"<br>Dependencies: MunifTanjim/nui.nvim, rcarriga/nvim-notify (optional)   |
| nvim-lualine/lualine.nvim                         | Language Independent   | Config: `lualine` setup with a custom section for statusline_x<br>Dependency: noice for statusline mode integration                                               |


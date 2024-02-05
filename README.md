# LunarVim Configuration

## Overview

My LunarVim configuration for Python and Rust development, featuring essential plugins and keybindings.

## Setup

Ensure required tools are installed and paths are configured for Python and Rust development.

## Keymaps

| Key Mapping  | Description                    |
|--------------|--------------------------------|
| `<Leader>u`  | Prefix for all the utils       |
| `<Leader>ut` | Open terminal                  |
| `<Leader>sg` | Initiate Google search         |
| `<Leader>U`  | Toggle UndoTree                |
| `<Leader>uc` | ChatGPT plugin shortcuts       |

### Python Keybindings

| Key Mapping  | Description            |
|--------------|------------------------|
| `<Leader>Pc` | Choose Python venv                 |
| `<Leader>Pd` | Generate Python docstring template |
| `<Leader>ds` | Start Python debugging             |
| `<Leader>Pi` | Organize python imports            |
| `<Leader>Pa` | Auto-generate pyrightconfig.json for analysis |
| `<Leader>Pr` | Run current file in new console    |

### Rust Keybindings

| Key Mapping  | Description              |
|--------------|--------------------------|
| `<Leader>R`  | Access Rust commands     |
| `<Leader>Rr` | Run Rust runnables       |
| `<Leader>Rt` | Run Rust tests           |
| `<Leader>Rd` | Start Rust debugging     |

### Debugger Shortcuts

| Key Mapping  | Description                       |
|--------------|-----------------------------------|
| `<Leader>do` | Step Over                         |
| `<Leader>di` | Step Into                         |
| `<Leader>du` | Step Out                          |
| `<Leader>dc` | Continue                          |
| `<Leader>dC` | Run to Cursor                     |
| `<Leader>dq` | Stop Debugging                    |
| `<Leader>dU` | Toggle Debugging UI               |
| `<Leader>ds` | Start Debugging (Rust: `<Leader>Rd` for better Rust debugging) |

## Plugins

| Plugin                           | Type    | Description                                                       | Configuration                        |
|----------------------------------|---------|-------------------------------------------------------------------|--------------------------------------|
| `swenv.nvim`                     | Python  | -                                                                 | -                                    |
| `dressing.nvim`                  | Python  | -                                                                 | -                                    |
| `nvim-dap-python`                | Python  | -                                                                 | -                                    |
| `neotest`                        | Python  | -                                                                 | -                                    |
| `vim-python-docstring`           | Python  | -                                                                 | -                                    |
| `rust-tools.nvim`               | Rust    | -                                                                 | -                                                                    |
| `crates.nvim`                   | Rust    | Version: v0.3.0, Dependencies: nvim-lua/plenary.nvim               | Config: `crates` setup with null_ls and popup configurations           |
| `fidget.nvim`                   | Rust    | Config: `fidget` setup                                             | Config: `fidget` setup                                                 |
| `autosave.nvim`                  | General | Lazy auto-saving on events                                        | Lazy-loading on events: "InsertLeave", "TextChanged"                    |
| `copilot-cmp`                    | General | Github copilot                                                     | Event: "InsertEnter", Dependencies: `copilot.lua`, Config: Github copilot setup | Event: "InsertEnter", Dependencies: `copilot.lua`, Config: Github copilot setup |
| `ChatGPT.nvim`                   | General | ChatGPT plugin (requires environment variable)                     | Event: "VeryLazy", Config: ChatGPT setup with openai_params, Dependencies: `nui.nvim`, `plenary.nvim`, `telescope.nvim` | Event: "VeryLazy", Config: ChatGPT setup with openai_params, Dependencies: `nui.nvim`, `plenary.nvim`, `telescope.nvim` |
| `multicursors.nvim`              | General | Multi-Cursor support (press v then <Leader>m then j or k)          | Event: "VeryLazy", Dependencies: `hydra.nvim`, Cmd: MCstart, MCvisual, MCclear, MCpattern, MCvisualPattern, MCunderCursor | Event: "VeryLazy", Dependencies: `hydra.nvim`, Cmd: MCstart, MCvisual, MCclear, MCpattern, MCvisualPattern, MCunderCursor |
| `noice.nvim`                     | General | Nice Modern vim-command-line UI + popups for error messages etc.   | Event: "VeryLazy", Opts: -, Routes: View "notify" with filter event "msg_showmode", Dependencies: `nui.nvim`, `nvim-notify` (optional) | Event: "VeryLazy", Opts: -, Routes: View "notify" with filter event "msg_showmode", Dependencies: `nui.nvim`, `nvim-notify` (optional) |
| `lualine.nvim`                   | General | Statusline for noice.nvim so it can show some text while recording macros | Dependency: noice for statusline mode integration | Config: `lualine` setup with a custom section for statusline_x, Dependency: noice for statusline mode integration |
| `undotree`       | General | Visualize and manage undo history  | -                                  |
| `vim-be-good`    | General | Practice Vim motions and commands  | -                                  |

## Additional Functionality

- **Google Search**: Initiate a search from Neovim
- **ChatGPT Integration**: Switch between GPT-4 and GPT-3.5
- **Utils Category**: Explore utilities with `<Leader>u`

## Additional Notes
using :retab n you can change tabs to n spaces

e goes to end of word, w goes to start of next word
Use `gl` to see diagnostics for current line 
Use `gd` to go to definition
Use `gr` to go to references
S = cc
cc change whole line
`:ma [a-z]` sets a mark
`'[a-z]` goes to line of a mark
`d'[a-z]` deletes up to that mark
`CTRL-o` goes to last cursor location (before 9j or something)
`CTRL-i` goes to next cursor location after `CTRL-o` has (repeatedly) been used
find using `f[character]`, eg: `f.`
`v` starts visual character mode
`V` starts visual line mode
`R` multi-character replace
`r`single char replace
`U` reverses all changes on last changed line
`"` does something with a register (like `'` does something with a marker)

deleting:
:d _ throws away stuff and does not save to clipboard

append to a register by using the capital letter instead of lowercase
eg
`"ayy` yanks line into a
`"Ayy` appends line to a

to change a macro, paste the content of register then modify it and yank it again, then just run it as macro
eg:
`"jp`
$dl
`modify`
$dldl
`"jyy`
`@j` to run

When replacing, use flag g to replace everything not just first occurance
eg:
`:%s/fun/fn` replaces first occurance in line
`:%s/fun/fn/g` replaces every occurance

use `.` to run command only on current line
eg:
`:.w file.txt` saves only changes in current line to file
you can also add to it eg `.+4`

You can also write with range:
`:3,14w file.txt`

visual selection
use the markers `'<` for start of selection and `'>` for end of selection

global command
`:[range]g/pattern/command`
this executes command on every occurance of pattern

guu makes all line lowercase
gUU makes all line uppercase

`:0read !ls` inserts output of ls command at line 0 of file

match beginning and end of word with \[ and \], ^ and $ are start/end of line

normal mode J will join 2 lines together
J = "$lXa "


open a file in hex mode (binary mode) using -b
v -b file.txt

## Conclusion

If you are starting out with LunarVim and trying to get started quickly with a decently simple and reasonable configuration, I think you could consider using my config.
Also, if you are struggling with or just annoyed by the setup process and you use Debian, Ubuntu or Kali Linux, check out my [instant.lvim](https://github.com/barnii77/instant.lvim) repo for making installation a one-liner.

# TODO
- Add some insert abbreviations (:help abbreviations) using the ia command
    - Eg: :ia teh the (replaces teh with the when it is typed out)

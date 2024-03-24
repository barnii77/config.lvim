local M = {}

local states = {
  chatgpt_plugin_state = {
    model = "gpt-3.5-turbo-16k",
  },
}

local plugins = {
  -- C/C++ plugins
  "p00f/clangd_extensions.nvim",

  -- Python plugins

  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
    }
  },
  "nvim-neotest/neotest-python",
  "pixelneo/vim-python-docstring",

  -- Rust plugins

  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },


  -- Language independent plugins

  -- Auto Saving
  {
    '0x00-ketsu/autosave.nvim',
    -- lazy-loading on events
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require('autosave').setup {

      }
    end
  },
  -- Github copilot
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
  --       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
  --     end, 100)
  --   end,
  -- },
  -- ChatGPT
  {
    -- use my fork of the chatgpt plugin (for now)
    -- TODO: switch to jackMort/ChatGPT.nvim once my pull request has been accepted
    "barnii77/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "printenv -0 OPENAI_API_KEY",
        openai_params = {
          model = function() return states.chatgpt_plugin_state.model end, -- function() return M.state.chatgpt_plugin_state.model end,
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- Multicursor
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  -- Nicer Terminal
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("lualine").setup {
        sections = {
          lualine_x = {
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            }
          },
        },
      }
    end
  },
  -- undotree
  "mbbill/undotree",

  -- VimBeGood
  "ThePrimeagen/vim-be-good",

  -- virtual text for debugging
  "theHamsta/nvim-dap-virtual-text",

  -- harpoon
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("barnii77.harpoon_config")
  --   end,
  -- },

  -- typofix (my typo manager)
  {
    "barnii77/typofix.nvim",
    opts = {
      path = "$HOME/.config/lvim/.typofix/iabbrev.vim",
    }
  },

  -- lcaml (my esoteric programming language)
  -- {
  --   "barnii77/lcaml.nvim",
  --   config = function()
  --     require("lcaml").init()
  --   end,
  -- },

  "tpope/vim-surround",
}

M.states = states
M.plugins = plugins

return M

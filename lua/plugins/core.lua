return {
  -- Set colorscheme
  { "LazyVim/LazyVim", opts = {
    colorscheme = "catppuccin",
  } },

  -- Vim Motion
  {
    "phaazon/hop.nvim",
    name = "hop.nvim",
    lazy = true,
    event = "VeryLazy",
    branch = "v2",
    config = function()
      local hop = require("hop")

      hop.setup({ keys = "asdfghjkl" })

      local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end, { remap = true })
    end,
  },

  -- Surround texts
  {
    "kylechui/nvim-surround",
    name = "nvim-surround",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Easy navigation out of braces and quotation marks
  -- Read the documentation for more info on these options
  {
    "abecodes/tabout.nvim",
    name = "tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
        act_as_tab = true,
        act_as_shift_tab = false,
        default_tab = "<C-t>",
        default_shift_tab = "<C-d>",
        enable_backwards = true,
        completion = true,
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "*", close = "*" },
        },
        ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "text",
        }, -- tabout will ignore these filetypes
      })
    end,
  },

  -- Remove default options
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- Use Visual Studio code like mapping for autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behaviour = cmp.SelectBehaviour.Select })
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- Automatically highlight colors in nvim
  {
    "brenoprata10/nvim-highlight-colors",
    name = "nvim-highlight-colors",
    lazy = false,
    config = function()
      require("nvim-highlight-colors").setup({
        enable_tailwind = true,
        enable_named_colors = true,
      })
    end,
  },

  -- Comment out code with keybindings
  {
    "numToStr/Comment.nvim",
    name = "Comment.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = false,
        ignore = nil,
        toggler = {
          line = "<leader>/",
          block = "<leader>\\",
        },
        opleader = {
          line = "<leader>/",
          block = "<leader>\\",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- Add cats to nvim (very important)
  {
    "giusgad/pets.nvim",
    name = "pets.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = { "edluffy/hologram.nvim" },
    config = function()
      require("pets").setup({})
    end,
  },
}

vim.opt_global.scrolloff = 4

-- Codeium bindings
lvim.keys.insert_mode["<Home>"] = "<cmd>call codeium#CycleCompletions(1)<CR>"
lvim.keys.insert_mode["<End>"] = "<cmd>call codeium#CycleCompletions(-1)<CR>"
lvim.keys.insert_mode["<PageDown>"] = "<cmd>call codeium#Clear()<CR>"
-- Disable codeium
-- vim.opt_global.codeium_disable_bindings = 1
lvim.builtin.treesitter.rainbow.enable = true

-- Resize with arrows
lvim.keys.normal_mode["\\j"] = ":resize -2<CR>"
lvim.keys.normal_mode["\\k"] = ":resize +2<CR>"
lvim.keys.normal_mode["\\l"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["\\h"] = ":vertical resize +2<CR>"
--
-- Quick buffer switching
lvim.keys.normal_mode["H"] = "<CMD>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["L"] = "<CMD>BufferLineCycleNext<CR>"

-- nvim-tree.update_focused_file.update_root*

-- Centers cursor when moving 1/2 page down
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
-- Centers cursor when moving a page down
lvim.keys.normal_mode["<C-f>"] = "<C-f>zz"
-- Centers cursor when moving 1/2 page up
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
-- Centers cursor when moving a page up
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"

-- Ignore accidentally pressing F1
lvim.keys.normal_mode["<F1>"] = "<ESC>"

-- I like the old "Y" yanking
lvim.keys.normal_mode["Y"] = "yy"

-- Line movement
lvim.keys.normal_mode["-"] = "ddp"
lvim.keys.normal_mode["_"] = "ddkP"

-- Surround words with characters
lvim.keys.normal_mode['<leader>"'] = 'viw<ESC>a"<ESC>bi"<ESC>lel'
lvim.keys.normal_mode["<leader>'"] = "viw<ESC>a'<ESC>bi'<ESC>lel"
lvim.keys.normal_mode["<leader>["] = "viw<ESC>a]<ESC>bi[<ESC>lel"
lvim.keys.normal_mode["<leader>("] = "viw<ESC>a)<ESC>bi(<ESC>lel"
lvim.keys.normal_mode["<leader>{"] = "viw<ESC>a}<ESC>bi{<ESC>lel"
lvim.keys.normal_mode["<leader><"] = "viw<ESC>a><ESC>bi<<ESC>lel"

-- Toggle search highlightining
lvim.keys.normal_mode["<leader>h"] = "<cmd>set hlsearch!<CR>"

-- Which key additions
lvim.builtin.which_key.mappings["gB"] = {
  "<cmd>Git blame<CR>",
  "Git Blame",
}
lvim.builtin.which_key.mappings["gw"] = {
  name = "Git Worktrees",
  a = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Add" },
  l = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "List" },
}
lvim.builtin.which_key.mappings["G"] = {
  "<cmd>topleft Git<CR>",
  "Git",
}
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>Telescope projects<CR>",
  "Projects",
}
lvim.builtin.which_key.mappings["B"] = {
  "<cmd>Telescope buffers<CR>",
  "Open Buffers",
}
lvim.builtin.which_key.mappings["sB"] = {
  "<cmd>Telescope current_buffer_fuzzy_find<CR>",
  "fuzzy find open buffers",
}
lvim.builtin.which_key.mappings["T"] = {
  "<cmd>16split <bar> botright terminal<CR>",
  "Open terminal at bottom",
}
lvim.builtin.which_key.mappings["u"] = {
  "<cmd>UndotreeToggle<CR>",
  "undotree",
}

-- lvim.colorscheme = "gruvbox-baby"

lvim.autocommands = {
  {
    "BufWritePre",
    {
      pattern = { "*" },
      command = [[:%s/\s\+$//e]],
    },
  },
  {
    "FileType",
    {
      pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
      callback = function()
        vim.cmd [[
          nnoremap <silent> <buffer> q :close<CR>
          set nobuflisted
        ]]
      end,
    },
  },
}

-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { name = "gofumpt" },
  { name = "rubocop" },
  { name = "shellharden" },
  { name = "stylua" },
  -- {
  --   name = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespace
  --   -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
  --   args = { "--print-width", "100" },
  --   ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
}
lvim.format_on_save.enabled = true

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "actionlint" },
  { name = "golangci_lint" },
  -- { name = "rubocop" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
  -- { name = "tflint" },
}

lvim.plugins = {
  -- Telescope extensions
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "telescope.nvim",
    },
    config = function()
      require("telescope").setup {
        extensions = {
          project = {
            base_dirs = { { path = "~/opslevel/", max_depth = 2 } },
            hidden_files = true, -- default: false
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
            -- default for on_project_selected = find project files
            on_project_selected = function(prompt_bufnr)
              -- Do anything you want in here. For example:
              require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
            end,
          },
        },
      }
    end,
  },
  -- UndoTree
  { "mbbill/undotree" },
  -- nvim-ts-rainbow
  { "mrjones2014/nvim-ts-rainbow" },
  -- Glow
  { "ellisonleao/glow.nvim" },
  -- nvim-dap-go
  { "leoluz/nvim-dap-go" },
  -- Gruvbox
  { "luisiacc/gruvbox-baby" },
  -- Codeium
  { "Exafunction/codeium.vim" },
  -- neodev
  { "folke/neodev.nvim" },
  -- telescope-dap
  { "nvim-telescope/telescope-dap.nvim" },
  -- git worktree goodness
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      require("git-worktree").setup {
        change_directory_command = "cd", -- default: "cd",
        update_on_change = true, -- default: true,
        update_on_change_command = "e .", -- default: "e .",
        clearjumps_on_change = true, -- default: true,
        autopush = false, -- default: false,
      }
      require("telescope").load_extension "git_worktree"
    end,
  },
  -- sourcegraph sg
  -- {
  --   "sourcegraph/sg.nvim",
  --   build = "cargo build --workspace",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  -- tpope goodness
  { "tpope/vim-rails" },
  { "tpope/vim-fugitive" },
  -- octo stuff
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
}

local status_ok, dap_go = pcall(require, "dap-go")
if status_ok then
  dap_go.setup()
end

local glow_status_ok, glow = pcall(require, "glow")
if glow_status_ok then
  glow.setup {
    width = 160,
  }
end

require("neodev").setup {
  library = {
    types = true,
    plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
}

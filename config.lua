vim.opt_global.scrolloff = 4

-- Resize with arrows
lvim.keys.normal_mode["\\j"] = ":resize -2<CR>"
lvim.keys.normal_mode["\\k"] = ":resize +2<CR>"
lvim.keys.normal_mode["\\l"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["\\h"] = ":vertical resize +2<CR>"

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
lvim.keys.normal_mode["<leader>\""] = "viw<ESC>a\"<ESC>bi\"<ESC>lel"
lvim.keys.normal_mode["<leader>'"] = "viw<ESC>a'<ESC>bi'<ESC>lel"
lvim.keys.normal_mode["<leader>["] = "viw<ESC>a]<ESC>bi[<ESC>lel"
lvim.keys.normal_mode["<leader>("] = "viw<ESC>a)<ESC>bi(<ESC>lel"
lvim.keys.normal_mode["<leader>{"] = "viw<ESC>a}<ESC>bi{<ESC>lel"
lvim.keys.normal_mode["<leader><"] = "viw<ESC>a><ESC>bi<<ESC>lel"

-- Toggle search highlightining
lvim.keys.normal_mode["<leader>h"] = "<cmd>set hlsearch!<CR>"

-- Which key additions
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}
lvim.builtin.which_key.mappings["B"] = {
  "<cmd>Telescope buffers<CR>", "Open Buffers"
}
lvim.builtin.which_key.mappings["sB"] = {
   "<cmd>Telescope current_buffer_fuzzy_find<CR>", "fuzzy find open buffers"
}
lvim.builtin.which_key.mappings["T"] = {
   "<cmd>16split <bar> botright terminal<CR>", "Open terminal at bottom"
}
lvim.builtin.which_key.mappings["u"] = {
   "<cmd>UndotreeToggle<CR>", "undotree"
}

-- lvim.colorscheme = "gruvbox-baby"

lvim.autocommands = {
  {
    "BufWritePre",
    {
      pattern = { "*" },
      command = [[:%s/\s\+$//e]],
    }
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
    }
  },
}

--
-- local banner = {
--   "                             .^!?7^.                             ",
--   "                         .:!?JJ?!?JJ?!^.                         ",
--   "                      :~7?J?7^:   :^7?J?7~:                      ",
--   "                   .~?JJJ~.           :~?JJ?~                    ",
--   "                   .7JJ?J7!^.       .^!7JJJJ?.                   ",
--   "                   :7J?:^!?JJ?!:.:~?JJ?!^^?J?:                   ",
--   "               .:~7?JJ?.   :~7?J?J?7~:   .?JJJ7~:.               ",
--   "            .^7?JJJ??J?.      .?J?.      .?J?7?JJ?7~.            ",
--   "        .^!?JJJ7~^..7J?.      .7J?.      .?J7..^!7JJJ?!^:        ",
--   "       !JJJ?!^:    .7JJ~:     .7J?.     .~?J7.    :^7?JJJ7       ",
--   "      .?JJ~         :!7JJ?!^. .7J?. .^!?JJ7~:         !JJJ       ",
--   "      .?JJ:            .^!?JJ?!?J?!7JJ?!^.            ~JJ?       ",
--   "      .?JJ^                :~7?JJJ?!^:                ~JJ?       ",
--   "      .?JJ:  .:.              .:~^.              .::  ~JJ?       ",
--   "      .?JJ!~7JJ?!^.                           :^!?JJ?~!JJ?       ",
--   "     .^?JJJ?!^^!?JJ?!^.                   .^!?JJ?~^^!?JJJJ:.     ",
--   "  .^!?J?7~:.     .~7???7!:             :~7?J?!^.     .:~7???!~.  ",
--   " :JJJJ?:.           .!JJJJ~           ~JJJJ!.            ^7JJJ?: ",
--   " :JJ?7JJ?!^:    .:!7JJ77JJ!           ~JJ7?J?7!^.    .^!?J?7?JJ^ ",
--   " :JJ! .^!?JJ?~~7?J?7~: ^JJ~           ~J?: :~!?JJ7~~7JJ?!^. !J?^ ",
--   " :JJ!     :~7JJ?~:.    ^JJ~           ~J?:    .:~?JJ7^:     !J?^ ",
--   " :JJ!       :JJ!       ^JJ~           ~J?:       !JJ^       !J?^ ",
--   " :JJ!       :JJ!       ^JJ!           ~J?^       !JJ^       !JJ^ ",
--   " :?JJ7~:    :JJ!    .^!?J?^           ~JJ?7^.    !JJ^   .:~7JJ?: ",
--   "  .:~?JJ?!^.:JJ!.:~7?J7!^.             .^!?J?7!:.!JJ^.^7?JJ7!:.  ",
--   "      .:!?JJ?JJ??JJJJJ!^.               .^7JJJJJ??JJ?JJ?!^.      ",
--   "          :^!??7~:.^!?JJJ7!^.       .^!7JJJ7!^.:~7J?7^.          ",
--   "             ..       .~7?JJJ?~:.:~7?JJ?7~.       ..             ",
--   "                         .:~7JJJJJJJ7~:.                         ",
--   "                             .^!7~^.                             ",
-- }

lvim.plugins = {
  -- Telescope extensions
  { "nvim-telescope/telescope-project.nvim" },
  -- UndoTree
  { "mbbill/undotree" },
  -- Glow
  { "ellisonleao/glow.nvim" },
  -- Gruvbox
  { "luisiacc/gruvbox-baby" },
}

local status_ok, glow = pcall(require, "glow")
if status_ok then
  glow.setup({
    width = 100,
 })
end

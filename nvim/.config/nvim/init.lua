local opt = vim.opt

-- GUI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.ruler = false

-- Editing
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.listchars = 'tab:>-,trail:X,precedes:<,extends:>'
opt.list = true

vim.api.nvim_set_keymap('n', 'gb', ':ls<CR>:b<Space>', {noremap = true})

-- Meta
opt.undofile = true

require 'paq' {
    -- SELF
    'savq/paq-nvim';

    -- Support
    'kyazdani42/nvim-web-devicons';
    'nvim-lua/plenary.nvim';
    'nvim-treesitter/nvim-treesitter';

    -- LSP
    'neovim/nvim-lspconfig';

    -- orgmode
    'nvim-orgmode/orgmode';

    -- GUI
    'ayu-theme/ayu-vim';
    'nvim-lualine/lualine.nvim';
    'bling/vim-bufferline';
}

-- Configure an org parser for orgmode
require'nvim-treesitter.parsers'.get_parser_configs().org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
        files = { 'src/parser.c', 'src/scanner.cc' },
    },
    filetype = 'org',
}

require'nvim-treesitter'.setup {}

require'lspconfig'.jedi_language_server.setup {}

require'orgmode'.setup {}

require'lualine'.setup {
    options = {
        icons_enabled = false,
        theme = "ayu_mirage",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = '', right = '' },
    }
}

vim.cmd [[
    let ayucolor="dark"
    colo ayu
]]

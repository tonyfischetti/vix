
vim.cmd("colorscheme lcars")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- vim.opt.signcolumn = "yes:1"    -- TODO: MAYBE!
vim.opt.undofile = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 13
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.autochdir = true
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.scrolloff = 10
vim.opt.linebreak = true
vim.opt.colorcolumn = "79"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.number = true
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 1
vim.opt.modeline = true
vim.opt.termguicolors = true
vim.opt.updatetime = 750
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.background = "dark"
vim.opt.guifont = {"Monaco for Powerline", ":h14"}
vim.opt.mouse = "a"
vim.opt.modelines = 3
vim.opt.cursorline = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g['user_emmet_leader_key'] = ","
vim.g['niji_matching_filetypes'] = {'lisp', 'scheme', 'clojure', 'racket'}
vim.g['vim_json_syntax_conceal'] = 0

-- non-legacy snipmate parser
vim.g['snipMate'] = { ['snippet_version'] = 1 }

vim.g['material_style'] = "palenight"

vim.g['goyo_width'] = "80"

vim.g['slime_target'] = "tmux"
vim.g['slime_default_config'] = [[{"socket_name": "default", "target_pane": "%1"}]]
vim.g['slime_no_mappings'] = 1

vim.g['perl_host_prog'] = "/usr/bin/perl"


vim.cmd("set omnifunc=syntaxcomplete#Complete")
vim.cmd("set completeopt+=longest,menuone,noselect")
vim.cmd("set completeopt-=preview")
vim.cmd("let g:mucomplete#chains = {}")
vim.cmd("let g:mucomplete#chains.default = ['path', 'keyn', 'omni', 'dict', 'uspl', 'snipmate']")

if vim.fn.executable('par') == 1 then
    vim.cmd('set formatprg=par\\ -w75r "rj')
end

vim.g.floaterm_width = 0.7
vim.g.floaterm_title = '  floatterm  '

vim.g.smalls_auto_jump = 1
vim.g.smalls_auto_jump_min_input_length = 3
vim.g.smalls_auto_jump_timeout = 0.5

vim.g.sql_type_default = 'sqlite'

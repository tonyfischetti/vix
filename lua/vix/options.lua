
vim.opt.number = true
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 13
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.autochdir = true
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.scrolloff = 5
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
vim.opt.updatetime = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.background = "dark"
vim.opt.guifont = "Monaco for Powerline Nerd Font Complete:h13"
vim.opt.mouse = "a"
vim.opt.modelines = 3

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


vim.cmd("colorscheme lcars")

vim.cmd("set omnifunc=syntaxcomplete#Complete")
vim.cmd("set completeopt+=longest,menuone,noselect")
vim.cmd("set completeopt-=preview")
vim.cmd("let g:mucomplete#chains = {}")
vim.cmd("let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'dict', 'uspl']")

if vim.fn.executable('par') == 1 then
    vim.cmd('set formatprg=par\\ -w75r "rj')
end



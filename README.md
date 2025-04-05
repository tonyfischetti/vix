# vix

## Introduction

vix is just a place to keep my particular (neo)vim setup and configuration
so I can easily experiment with it and clone it on different systems. It's
also, of course freely available for other use and measures will be taken
to make its installation easy for other people to use and do whatever they
want with.

## Keymaps of note

| keymap | description |
| ------ | ----------- |
| `<Space>p` | run buffer (or selection) through perl -ple |
| `<Space>P` | run buffer (or selection) through command |
| `<Leader>ee` | toggle nvim-tree |
| `<Leader>ot` | obsidian today |
| `<Leader>dd` | insert date |
| `<Leader>rj` | reformat json |
| `<Leader>vt` | vertical terminal split |
| `<Leader>ht` | horizontal terminal split |
| `<Space>,` | buffer left |
| `<Space>.` | buffer right |
| `<Leader>up` | print project root |
| `<Leader>ug` | print git root |
| `<Leader>uf` | print find file root |
| `ga` | alignment plugin |
| `<Space>/` | telescope: find files |
| `<Space>f` | telescope: find files (git repo) |
| `<Space>?` | telescope: open buffers |
| `<Space>g` | telescope: live grep |
| `<Space>o` | telescope: projects |
| `<Space>:` | telescope: cmdline |
| `<Space>t` | telescope: TODO comments |
| `<Leader>cc` | telescope: color schemes |
| `<Leader>sy` | telescope: symbols |
| <Space>z | Pane maximizer toggle |
| <Space>e | Enter "resize" mode |
| `<Space>mm` | floating terminal |
| `<Space>n` | global note |
| ------ | ----------- |
| `<Leader>ss` | open slime pane |
| `<Leader>sr` | open slime pane (with R) |
| `<Leader>sR` | open slime pane (with RR) |
| `<Leader>sc` | open slime pane (with custom command) |
| ------ | ----------- |
| `gd` | go to definition |
| `gD` | go to declaration |
| `gi` | go to implementation |
| `<C-k>` | signature help |
| `gi` | go to references |
| ------ | ----------- |
| `<Space>2d` | go to definition |
| `<Space>2D` | go to declaration |
| `<Space>2i` | go to implementation |
| `<Space>2s` | signature help |
| `<Space>2t` | type definition |
| `<Space>mv` | rename symbol |
| `<Space>2p` | format |
| `<Space>2r` | go to references |
| `<Space>ca` | code actions |


Donate to Vim by sponsoring or registering to vote on features and, more
importantly, help needy children in Uganda, please!
www.vim.org


## Installation

Assuming you have the necessary dependencies (git, curl, wget, par, fzf,
ripgrep, node, lua, etc...) installation is simply

```
mkdir -p ~/.config
git clone https://github.com/tonyfischetti/vix.git ~/.config/nvim
cd ~/.config/nvim
make install
```


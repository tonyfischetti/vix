
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            webdev_colors = true,
            glyphs = {
                folder = {
                  arrow_closed = '',
                  arrow_open = '',
                  default = '',
                  open = '',
                  empty = '',
                  empty_open = '',
                  symlink = '',
                  symlink_open = ''
                }
            }
        }
    },
    filters = {
        dotfiles = true,
    },
})



require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 25,
    },
    renderer = {
        group_empty = true,
        icons = {
            web_devicons = {
                file = {
                    enable = true,
                    color = true
                },
                folder = {
                    enable = false,
                    color = true
                }
            },
            glyphs = {
                folder = {
                  arrow_closed = '',
                  arrow_open = '',
                  default = '',
                  open = '',
                  empty = ' ',
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


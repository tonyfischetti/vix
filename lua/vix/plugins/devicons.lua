require('nvim-web-devicons').setup {
    -- your personal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
        lisp = {
            icon = "λ",
            color = "#428850",
            cterm_color = "65",
            name = "lisp"
        },
        r = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "R"
        },
        dockerfile = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "dockerfile"
        },
        text = {
            icons = "",
            color = "#deaded",
            name = "text"
        }
    },
    override_by_filename = {
        ["Gulpfile.js"] = {
            icon = "",
            color = "#f1502f",
            name = "Gulpfiile"
        }
    },
    color_icons = true;
}

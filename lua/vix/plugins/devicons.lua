require('nvim-web-devicons').setup {
    -- your personal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    default = true,
    override = {
        lisp = {
            icon = "λ",
            color = "#428850",
            cterm_color = "65",
            name = "lisp"
        },
        R = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "R"
        },
        js = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "javascript"
        },
        dockerfile = {
            icon = "",
            color = "#FFAF87",
            name = "dockerfile"
        },
        text = {
            icons = "",
            color = "#deaded",
            name = "text"
        },
        tsv = {
            icons = "",
            color = "#428850",
            name = "Csv"
        },
        default = {
            icons = "",
            color = "#deaded",
            name = "text"
        }
    },
    override_by_filename = {
        ["Gulpfile.js"] = {
            icon = "",
            color = "#f1502f",
            name = "Gulpfile"
        },
        ["Dockerfile"] = {
            icon = "",
            color = "#FFAF87",
            name = "dockerfile"
        },
        ["docker-compose.yaml"] = {
            icon = "",
            color = "#FFAF87",
            name = "dockerfile"
        }
    },
    override_by_extension = {
        ["txt"] = {
            icon = "",
            color = "#f1502f",
            name = "text"
        },
        ["list"] = {
            icon = "",
            color = "#f1502f",
            name = "text"
        },
        ["tsv"] = {
            icons = "",
            color = "#428850",
            name = "tsv"
        }
    },
    color_icons = true;
}

require("nvim-web-devicons").set_default_icon('', '#6d8086', 65);

-- require("nvim-web-devicons").set_icon_by_filetype { tsv = "csv" }
require("nvim-web-devicons").set_icon_by_filetype { csv = "tsv" };

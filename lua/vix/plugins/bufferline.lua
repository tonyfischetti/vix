require("bufferline").setup{
    options = {
        always_show_bufferline = false,
        close_icon = '',
        buffer_close_icon = '',
        indicator = {
            style = 'underline'
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = false
            }
        },
        separator_style = "slant"
    }
}

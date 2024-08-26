
return {

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    opts = {
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
  }

}


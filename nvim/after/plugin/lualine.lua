require('lualine').setup{
    sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'buffers',},
    lualine_x = {'location'},
    lualine_y = {'progress','filetype'},
    lualine_z = {'ctime','cdate'}
  },
}

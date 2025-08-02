return {
  'nvim-lualine/lualine.nvim',
  priority = 1000,
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = '',
      },
    })
  end,
}

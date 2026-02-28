return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = {
        preset = 'super-tab',
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      completion = {
        menu = { border = 'rounded' },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = 'rounded' }
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          }
        }
      },

      signature = { enabled = true, window = { border = 'rounded' } }
    },
    opts_extend = { "sources.default" }
  }
}


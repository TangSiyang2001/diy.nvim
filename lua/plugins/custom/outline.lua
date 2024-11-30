return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>to', '<cmd>Outline<CR>', desc = '[T]oggle outline' },
  },
  opts = {
    -- Your setup opts here
  },
}

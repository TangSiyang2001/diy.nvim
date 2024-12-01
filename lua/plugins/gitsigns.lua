-- See `:help gitsigns` to understand what the configuration keys do
-- Adds git related signs to the gutter, as well as utilities for managing changes

return {
  'lewis6991/gitsigns.nvim',
  keys = {
    { ']h', desc = 'Next Hunk' },
    { '[h', desc = 'Prev Hunk' },
    { ']H', desc = 'Last Hunk' },
    { '[', desc = 'First Hunk' },
    { '<leader>ghs', desc = ':Gitsigns stage_hunk<CR>', 'Stage Hunk' },
    { '<leader>ghr', desc = ':Gitsigns reset_hunk<CR>', 'Reset Hunk' },
    { '<leader>gS', desc = 'Stage Buffer' },
    { '<leader>gu', desc = 'Undo Stage Hunk' },
    { '<leader>gR', desc = 'Reset Buffer' },
    { '<leader>gp', desc = 'Preview Hunk Inline' },
    { '<leader>gb', desc = 'Blame Line' },
    { '<leader>gB', desc = 'Blame Buffer' },
    { '<leader>gd', desc = 'Diff This' },
    { '<leader>gD', desc = 'Diff This ~' },
    { 'ih', desc = ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk' },
    { '<leader>tb', desc = '[T]oggle git show [b]lame line' },
    { '<leader>tD', desc = '[T]oggle git show [D]eleted' },
  },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
    on_attach = function(buffer)
      local gs = require 'gitsigns'

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>gB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>gd", gs.diffthis, "Diff This")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      -- Toggles
      map("n", "<leader>tb", gs.toggle_current_line_blame, "[T]oggle git show [b]lame line" )
      map("n", "<leader>tD", gs.toggle_deleted, "[T]oggle git show [D]eleted" )
    end,
  },
}

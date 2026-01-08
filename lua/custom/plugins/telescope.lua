return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x', -- Use the 0.1.x branch for stability
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- Build command is essential for compiling the C extension
      build = 'make',
      config = function()
        -- Load the extension after the main telescope setup
        require('telescope').load_extension 'fzf'
      end,
    },
    'nvim-lua/plenary.nvim', -- Also needed for Telescope
  },
  config = function()
    -- Your main telescope setup here
    require('telescope').setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
            ['<esc>'] = require('telescope.actions').close,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- Fzf-style fuzzy matching
          override_generic_sorter = true, -- Use fzf sorter everywhere
          override_file_sorter = true, -- Use fzf sorter for files
          case_mode = 'smart_case', -- Smart case handling
        },
      },
    }
    -- Note: require("telescope").load_extension("fzf") is typically handled within the dependency config block as shown above.
    require('telescope').load_extension 'fzf'

    local keymap = vim.keymap

    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>')
    keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>')
    keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
    keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
  end,
}

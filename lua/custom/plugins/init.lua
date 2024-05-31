-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      'BufReadPre /Users/tylerlindberg/obsidian/**.md',
      'BufNewFile /Users/tylerlindberg/obsidian/**.md',
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'main',
          path = '~/obsidian/main',
        },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()

      -- Navigate to parent directory of file
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()
      require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'

      require('dap.ext.vscode').load_launchjs()

      vim.keymap.set('n', '<space>db', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
      vim.keymap.set('n', '<space>dc', dap.run_to_cursor, { desc = 'Run to [C]ursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<space>d?', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Eval Under Cursor' })

      vim.keymap.set('n', '<leader>d<space>', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<leader>dl', dap.step_into, { desc = 'Step Into' })
      vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = 'Step Over' })
      vim.keymap.set('n', '<leader>dh', dap.step_out, { desc = 'Step Out' })
      vim.keymap.set('n', '<leader>dk', dap.step_back, { desc = 'Step Back' })
      vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[R]estart' })

      vim.keymap.set('n', '<leader>dd', dap.disconnect, { desc = '[D]isconnect' })

      -- vim.keymap.set('n', '<F1>', dap.continue)
      -- vim.keymap.set('n', '<F2>', dap.step_into)
      -- vim.keymap.set('n', '<F3>', dap.step_over)
      -- vim.keymap.set('n', '<F4>', dap.step_out)
      -- vim.keymap.set('n', '<F5>', dap.step_back)
      -- vim.keymap.set('n', '<F13>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}

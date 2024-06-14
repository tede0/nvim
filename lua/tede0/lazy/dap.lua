return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python", -- Added for Python support
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local dap_python = require "dap-python" -- Added for Python support
      local ui = require "dapui"

      -- Setting up DAP UI
      require("dapui").setup()

      -- Setting up virtual text
      require("nvim-dap-virtual-text").setup()

      -- Setting up Python debugging
      dap_python.setup("~/.virtualenvs/debugpy/bin/python")

      -- Adding general Python debug configuration
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            local venv_path = os.getenv("VIRTUAL_ENV")
            if venv_path then
              return venv_path .. "/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
        {
          type = "python",
          request = "launch",
          name = "FastAPI: Uvicorn",
          program = "${workspaceFolder}/venv/bin/uvicorn", -- Adjust the path to Uvicorn as needed
          args = { "main:app", "--host", "127.0.0.1", "--port", "8000", "--reload" },
          console = "integratedTerminal",
          justMyCode = true,
        }
      }

      -- Key mappings
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
      vim.keymap.set("n", "<leader>du", ui.toggle) -- Keymap to toggle DAP UI

      -- Eval var under cursor
      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      -- DAP UI event listeners
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
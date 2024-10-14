-- a Debug Adapter Protocol client implementation 
local debugging_signs = require("util.icons").debugging_signs

return {
  -- DAP core
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Set custom debugging icons
    for name, sign in pairs(debugging_signs) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- Setup dap UI
    dapui.setup()

    -- Automatically open/close dap UI when debugging starts/ends
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
      vim.cmd("Hardtime disable")
      vim.cmd("NvimTreeClose")
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
      vim.cmd("Hardtime enable")
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
      vim.cmd("Hardtime enable")
    end

    -- Debug Adapter Configuration for Node.js and TypeScript
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/path/to/vscode-node-debug2/out/src/nodeDebug.js" },
    }

    dap.configurations.javascript = {
      {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
    }

    dap.configurations.typescript = {
      {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
      },
    }

    -- Debug Adapter for Rust (using lldb-vscode)
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode", -- Adjust this path if necessary
      name = "lldb"
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }
  end,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python", -- Optional for Python support
  },
}

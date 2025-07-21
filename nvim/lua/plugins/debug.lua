return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    require("dap-go").setup()
    require("dapui").setup()

    -- Simple attach config
    require("dap").configurations.go = vim.list_extend(require("dap").configurations.go, {
      {
        type = "delve",
        name = "Attach",
        mode = "local",
        request = "attach",
        processId = function()
          return require("dap.utils").pick_process({ filter = "go" })
        end,
      }
    })
  end,
  keys = {
    { "<F5>",  function() require("dap").continue() end },
    { "<F9>",  function() require("dap").toggle_breakpoint() end },
    { "<F10>", function() require("dap").step_over() end },
  },
}

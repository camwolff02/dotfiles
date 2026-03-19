return {
  -- Make Pyright provide symbols/completion, but let Ruff handle linting/formatting
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              -- Point Pyright to the project venv; venv-selector also fixes PATH
              venvPath = ".",
              venv = ".venv",
              analysis = {
                -- Turn off Pyright type checking so Mypy is the single source of truth
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
    },
  },

  -- Conform: format Python with Ruff
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- Run ruff --fix first (organize/simplify), then ruff format
      opts.formatters_by_ft.python = { "ruff_fix", "ruff_format" }
      -- Use the ruff from your active venv (venv-selector puts it first in PATH)
    end,
  },

  -- nvim-lint: run Mypy for type checking
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- Ruff diagnostics come from the Ruff LSP; only add Mypy here
      opts.linters_by_ft.python = { "mypy" }

      local lint = require("lint")

      local mypy = vim.fn.exepath("mypy")
      if mypy == "" then
        mypy = "mypy"
      end

      lint.linters.mypy.cmd = mypy
      lint.linters.mypy.args = {
        "--hide-error-context",
        "--no-pretty",
        "--no-color-output",
        "--show-column-numbers",
      }
    end,
  },

  -- Optional convenience: quickly pick a venv (remembered per project)
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python",
    keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" } },
    opts = { options = { notify_user_on_venv_activation = true } },
  },
}

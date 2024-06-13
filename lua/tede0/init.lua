require("tede0.set")
require("tede0.remap")
require("tede0.lazy_init")

local augroup = vim.api.nvim_create_augroup
local DefaultGroup = augroup('DefaultGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = DefaultGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
  group = DefaultGroup,
  callback = function(e)
    local opts = { buffer = e.buf }

    local function copy_diagnostic_to_clipboard()
      local line_diagnostics = vim.diagnostic.get(e.buf, { lnum = vim.fn.line('.') - 1 })
      if #line_diagnostics == 0 then
        print("No diagnostics at the current line")
        return
      end
      local diagnostic_message = line_diagnostics[1].message
      vim.fn.setreg('+', diagnostic_message)
      print("Diagnostic copied to clipboard")
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() require('telescope.builtin').lsp_references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

    vim.keymap.set("n", "<leader>vc", copy_diagnostic_to_clipboard, opts) -- copy error message to clipboard
  end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

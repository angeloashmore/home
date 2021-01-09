local lspconfig = require("lspconfig")

local map = function(mode, key, result, noremap)
  if noremap == nil then
    noremap = true
  end
  vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = noremap, silent = true})
end

-- Prints all active language servers.
function _G.activeLSP()
  local servers = {}
  for _, lsp in pairs(vim.lsp.get_active_clients()) do
    table.insert(servers, {name = lsp.name, id = lsp.id})
  end
  print(vim.inspect(servers))
end

-- Prints all active language servers scoped to the current buffer.
function _G.bufferActiveLSP()
  local servers = {}
  for _, lsp in pairs(vim.lsp.buf_get_clients()) do
    table.insert(servers, {name = lsp.name, id = lsp.id})
  end
  print(vim.inspect(servers))
end

_G.formatting = function()
  if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
    vim.lsp.buf.formatting(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {})
  end
end

FormatToggle = function(value)
  vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end
vim.cmd [[command! FormatDisable lua FormatToggle(true)]]
vim.cmd [[command! FormatEnable lua FormatToggle(false)]]

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.cmd [[noautocmd :update]]
    end
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      update_in_insert = false,
      virtual_text = false
    }
    )

local on_attach = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
    vim.cmd [[augroup END]]
  end
  if client.resolved_capabilities.goto_definition then
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  end
  if client.resolved_capabilities.hover then
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  end
  if client.resolved_capabilities.find_references then
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  end
  if client.resolved_capabilities.rename then
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  end
end

lspconfig.cssls.setup { on_attach = on_attach }
lspconfig.dockerls.setup { on_attach = on_attach }
lspconfig.gopls.setup { on_attach = on_attach }
lspconfig.html.setup { on_attach = on_attach }
lspconfig.jsonls.setup { on_attach = on_attach }
lspconfig.vimls.setup { on_attach = on_attach }
lspconfig.yamlls.setup { on_attach = on_attach }
lspconfig.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
}

local efmTools = {
  prettier = {
    formatCommand = "./node_modules/.bin/prettier"
  },
  eslint = {
    lintCommand = "eslint_d -f unix --stdin",
    lintIgnoreExitCode = true,
    lintStdin = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin",
    formatStdin = true
  },
  golint = {
    lintCommand = "golint",
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %m"}
  },
  gofumpt = {
    formatCommand = "gofumpt -s",
    formatStdin = true
  }
}

lspconfig.efm.setup {
  on_attach = on_attach,
  init_options = {
    documentFormatting = true,
    publishDiagnostics = true
  },
  settings = {
    languages = {
      typescript = {efmTools.prettier, efmTools.eslint},
      javascript = {efmTools.prettier, efmTools.eslint},
      typescriptreact = {efmTools.prettier, efmTools.eslint},
      javascriptreact = {efmTools.prettier, efmTools.eslint},
      yaml = {efmTools.prettier},
      json = {efmTools.prettier},
      jsonc = {efmTools.prettier},
      html = {efmTools.prettier},
      scss = {efmTools.prettier},
      css = {efmTools.prettier},
      markdown = {efmTools.prettier},
      go = {efmTools.gofumpt, efmTools.golint}
    },
  },
}

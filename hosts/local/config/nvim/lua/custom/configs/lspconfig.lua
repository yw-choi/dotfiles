local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "fortls", "pyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
lspconfig.fortls.setup {
    cmd = {
        'fortls',
        '--lowercase_intrinsics',
        '--hover_signature',
        '--hover_language=fortran',
        '--use_signature_help'
    }
}



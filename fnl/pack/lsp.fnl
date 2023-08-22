(local lsp (require :lspconfig))
(local keymaps (require :pack/which-key))

;;; Diagnostics configuration
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

;;; Improve UI
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :solid}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :solid})))

;;; On attach
(fn on_attach [client bufnr]
  (keymaps.set-lsp-keys! bufnr))

;;; Capabilities
(local capabilities (vim.lsp.protocol.make_client_capabilities))

;;; Setup servers
(local defaults {: on_attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

(lsp.lua_ls.setup {: on_attach
                   : capabilities
                   :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                    :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                          (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                :maxPreload 100000
                                                :preloadFileSize 10000}}}})


(lsp.powershell_es.setup {: on_attach
                          :bundle_path "/home/shovel/opt/PowerShellEditorServices/"})


(lsp.eslint.setup {:on_attach (fn [] (vim.api.nvim_command "autocmd BufWritePre <buffer> EslintFixAll"))})


(lsp.stylelint_lsp.setup {:cmd ["yarn" "dlx" "-p" "stylelint-lsp" "stylelint-lsp" "--stdio"]
                          :filetypes ["css" "less" "scss" "sugarss" "vue" "wxss"]
                          :root_dir (lsp.util.root_pattern ".stylelintrc" "package.json")
                          :settings {}})

(lsp.rnix.setup defaults)
(lsp.hls.setup defaults)
(lsp.terraformls.setup defaults)
(lsp.tsserver.setup {: on_attach
                     : capabilities})
(lsp.vimls.setup defaults)
(lsp.yamlls.setup {: on_attach
                   : capabilities
                   :settings {:yaml {:keyOrdering false}}})

(lsp.jsonnet_ls.setup {})

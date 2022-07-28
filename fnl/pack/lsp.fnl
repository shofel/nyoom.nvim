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
(set capabilities.textDocument.completion.completionItem.documentationFormat {1 :markdown 2 :plaintext})
(set capabilities.textDocument.completion.completionItem.snippetSupport true)
(set capabilities.textDocument.completion.completionItem.preselectSupport true)
(set capabilities.textDocument.completion.completionItem.insertReplaceSupport true)
(set capabilities.textDocument.completion.completionItem.labelDetailsSupport true)
(set capabilities.textDocument.completion.completionItem.deprecatedSupport true)
(set capabilities.textDocument.completion.completionItem.commitCharactersSupport true)
(set capabilities.textDocument.completion.completionItem.tagSupport {:valueSet {1 1}})
(set capabilities.textDocument.completion.completionItem.resolveSupport {:properties {1 :documentation 2 :detail 3 :additionalTextEdits}})

;;; Setup servers
(local defaults {: on_attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

;; example: typescript server 
(when (= (vim.fn.executable :tsserver) 1)
  (lsp.tsserver.setup defaults))

;; and for trickier servers you can do it yourself
(lsp.sumneko_lua.setup {: on_attach
                        : capabilities
                        :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                         :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                               (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                     :maxPreload 100000
                                                     :preloadFileSize 10000}}}})


(lsp.powershell_es.setup {: on_attach
                          :bundle_path "/home/shovel/opt/PowerShellEditorServices/"})

(lsp.flow.setup {: on_attach
                 :cmd ["yarn" "flow" "lsp"]})


(lsp.eslint.setup {:on_attach (fn [] (vim.api.nvim_command "autocmd BufWritePre <buffer> EslintFixAll"))})


(lsp.stylelint_lsp.setup {:cmd ["yarn" "dlx" "-p" "stylelint-lsp" "stylelint-lsp" "--stdio"]
                          :filetypes ["css" "less" "scss" "sugarss"
                                      "vue" "wxss" "javascript" "javascriptreact"
                                      "typescript" "typescriptreact"]
                          :root_dir (lsp.util.root_pattern ".stylelintrc" "package.json")
                          :settings {}})


(lsp.hls.setup {})
(lsp.rnix.setup {})
(lsp.terraformls.setup {})
(lsp.vimls.setup {})
(lsp.yamlls.setup {})

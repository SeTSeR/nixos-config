;;; package --- Summary
;;; Commentary:
;;; LSP settings

;;; Code:

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  ((c-mode c++-mode rust-mode) . lsp-deferred)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
                    :major-modes '(rust-mode)
                    :remote? t
                    :server-id 'rust-analyzer-remote))
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-enable-xref t))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-ivy
  :commands ivy-lsp-workspace-symbol)

(use-package company-lsp
  :commands company-lsp)

;;; lsp.el ends here

;;; package --- Summary
;;; Commentary:
;;; LSP settings

;;; Code:

(use-package lsp-mode
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-enable-xref t))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company-lsp
  :commands company-lsp)

;;; lsp.el ends here

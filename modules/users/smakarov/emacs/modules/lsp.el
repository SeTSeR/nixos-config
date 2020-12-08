;;; package --- Summary
;;; Commentary:
;;; LSP settings

;;; Code:

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :defer t
  :hook
  ((c-mode c++-mode rust-mode) . lsp-deferred)
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection "rust-analyzer")
    :major-modes '(rust-mode rustic-mode)
    :ignore-messages nil
    :remote? t
    :server-id 'rust-analyzer-remote
    :custom-capabilities `((experimental . ((snippetTextEdit . ,lsp-enable-snippet ))))))
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-enable-xref t)
  (defun lsp-advice (orig &rest args)
      (cl-letf* ((path (exec-path))
                 ((symbol-function 'exec-path) (lambda () (append exec-path path))))
        (apply orig args)))
  (advice-add 'lsp-server-present? :around #'lsp-advice))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t)

(use-package lsp-ivy
  :commands ivy-lsp-workspace-symbol
  :defer t)

(use-package company-lsp
  :commands company-lsp
  :defer t)

;;; lsp.el ends here

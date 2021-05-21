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
   (make-lsp-client
    :new-connection (lsp-tramp-connection "rust-analyzer")
    :major-modes '(rust-mode rustic-mode)
    :ignore-messages nil
    :remote? t
    :server-id 'rust-analyzer-remote
    :custom-capabilities `((experimental . ((snippetTextEdit . ,lsp-enable-snippet))))))
  (defun lsp-advice (orig &rest args)
      (cl-letf* ((path (exec-path))
                 ((symbol-function 'exec-path) (lambda () (append exec-path path))))
        (apply orig args)))
  (advice-add 'lsp-server-present? :around #'lsp-advice)
  :custom
  (lsp-enable-snippet t)
  (lsp-enable-xref t))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t)
;;; lsp.el ends here

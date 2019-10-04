;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(use-package irony-mode
  :hook
  (c-mode . irony-mode)
  (c-mode . lsp)
  (c++-mode . irony-mode)
  (c++-mode . lsp)
  :config
  (use-package company-irony-c-headers
    :config
    (eval-after-load 'company
      '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))))

;;; cpp.el ends here

;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(use-package cc-mode
  :config
  (setq c-basic-offset 8
        tab-width 8
        indent-tabs-mode t))

(use-package irony
  :hook
  ((c-mode . c++-mode) . (irony-mode))
  :config
  (use-package company-irony-c-headers
    :config
    (eval-after-load 'company
      '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))))

(use-package ccls
  :hook ((c-mode c++-mode) .
         (lambda () (require 'ccls) (lsp)))
  :config
  (setq ccls-sem-highlight-method 'font-lock)
  (setq ccls-args '("--log-file=/tmp/ccls.log")))

;;; cpp.el ends here

;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(use-package cc-mode
    :config
    (use-package google-c-style
        :config
        (add-hook 'c-mode-common-hook 'google-set-c-style)
        (add-hook 'c-mode-common-hook 'google-make-newline-indent)))

(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq tab-width 4)

(use-package irony-mode
    :hook
    (c-mode . irony-mode)
    (c++-mode . irony-mode)
    :config
    (use-package company-irony-c-headers
      :config
      (eval-after-load 'company
        '(add-to-list
          'company-backends '(company-irony-c-headers company-irony)))))

;;; cpp.el ends here

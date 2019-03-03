;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(use-package irony-mode
    :hook
    (c-mode . irony-mode)
    (c++-mode . irony-mode)
    
    (use-package flycheck-irony
      :config
      (eval-after-load 'flycheck
        '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

    (use-package company-irony-c-headers
      :config
      (eval-after-load 'company
        '(add-to-list
          'company-backends '(company-irony-c-headers company-irony)))))

;;; cpp.el ends here

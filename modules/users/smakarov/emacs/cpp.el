;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(defun set-prac-c-style ()
  (google-set-c-style)
  (c-add-style "prac-style"
               '("google"
                 (indent-tabs-mode . nil)
                 (c-basic-offset . 4)) t)
  (google-make-newline-indent))

(use-package cc-mode
    :config
    (use-package google-c-style
        :config
        (add-hook 'c-mode-common-hook 'set-prac-c-style)))

(use-package irony-mode
  :hook
  (c-mode . irony-mode)
  (c++-mode . irony-mode)
  :config
  (use-package company-irony-c-headers
    :config
    (eval-after-load 'company
      '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))))

;;; cpp.el ends here

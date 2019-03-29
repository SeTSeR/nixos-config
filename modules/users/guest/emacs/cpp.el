;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(defconst prac-cc-style
  '("google"
    (c-basic-offset . 4)
    (c-offsets-alist
     . ((access-label . -))))
  "C++ style for practicum.")

(defun set-prac-cc-style ()
  "Set style for practicum."
  (google-set-c-style)
  (google-make-newline-indent)
  (c-add-style "prac-style" prac-cc-style t))

(use-package cc-mode
  :config
  (use-package google-c-style
    :hook (c-mode-common . set-prac-cc-style)))

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

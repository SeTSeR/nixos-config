;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

; style I want to use in c++ mode
(c-add-style "my-style" 
             '("stroustrup"
               (indent-tabs-mode . nil)        ; use spaces rather than tabs
               (c-basic-offset . 4)            ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
                                   (brace-list-open . 0)
                                   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)         
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

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

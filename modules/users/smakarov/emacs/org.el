;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/hobby.org"))

(use-package org-install
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :config
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-log-done t))

;;; org.el ends here

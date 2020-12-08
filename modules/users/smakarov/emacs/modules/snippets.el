;;; package --- Summary
;;; Commentary:
;;; Yasnippet settings

;;; Code:

(defun org-latex-yasnippet ()
  "Activate org and LaTeX yasnippet expansion in 'org-mode' buffers."
  (yas-minor-mode)
  (yas-activate-extra-mode 'latex-mode))

(use-package yasnippet
  :hook
  ((prog-mode . yas-minor-mode)
   (org-mode . org-latex-yasnippet))
  :defer t
  :diminish yas-minor-mode
  :config
  (use-package yasnippet-snippets)
  (add-to-list 'yas-snippet-dirs "@emacsConfigDir@/yasnippet-snippets")
  (yas-reload-all))

(use-package ivy-yasnippet
  :bind ("C-x y" . ivy-yasnippet))

;;; snippets.el ends here

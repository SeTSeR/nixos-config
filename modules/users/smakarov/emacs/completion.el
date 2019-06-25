;;; package --- Summary
;;; Commentary:
;;; Completion settings

;;; Code:

(use-package company
  :diminish company-mode
  :config
  (global-company-mode 1)

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1))

(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode 1))

  (setq company-global-modes '(not gud-mode)))

;;; completion.el ends here

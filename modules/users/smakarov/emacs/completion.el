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

(use-package ivy-xref
  :init
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  (setq xref-show-xrefs-function #'ivy-xref-show-defs))

(use-package counsel
  :diminish counsel-mode
  :config
  (counsel-mode 1))

  (setq company-global-modes '(not gud-mode)))

;;; completion.el ends here

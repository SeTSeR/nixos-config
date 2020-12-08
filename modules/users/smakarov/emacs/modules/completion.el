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
    :defer t
    :init
    (when (>= emacs-major-version 27)
      (setq xref-show-definitions-function #'ivy-xref-show-defs))
    (setq xref-show-xrefs-function #'ivy-xref-show-defs))

  (use-package counsel
    :bind ("<f6>" . counsel-rg)
    :diminish counsel-mode
    :config (counsel-mode 1))

  (setq company-global-modes '(not gud-mode)))

;;; completion.el ends here

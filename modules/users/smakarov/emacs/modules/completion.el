;;; package --- Summary
;;; Commentary:
;;; Completion settings

;;; Code:

(use-package company
  :diminish company-mode
  :ensure t
  :config
  (global-company-mode 1)

  (use-package ivy
    :diminish ivy-mode
    :ensure t
    :config
    (ivy-mode 1))

  (use-package ivy-xref
    :defer t
    :ensure t
    :init
    (when (>= emacs-major-version 27)
      (setq xref-show-definitions-function #'ivy-xref-show-defs))
    (setq xref-show-xrefs-function #'ivy-xref-show-defs))

  (use-package counsel
    :bind ("<f6>" . counsel-rg)
    :ensure t
    :diminish counsel-mode
    :config (counsel-mode 1))

  (setq company-global-modes '(not gud-mode)))

;;; completion.el ends here

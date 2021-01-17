;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package rust-mode
  :ensure t
  :defer t
  :config
  (use-package flycheck-rust
    :ensure t
    :hook (flycheck-mode . flycheck-rust-setup))
  (add-to-list 'auto-mode-alist
               '("\\.lalrpop\\'" . rust-mode)
               '("\\.gf\\'" . rust-mode)))

;;; rust.el ends here

;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package rust-mode
  :defer t
  :config
  (use-package flycheck-rust
    :hook (flycheck-mode . flycheck-rust-setup))
  (add-to-list 'auto-mode-alist
               '("\\.lalrpop\\'" . rust-mode)
               '("\\.gf\\'" . rust-mode)))

;;; rust.el ends here

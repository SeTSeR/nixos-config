;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package rust-mode
  :config
  (use-package flycheck-rust
    :hook (flycheck-mode . flycheck-rust-setup))
  (use-package racer
    :init
    (setq racer-rust-src-path nil)
    :requires rust-mode
    :hook
    (rust-mode . lsp)))

;;; rust.el ends here

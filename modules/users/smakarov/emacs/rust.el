;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package rust-mode
  :config
  (use-package company-racer)
  (use-package flycheck-rust
    :hook (flycheck-mode . flycheck-rust-setup))
  (use-package racer
    :requires rust-mode
    :init
    (setq racer-rust-src-path nil)
    :hook
    (rust-mode . racer-mode)
    (racer-mode . company-mode)
    (racer-mode . eldoc-mode)
    (racer-mode . lsp)))

;;; rust.el ends here

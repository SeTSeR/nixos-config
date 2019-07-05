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
    :init
    (setq racer-rust-src-path nil)
    :requires rust-mode
    :hook
    (rust-mode . racer-mode)
    (racer-mode . company-mode)
    (racer-mode . eldoc-mode)
    (racer-mode . lsp)))

;;; rust.el ends here

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
    (setq racer-rust-src-path
          (concat (string-trim
                   (shell-command-to-string "rustc --print systroot"))
                  "/lib/rustlib/src/rust/src"))
    :hook
    (rust-mode . racer-mode)
    (racer-mode . company-mode)
    (racer-mode . lsp)))

;;; rust.el ends here

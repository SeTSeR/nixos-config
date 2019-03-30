;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package racer
  :requires rust-mode
  :init
  (setq racer-rust-src-path
        (concat (string-trim
                 (shell-command-to-string "rustc --print systroot"))
                "/lib/rustlib/src/rust/src"))
  :hook
  (rust-mode . racer-mode)
  (racer-mode . eldoc-mode)
  (racer-mode . company-mode))

;;; rust.el ends here

;;; package --- summary
;;; Commentary:
;;; Settings for Rust

;;; Code:

(use-package rust-mode)

(use-package racer
    :hook
    (rust-mode . racer-mode)
    (racer-mode . eldoc-mode)
    (racer-mode . company-mode))

;;; rust.el ends here

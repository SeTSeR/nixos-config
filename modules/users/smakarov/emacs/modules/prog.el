;;; package --- Summary
;;; Commentary:
;;; Settings for programming

;;; Code:

;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  ((c-mode c++-mode rustic-mode) . lsp-deferred)
  :custom
  (lsp-enable-snippet t)
  (lsp-enable-xref t))

(use-package lsp-ui
  :commands lsp-ui-mode
  :defer t)

(use-package consult-lsp
  :after (lsp-mode consult)
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'consult-lsp-symbols))

;; Tree-sitter
(use-package tree-sitter
  :config
  (use-package tree-sitter-langs)
  (add-to-list 'tree-sitter-major-mode-language-alist '(rustic-mode . rust))
  (add-to-list 'tree-sitter-major-mode-language-alist '(cc-mode . cpp))
  :hook ((cc-mode rustic-mode) . tree-sitter-hl-mode))

;; Rust
(use-package rustic
  :defer t
  :config
  (add-to-list 'auto-mode-alist
               '("\\.lalrpop\\'" . rustic-mode)
               '("\\.gf\\'" . rustic-mode)))

;; C++
(use-package cc-mode
  :custom
  (c-basic-offset 8)
  (tab-width 8)
  (indent-tabs-mode t)
  :defer t)

(use-package glsl-mode
  :mode "\\.glsl\\'"
  :mode "\\.vert\\'"
  :mode "\\.frag\\'"
  :mode "\\.geom\\'"
  :interpreter "glsl"
  :defer t)

;;; prog.el ends here

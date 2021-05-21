;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

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

(use-package ccls
  :init
  (defun start-lsp ()
    (require 'ccls) (lsp))
  :hook ((c-mode c++-mode) . start-lsp)
  :custom
  (ccls-sem-highlight-method 'font-lock)
  (ccls-args '("--log-file=/tmp/ccls.log")))

(use-package irony :hook ((c-mode . c++-mode) . (irony-mode)))

;;; cpp.el ends here

;;; package --- Summary
;;; Commentary:
;;; Settings for C++

;;; Code:

(use-package cc-mode
  :config
  (setq c-basic-offset 8
        tab-width 8
        indent-tabs-mode t)
  :defer t
  :ensure t)

(use-package glsl-mode
  :mode "\\.glsl\\'"
  :mode "\\.vert\\'"
  :mode "\\.frag\\'"
  :mode "\\.geom\\'"
  :interpreter "glsl"
  :defer t
  :ensure t)

(use-package ccls
  :defer t
  :hook ((c-mode c++-mode) .
         (lambda () (require 'ccls) (lsp)))
  :ensure t
  :config
  (setq ccls-sem-highlight-method 'font-lock)
  (setq ccls-args '("--log-file=/tmp/ccls.log")))

(use-package irony
  :defer t
  :ensure t
  :hook
  ((c-mode . c++-mode) . (irony-mode)))

;;; cpp.el ends here

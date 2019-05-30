;;; package --- Summary
;;; Commentary:
;;; Projectile settings

;;; Code:

(use-package projectile
  :diminish projectile-mode
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :bind
  ("<f5>" . projectile-run-project)
  ("<f9>" . projectile-compile-project)
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode 1)
  (use-package counsel-projectile
   :config (counsel-projectile-mode))
  (global-unset-key [menu-bar tools Projectile])
  (projectile-register-project-type 'nix-shell '("shell.nix")
                                    :compile "nix-build shell.nix"
                                    :run "nix-shell")
  (setq projectile-project-search-path '("~/Projects/")))
  
;;; projectile.el ends here

;;; package --- Summary
;;; Commentary:
;;; Projectile settings

;;; Code:

(use-package projectile
  :diminish projectile-mode
  :config
  (setq projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") nil)
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode 1)
  (global-unset-key [menu-bar tools Projectile])
  (projectile-register-project-type 'nix-shell '("shell.nix")
                                    :compile "nix-build shell.nix"
                                    :run "nix-shell")
  (setq projectile-project-search-path '("~/Projects/"))
  
  (global-set-key (kbd "<f9>") 'projectile-compile-project)
  (global-set-key (kbd "<f5>") 'projectile-run-project))

;;; projectile.el ends here

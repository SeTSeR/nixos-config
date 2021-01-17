;;; package --- Summary
;;; Commentary:
;;; Main Emacs settings file

;;; Code:
(setq load-prefer-newer t) ; Don't load outdated byte code

;; Package sources
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)

  (add-to-list 'package-archives '("cselpa" . "https://elpa.thecybershadow.net/packages/"))
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(setq package-enable-at-startup nil)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package magit
  :bind
  (("C-x g" . magit-status))
  :defer t
  :ensure t)

(use-package flycheck
  :config
  (global-flycheck-mode)
  :ensure t)

(use-package powerline
  :config
  (powerline-center-theme)
  :ensure t)

(use-package smartparens
  :config (smartparens-global-mode 1)
  :ensure t)

;; Parentheses highlight
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :ensure t)

(use-package direnv
  :config (direnv-mode)
  :ensure t)

(use-package markdown-mode
  :defer t
  :mode "\\.\\(m\\(ark\\)?down\\|md\\)$"
  :ensure t)

(use-package reverse-im
  :config
  (add-to-list 'reverse-im-input-methods "russian-computer")
  (reverse-im-mode 1)
  :ensure t)

(use-package avy
  :bind
  ("C-;" . avy-goto-char)
  ("C-'" . avy-goto-char-2)
  ("M-g f" . avy-goto-line)
  ("M-g w" . avy-goto-word-1)
  :config
  (avy-setup-default)
  :defer t
  :ensure t)

(use-package ace-window
  :bind
  ("M-o" . ace-window)
  :defer t
  :ensure t)

(use-package tramp
  :config
  (setenv "SHELL" "/bin/bash")
  (setq tramp-terminal-type "tramp")
  (setq tramp-default-method "ssh")
  (add-to-list 'tramp-remote-path "/etc/profiles/per-user/@userName@/bin")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
  :defer t
  :ensure t)

(use-package eshell-toggle
  :bind
  ("s-`" . eshell-toggle)
  :defer t
  :ensure t)

(use-package gnuplot
  :defer t
  :ensure t)

(use-package pdf-tools
  :config
  (pdf-loader-install)
  :ensure t)

(use-package multitran
  :defer t
  :ensure t)

(use-package wakatime-mode
  :defer t
  :hook (prog-mode . wakatime-mode)
  :ensure t)

(use-package which-key
  :config (which-key-mode)
  :ensure t)

(use-package geiser
  :defer t
  :hook (scheme-mode . geiser-mode)
  :ensure t)

(use-package pinentry
  :config
  (pinentry-start)
  :ensure t)

(use-package ansi-color
  :defer t
  :init
  (defun colorize-compilation-buffer ()
    (read-only-mode)
    (ansi-color-apply-on-region compilation-filter-start (point))
    (read-only-mode))
  :hook (compilation-filter . colorize-compilation-buffer)
  :ensure t)

(use-package emacs
  :hook (proced-mode . nix-proced-readable-mode)
  :bind
  ("<f5>" . project-compile)
  ("<f9>" . project-compile)
  :config
  (load-theme 'modus-operandi t)
  ;; User's configuration directory
  (defconst user-init-dir
    (cond ((boundp 'user-emacs-directory) user-emacs-directory)
          ((boundp 'user-init-directory)  user-init-directory)
          (t "@emacsConfigDir@")))

  ;; backup in one place. flat, no tree structure
  (setq backup-directory-alist '(("" . "@emacsConfigDir@/backup")))

  (setq auto-save-file-name-transforms
        `((".*" "@emacsConfigDir@/auto-save-list/" t)))

  (setq-default indent-tabs-mode nil)
  (setq-default tab-always-indent 'complete)

  ;; Allow sentences ending with one space
  (setq-default sentence-end-double-space nil)

  (setq compilation-scroll-output 'first-error)

  (setq dired-listing-switches "-alh")

  (add-to-list 'default-frame-alist '(font . "Source Code Pro Medium-13"))

  (electric-indent-mode 1)

  (show-paren-mode 1)

  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)

  ;; Setup Splash Screen
  (setq inhibit-startup-screen t)
  (delete-other-windows))

;;; init.el ends here

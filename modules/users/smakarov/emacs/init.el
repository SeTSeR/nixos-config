;;; package --- Summary
;;; Commentary:
;;; Main Emacs settings file

;;; Code:
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

(use-package quelpa
  :custom
  (quelpa-checkout-melpa-p nil))

;; Bootstrap `quelpa-use-package'
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package powerline
  :config
  (powerline-center-theme))

(use-package smartparens
  :config (smartparens-global-mode 1))

;; Parentheses highlight
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package direnv
  :config (direnv-mode))

(use-package markdown-mode
  :defer t
  :mode "\\.\\(m\\(ark\\)?down\\|md\\)$")

(use-package reverse-im
  :config
  (add-to-list 'reverse-im-input-methods "russian-computer")
  (reverse-im-mode 1))

(use-package avy
  :bind
  ("C-;" . avy-goto-char)
  ("C-'" . avy-goto-char-2)
  ("M-g f" . avy-goto-line)
  ("M-g w" . avy-goto-word-1)
  :config
  (avy-setup-default))

(use-package ace-window :bind ("M-o" . ace-window))

(use-package tramp
  :config
  (setenv "SHELL" "@bashPath@")
  (add-to-list 'tramp-remote-path "/etc/profiles/per-user/@userName@/bin")
  :custom
  (tramp-terminal-type "tramp")
  (tramp-default-method "ssh")
  (tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
  :defer t)

(use-package eshell-toggle
  :bind
  ("s-`" . eshell-toggle))

(use-package gnuplot
  :defer t)

(use-package pdf-tools
  :config
  (pdf-loader-install))

(use-package multitran :defer t)

(use-package wakatime-mode :hook (prog-mode . wakatime-mode))

(use-package which-key :config (which-key-mode))

(use-package ansi-color
  :init
  (defun colorize-compilation-buffer ()
    (read-only-mode)
    (ansi-color-apply-on-region compilation-filter-start (point))
    (read-only-mode))
  :hook (compilation-filter . colorize-compilation-buffer))

(use-package nix-proced-readable-mode
  :hook (proced-mode . nix-proced-readable-mode))

(use-package emacs
  :init
  (add-to-list 'load-path "@emacsConfigDir@/pkgs")
  (server-start)
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

  (add-to-list 'default-frame-alist '(font . "Source Code Pro Medium-13"))
  (display-time-mode t)

  (electric-indent-mode 1)

  (show-paren-mode 1)

  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (delete-other-windows)
  :custom
  (load-prefer-newer t "Don't load outdated byte code")
  (backup-directory-alist '(("" . "@emacsConfigDir@/backup")) "backup in one place. flat, no tree structure")
  (auto-save-file-name-transforms
   `((".*" "@emacsConfigDir@/auto-save-list/" t)))
  (indent-tabs-mode nil)
  (tab-always-indent 'complete)
  (sentence-end-double-space nil "Allow sentences ending with one space")
  (compilation-scroll-output 'first-error)
  (dired-listing-switches "-alh")
  (inhibit-startup-screen t "Setup Splash Screen")
  (warning-minimum-level ":error"))

;;; init.el ends here

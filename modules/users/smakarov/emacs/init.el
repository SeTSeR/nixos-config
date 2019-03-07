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
(setq use-package-always-ensure nil)

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/" t)))

(setq-default indent-tabs-mode nil)

(setq-default tab-always-indent 'complete)

(setq compilation-scroll-output 'first-error)

(use-package auto-indent-mode
  :config
  (auto-indent-global-mode))

(electric-indent-mode 1)

;; User's configuration directory
(defconst user-init-dir
    (cond ((boundp 'user-emacs-directory) user-emacs-directory)
          ((boundp 'user-init-directory)  user-init-directory)
         (t "~/.emacs.d/")))

;; Function for loading user files
(defun load-user-file (file)
  "Load FILE in current user's configuration directory."
    (interactive "f")
    (load-file (expand-file-name file user-init-dir)))

(global-wakatime-mode)

(use-package magit
    :bind
    (("C-x g" . magit-status )))

(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq-default flycheck-clang-language-standard "gnu++17"))

(use-package company
    :diminish company-mode
    :config (global-company-mode 1))

(use-package solarized-theme
    :config (load-theme 'solarized-light t))

(use-package powerline
  :config
  (powerline-center-theme))

(use-package smartparens
  :config (smartparens-global-mode 1))

;; Parentheses highlight
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(show-paren-mode 1)

(use-package org-install
    :bind (("C-c l" . org-store-link)
           ("C-c a" . org-store-agenda))
    :config
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    (setq org-log-done t))

(cua-mode 1)
(desktop-save-mode 1)
(global-linum-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(load-user-file "cpp.el")
(load-user-file "keys.el")
(load-user-file "projectile.el")
(load-user-file "rust.el")

(use-package markdown-mode
:mode "\\.\\(m\\(ark\\)?down\\|md\\)$")

;; Setup Splash Screen
(setq inhibit-startup-screen t)
(setq-default major-mode 'org-mode)
(setq-default initial-scratch-message ";; Emacs lisp scratch buffer. Happy hacking.\n\n")

;;; init.el ends here

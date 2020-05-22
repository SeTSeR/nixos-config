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

;; User's configuration directory
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory) user-emacs-directory)
        ((boundp 'user-init-directory)  user-init-directory)
        (t "@emacsConfigDir@")))

;; Function for loading user files
(defun load-user-file (file)
  "Load FILE in current user's configuration directory."
  (interactive "f")
  (load-file (expand-file-name file user-init-dir)))

(add-to-list 'default-frame-alist '(font . "Source Code Pro Medium-13"))

(use-package wakatime-mode
 :config
 (global-wakatime-mode))

(use-package magit
  :bind
  (("C-x g" . magit-status)))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package company
  :diminish company-mode
  :config
  (global-company-mode 1)
  (setq company-global-modes '(not gud-mode)))

(use-package apropospriate-theme
  :config (load-theme 'apropospriate-light t))

(use-package powerline
  :config
  (powerline-center-theme))

(use-package smartparens
  :config (smartparens-global-mode 1))

;; Parentheses highlight
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(show-paren-mode 1)

(use-package direnv
  :config
  (direnv-mode))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(load-user-file "completion.el")
(load-user-file "cpp.el")
(load-user-file "lsp.el")
(load-user-file "org.el")
(load-user-file "projectile.el")
(load-user-file "rust.el")
(load-user-file "snippets.el")
(load-user-file "telega-settings.el")

(use-package markdown-mode
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

(use-package ace-window
  :bind
  ("M-o" . ace-window))

(use-package tramp
  :config
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*"))

(use-package eshell-toggle
  :bind
  ("s-`" . eshell-toggle))

(use-package gnuplot)

(use-package pdf-tools
  :config
  (pdf-tools-install))

(use-package multitran)

(use-package emacs
  :config
  ;; backup in one place. flat, no tree structure
  (setq backup-directory-alist '(("" . "@emacsConfigDir@/backup")))

  (setq auto-save-file-name-transforms
        `((".*" "@emacsConfigDir@/auto-save-list/" t)))

  (setq-default indent-tabs-mode nil)
  (setq-default tab-always-indent 'complete)

  ;; Allow sentences ending with one space
  (setq-default sentence-end-double-space nil)

  (setq compilation-scroll-output 'first-error)

  (electric-indent-mode 1)

  ;; Setup Splash Screen
  (setq inhibit-startup-screen t)
  (org-agenda-list)
  (setq initial-buffer-choice '(lambda () (get-buffer org-agenda-buffer-name)))
  (delete-other-windows))

;;; init.el ends here

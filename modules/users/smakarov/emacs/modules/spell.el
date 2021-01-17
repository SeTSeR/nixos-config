;;; package --- Summary
;;; Commentary:
;;; Spell-checker settings

;;; Code:

(use-package ispell
  :bind
  (("C-. d b" . ispell-buffer)
   ("C-. d e" . ispell-change-dictionary-to-english)
   ("C-. d r" . ispell-change-dictionary-to-russian))
  :defer t
  :ensure t
  :init
  (progn
    (setq ispell-dictionary "english")
    (setq ispell-alternate-dictionary "english")
    (setq ispell-program-name (executable-find "aspell"))

    (defun ispell-set-dictionary (dict)
      "Set dictionary to dict."
      (save-excursion
        (add-file-local-variable 'ispell-local-dictionary dict)))

    (defun ispell-change-dictionary-to-english (arg)
      "Set english dictionary as current."
      (interactive "P")
      (ispell-change-dictionary "english")
      (when arg
        (ispell-set-dictionary "english"))
      (flyspell-buffer))

    (defun ispell-change-dictionary-to-russian (arg)
      "Set russian dictionary as current."
      (interactive "P")
      (ispell-change-dictionary "ru")
      (when arg
        (ispell-set-dictionary "ru"))
      (flyspell-buffer))))

(use-package flyspell
  :bind (("C-. f b" . flyspell-buffer))
  :hook (text-mode . flyspell-mode)
  :ensure t
  :config
  (progn
    (unbind-key "C-." flyspell-mode-map))
  :defer t)

(use-package flyspell-correct-ivy
  :defer t
  :ensure t
  :bind (("M-$" . flyspell-correct-at-point)))

;;; spell.el ends here

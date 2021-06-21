;;; package --- Summary
;;; Commentary:
;;; Spell-checker settings

;;; Code:

(use-package ispell
  :bind
  (("C-, d b" . ispell-buffer)
   ("C-, d e" . ispell-change-dictionary-to-english)
   ("C-, d r" . ispell-change-dictionary-to-russian))
  :init
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
    (flyspell-buffer))
  :custom
  (ispell-dictionary "ru")
  (ispell-alternate-dictionary "english")
  (ispell-program-name (executable-find "aspell")))

(use-package flyspell
  :bind (("C-, f b" . flyspell-buffer))
  :hook (text-mode . flyspell-mode)
  :config
  (unbind-key "C-," flyspell-mode-map))

(use-package flyspell-correct
  :after flyspell
  :bind (("M-$" . flyspell-correct-at-point)))

;;; spell.el ends here

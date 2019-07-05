;;; package --- Summary
;;; Commentary:
;;; Evil settings

;;; Code:

(use-package evil
  :config
  (evil-mode 1)
  (use-package evil-magit)
  (use-package hideshow
    :hook ((prog-mode . hs-minor-mode))))

;;; evil.el ends here

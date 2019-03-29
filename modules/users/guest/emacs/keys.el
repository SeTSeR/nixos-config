;;; package --- Summary
;;; Commentary:
;;; List hotkeys

;;; Code:

(use-package guide-key
  :ensure t
  :defer t
  :diminish " C-?"
  :custom
  ((guide-key/guide-key-sequence '("C-x" "C-c" "ESC" "M-g" "SPC" "C-d"))
   (guide-key/popup-window-position 'bottom)
   (guide-key/recursive-key-sequence-flag t)
   (guide-key/idle-delay 1)
   (guide-key/text-scale-amount -1))
  :init
  (guide-key-mode t))

;;; keys.el ends here

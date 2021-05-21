;;; package --- Summary
;;; Commentary:
;;; Mail settings

;;; Code:

(use-package notmuch
  :init
  (defun set-notmuch-config ()
    (setenv "NOTMUCH_CONFIG" "@notmuchrc@"))
  :defer t
  :hook
  (message-setup . mml-secure-sign-pgpmime)
  (eshell-load . set-notmuch-config)
  :custom
  (send-mail-function 'sendmail-send-it)
  (mml-secure-openpgp-sign-with-sender t))

(use-package gnus
  :custom
  (gnus-home-directory "@emacsConfigDir@"))

;;; mail.el ends here

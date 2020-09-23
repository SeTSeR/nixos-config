;;; package --- Summary
;;; Commentary:
;;; Mail settings

;;; Code:

(use-package notmuch
  :hook (message-setup . mml-secure-sign-pgpmime)
  :config
  (setq send-mail-function 'sendmail-send-it)
  (setq mml-secure-openpgp-sign-with-sender t)
  (setenv "NOTMUCH_CONFIG" "/home/smakarov/.config/notmuch/notmuchrc"))

;;; mail.el ends here

;;; package --- Summary
;;; Commentary:
;;; Mail settings

;;; Code:

(use-package notmuch
  :init
  (defun set-notmuch-config ()
      (setenv "NOTMUCH_CONFIG" "/home/smakarov/.config/notmuch/notmuchrc"))
  :hook
  (message-setup . mml-secure-sign-pgpmime)
  (eshell-load . set-notmuch-config)
  :config
  (setq send-mail-function 'sendmail-send-it)
  (setq mml-secure-openpgp-sign-with-sender t))

;;; mail.el ends here

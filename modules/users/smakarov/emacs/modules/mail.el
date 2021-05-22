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
  (user-mail-address "setser200018@gmail.com")
  (gnus-nntp-server nil)
  (gnus-select-method '(nnnil ""))
  (gnus-secondary-select-methods
   '((nnmaildir "cmc"
		(directory "@maildir@/cmc")
		(gnus-search-engine gnus-search-notmuch
				    (config-file "@notmuchrc@"))
		(get-new-mail nil))
     (nnmaildir "work"
		(directory "@maildir@/ispras")
		(gnus-search-engine gnus-search-notmuch
				    (config-file "@notmuchrc@"))
		(get-new-mail nil))
     (nnmaildir "personal"
		(directory "@maildir@/main")
		(gnus-search-engine gnus-search-notmuch
				    (config-file "@notmuchrc@"))
		(get-new-mail nil))
     (nnmaildir "microsoft"
		(directory "@maildir@/microsoft")
		(gnus-search-engine gnus-search-notmuch
				    (config-file "@notmuchrc@"))
		(get-new-mail nil))
     (nnmaildir "yandex"
		(directory "@maildir@/yandex")
		(gnus-search-engine gnus-search-notmuch
				    (config-file "@notmuchrc@"))
		(get-new-mail-nil))))
  (send-mail-function 'sendmail-send-it)
  (message-send-mail-function 'sendmail-send-it)
  (mml-secure-openpgp-sign-with-sender t))

;;; mail.el ends here

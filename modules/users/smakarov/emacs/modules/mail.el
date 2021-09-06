;;; package --- Summary
;;; Commentary:
;;; Mail settings

;;; Code:

(use-package notmuch
  :init
  (defun set-notmuch-config ()
    (setenv "NOTMUCH_CONFIG"
	    (concat (file-name-as-directory
                 (expand-file-name "notmuch" (xdg-config-home)))
                "notmuchrc")))
  :defer t
  :hook
  (message-setup . mml-secure-sign-pgpmime)
  (eshell-load . set-notmuch-config)
  :custom
  (send-mail-function 'sendmail-send-it)
  (mml-secure-openpgp-sign-with-sender t))

(use-package gnus-search
  :after gnus
  :init (use-package xdg)
  :custom
  (gnus-search-use-parsed-queries t)
  (gnus-search-notmuch-config-file
   (concat (file-name-as-directory
                 (expand-file-name "notmuch" (xdg-config-home)))
           "notmuchrc")))

(use-package gnus
  :custom
  (user-mail-address "setser200018@gmail.com")
  (gnus-nntp-server nil)
  (gnus-select-method '(nnnil "nowhere"))
  (gnus-secondary-select-methods
   '((nnmaildir "cmc"
		(directory "@maildir@/cmc")
		(gnus-search-engine gnus-search-notmuch
				    (remove-prefix "@maildir@/cmc"))
		(get-new-mail nil))
     (nnmaildir "personal"
		(directory "@maildir@/main/[Gmail]")
		(gnus-search-engine gnus-search-notmuch
				    (remove-prefix "@maildir@/main/[Gmail]"))
		(get-new-mail nil))
     (nnmaildir "microsoft"
		(directory "@maildir@/microsoft")
		(gnus-search-engine gnus-search-notmuch
				    (remove-prefix "@maildir@/microsoft"))
		(get-new-mail nil))
     (nnmaildir "yandex"
		(directory "@maildir@/yandex")
		(gnus-search-engine gnus-search-notmuch
				    (remove-prefix "@maildir@/yandex"))
		(get-new-mail-nil))))
  (send-mail-function 'sendmail-send-it)
  (message-send-mail-function 'sendmail-send-it)
  (mml-secure-openpgp-sign-with-sender t)
  (gnus-verbose 10)
  (gnus-asynchronous t)
  (gnus-use-cache t))

;;; mail.el ends here

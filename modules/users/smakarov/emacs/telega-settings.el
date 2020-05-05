;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega
  :init (defun ignore-user-messages (msg &rest notused)
            (when (= (plist-get msg :sender_user_id) 370449679)
              (telega-msg-ignore msg)))
  :commands (telega)
  :defer t
  :hook (telega-chat-pre-message . (ignore-user-messages))
  :config
  (telega-notifications-mode 1)
  (setq telega-proxies
        (list
         '(:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@"))
         '(:server "msuprotest.tk" :port 443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretTwo@")))))

;;; telega-settings.el ends here

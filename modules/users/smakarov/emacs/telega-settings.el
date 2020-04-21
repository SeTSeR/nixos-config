;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(defun telega-ignore-larry-orwell (msg &rest notused)
  (when (= (plist-get msg :sender_user_id) 165277130)
    (telega-msg-ignore msg)))

(use-package telega
  :commands (telega)
  :defer t
  :hook (telega-chat-pre-message . (telega-ignore-larry-orwell))
  :config
  (telega-notifications-mode 1)
  (setq telega-proxies
        (list
         '(:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@"))
         '(:server "msuprotest.tk" :port 443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretTwo@")))))

;;; telega-settings.el ends here

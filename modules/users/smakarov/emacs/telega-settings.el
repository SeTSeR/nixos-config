;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega
  :init
  (defun ignore-user-messages-by-id (id msg)
      (when (= (plist-get msg :sender_user_id) id)
        (telega-msg-ignore msg)))
  (add-hook 'telega-chat-pre-message-hook (lambda (msg &rest notused)
                                            (ignore-user-messages-by-id 370449679 msg)))
  :commands (telega)
  :defer t
  :config
  (telega-notifications-mode 1)
  (setq telega-proxies
        (list
         '(:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@"))
         '(:server "msuprotest.tk" :port 443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretTwo@")))))

;;; telega-settings.el ends here

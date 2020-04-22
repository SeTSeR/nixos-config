;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega
  :init (defun telega-ignore-larry-orwell (msg &rest notused)
  (when (= (plist-get msg :sender_user_id) 165277130)
    (telega-msg-ignore msg)))
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

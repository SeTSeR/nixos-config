;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega
  :init
  (defun ignore-user-messages-by-id (id msg)
      (when (= (plist-get msg :sender_user_id) id)
        (telega-msg-ignore msg)))
  :commands (telega)
  :defer t
  :bind-keymap ("C-c t" . telega-prefix-map)
  :config
  (setq telega-proxies
        (list
         '(:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@")))))

;;; telega-settings.el ends here

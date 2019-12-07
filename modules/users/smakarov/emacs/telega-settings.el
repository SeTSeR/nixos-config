;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega
  :commands (telega)
  :defer t
  :config
  (setq telega-proxies
        (list
         '(:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@"))
         '(:server "msuprotest.tk" :port 443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretTwo@")))))

;;; telega-settings.el ends here

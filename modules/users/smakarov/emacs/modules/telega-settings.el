;;; package --- Summary
;;; Commentary:
;;; Telega.el settings

;;; Code:
(use-package telega-stories
  :after telega
  :bind
  (:map telega-root-mode-map
        ("v e" . telega-view-emacs-stories))
  :config
  (telega-stories-mode 1))

(use-package telega-dired-dwim :after telega)
(use-package ol-telega :after telega)
(use-package telega-mnz
  :after telega
  :hook ((telega-load . global-telega-mnz-mode)))

(use-package telega
  :init
  (defun ignore-user-messages-by-id (id msg)
    (let ((sender (telega-msg-sender msg)))
      (and (telega-user-p sender)
	   (= (plist-get sender :id) id))))
  :commands (telega)
  :bind-keymap ("C-c t" . telega-prefix-map)
  :hook
  ((telega-load . telega-mode-line-mode)
   (telega-load . telega-squash-message-mode))
  :custom
  (telega-filter-default '(any (folder "Dev") (folder "Work") (custom "Important")))
  (telega-proxies '((:server "185.86.77.210" :port 3443 :enable :false :type
                   (:@type "proxyTypeMtproto" :secret "@proxySecretOne@")))))

;;; telega-settings.el ends here

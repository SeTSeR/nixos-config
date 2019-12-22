;;; package --- Summary
;;; Commentary:
;;; Matrix client settings file

;;; Code:

(use-package matrix-client
  :quelpa (matrix-client :fetcher github
                         :repo "alphapapa/matrix-client.el"
                         :files (:defaults "logo.png" "matrix-client-standalone.el.sh")
                         :stable t))

;;; matrix.el ends here

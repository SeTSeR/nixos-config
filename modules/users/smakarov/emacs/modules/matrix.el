;;; package --- Summary
;;; Commentary:
;;; Matrix settings

;;; Code:

(use-package matrix-client
  :quelpa (matrix-client :fetcher github :repo "alphapapa/matrix-client.el"
                         :files (:defaults "logo.png" "matrix-client-standalone.el.sh"))
  :custom (matrix-client-save-token t))

;;; matrix.el ends here

;; -*- lexical-binding: t -*-

(defconst old-gc-cons-threshold gc-cons-threshold
  "Default GC threshold, saved during early initialization.")

(setq gc-cons-threshold most-positive-fixnum)

(defun restore-gc-cons-threshold ()
  "Set the `gc-cons-threshold' back to `old-gc-cons-threshold'.
Remember to save it there beforehand."
  (when (fixnump old-gc-cons-threshold)
    (setq gc-cons-threshold old-gc-cons-threshold)))

(add-hook 'emacs-startup-hook #'restore-gc-cons-threshold)

(defun show-startup-time ()
  "Print the startup time in the minibuffer."
  (let ((startup-time (float-time (time-subtract after-init-time before-init-time))))
    (message "Emacs ready in %.2f seconds with %d garbage collections." startup-time gcs-done)))

(add-hook 'emacs-startup-hook #'show-startup-time)

(provide 'early-init)
;;; early-init.el ends here

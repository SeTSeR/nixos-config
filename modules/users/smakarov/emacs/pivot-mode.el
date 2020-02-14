;;; pivot-mode.el --- Major mode for Pivot

;;; Commentary:

;;

;;; Code:

(defvar pivot-mode-hook nil)

(defvar pivot-mode-map
  (let ((map (make-sparse-keymap)))
    map)
  "Keymap for Pivot mode.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.pivot\\'" . pivot-mode))

(defconst pivot-font-lock-keywords
  (list
   '("\\<\\(bits\\|struct\\|trait\\|const\\|space\\|of\\|local\\|remote\\|where\\|fn\\|op\\|let\\|if\\|else\\|while\\|default\\)\\>" . font-lock-keyword-face)
   '("trait *\\(\\w+\\)" . (1 font-lock-type-face))
   '("const *\\(\\w+\\)" . (1 font-lock-constant-face))
   '("let *\\(\\w+\\)" . (1 font-lock-variable-name-face))
   '("struct *\\(\\w+\\)" . (1 font-lock-type-face))
   '("\\(fn\\|op\\) *\\(\\(\\w+\\|\\.\\)*\\)" . (2 font-lock-function-name-face))
   '("\\(\\(\\w+\\) *: *\\(\\w+\\)\\)" . ((2 font-lock-variable-name-face)
                                              (3 font-lock-type-face)))
   '("\\(\\w+\\) *=" . font-lock-variable-name-face)
   '("\\(\\w+\\)\\[\\(\\w+\\)\\]" . ((1 font-lock-variable-name-face)
                                     (2 font-lock-variable-name-face)))
   '("is *\\(\\w+\\) *\\(, *\\(\\w+\\)\\)*;" . ((1 font-lock-type-face)
                                              (3 font-lock-type-face)))
   '("\\(\\w+\\)(\\(\\w+\\)?\\(, *\\(\\w+\\)\\)*)" . ((1 font-lock-function-name-face)
                                                      (2 font-lock-variable-name-face)
                                                      (4 font-lock-variable-name-face))))
  "Syntax highlighting expressions for pivot-mode.")

(defvar pivot-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for pivot-mode.")

(defun pivot-mode ()
  "Major mode for editing Pivot files."
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table pivot-mode-syntax-table)
  (use-local-map pivot-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(pivot-font-lock-keywords))
  (setq major-mode 'pivot-mode)
  (setq mode-name "Pivot")
  (run-hooks 'pivot-mode-hook))

(provide 'pivot-mode)
;;; pivot-mode.el ends here

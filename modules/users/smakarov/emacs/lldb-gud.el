;;; Package --- Summary
;;; Commentary:
;;  Author: Kevin Schmidt
;;
;; This file is a modified code from gud.el that attempts to add lldb support
;; to Emacs
;;
;; This file is released under the GPL v3
;;
;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;;; Code:
(require 'gud)

(defvar gud-lldb-marker-regexp
  ;; This uses a special marker from lldb-gud.settings
  ;; This will probably fail on windows due to the colon?
  (concat "^GUD-LLDB: \\([^" ":" "\n]*\\)" ":"
	  "\\([0-9]*\\)" ".*\n.*"))

(defun gud-lldb-marker-filter (string)
  (setq gud-marker-acc (concat gud-marker-acc string))
  (let ((output ""))

    ;; Process all the complete markers in this chunk.
    (while (string-match gud-lldb-marker-regexp gud-marker-acc)
      (setq

       ;; Extract the frame position from the marker.
       gud-last-frame (cons (match-string 1 gud-marker-acc)
			    (string-to-number (match-string 2 gud-marker-acc)))

       ;; Append any text before the marker to the output we're going
       ;; to return - we don't include the marker in this text.
       output (concat output
		      (substring gud-marker-acc 0 (match-beginning 0)))

       ;; Set the accumulator to the remaining text.
       gud-marker-acc (substring gud-marker-acc (match-end 0))))

    (while (string-match "\n\032\032\\(.*\\)\n" gud-marker-acc)
      (setq
       ;; Append any text before the marker to the output we're going
       ;; to return - we don't include the marker in this text.
       output (concat output
		      (substring gud-marker-acc 0 (match-beginning 0)))

       ;; Set the accumulator to the remaining text.

       gud-marker-acc (substring gud-marker-acc (match-end 0))))

    ;; Does the remaining text look like it might end with the
    ;; beginning of another marker?  If it does, then keep it in
    ;; gud-marker-acc until we receive the rest of it.  Since we
    ;; know the full marker regexp above failed, it's pretty simple to
    ;; test for marker starts.
    (if (string-match "\n\\(\032.*\\)?\\'" gud-marker-acc)
	(progn
	  ;; Everything before the potential marker start can be output.
	  (setq output (concat output (substring gud-marker-acc
						 0 (match-beginning 0))))

	  ;; Everything after, we save, to combine with later input.
	  (setq gud-marker-acc
		(substring gud-marker-acc (match-beginning 0))))

      (setq output (concat output gud-marker-acc)
	    gud-marker-acc ""))

    output))


(defcustom gud-lldb-command-name
  (format "%s --source %s " "lldb"
          (concat (file-name-directory (or load-file-name buffer-file-name))
                  "lldb-gud.settings"))
  "Default command to run an executable under GDB in text command mode.
The option \"--fullname\" must be included in this value."
   :type 'string
   :group 'gud)

(defun gud-lldb (command-line)
  "Run gdb on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working
directory and source-file directory for your debugger."
  (interactive (list (gud-query-cmdline 'lldb)))

  (when (and gud-comint-buffer
	   (buffer-name gud-comint-buffer)
	   (get-buffer-process gud-comint-buffer)
	   (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'lldb)))
    (lldb-restore-windows)
    (error
     "Multiple debugging requires restarting in text command mode"))

  (gud-common-init command-line nil 'gud-lldb-marker-filter)
  (set (make-local-variable 'gud-minor-mode) 'lldb)

  (gud-def gud-break  "b %f:%l"  "\C-b" "Set breakpoint at current line.")
  (gud-def gud-tbreak "tbreak %f:%l" "\C-t"
	   "Set temporary breakpoint at current line.")
  (gud-def gud-remove "clear %f:%l" "\C-d" "Remove breakpoint at current line")
  (gud-def gud-step   "step %p"     "\C-s" "Step one source line with display.")
  (gud-def gud-stepi  "stepi %p"    "\C-i" "Step one instruction with display.")
  (gud-def gud-next   "next %p"     "\C-n" "Step one line (skip functions).")
  (gud-def gud-nexti  "nexti %p" nil   "Step one instruction (skip functions).")
  (gud-def gud-cont   "cont"     "\C-r" "Continue with display.")
  (gud-def gud-finish "finish"   "\C-f" "Finish executing current function.")
  (gud-def gud-jump
	   (progn (gud-call "tbreak %f:%l") (gud-call "jump %f:%l"))
	   "\C-j" "Set execution address to current line.")

  (gud-def gud-up     "up %p"     "<" "Up N stack frames (numeric arg).")
  (gud-def gud-down   "down %p"   ">" "Down N stack frames (numeric arg).")
  (gud-def gud-print  "print %e"  "\C-p" "Evaluate C expression at point.")
  (gud-def gud-pstar  "print* %e" nil
	   "Evaluate C dereferenced pointer expression at point.")

  ;; For debugging Emacs only.
  (gud-def gud-pv "pv %e"      "\C-v" "Print the value of the lisp variable.")

  (gud-def gud-until  "until %l" "\C-u" "Continue to current line.")
  (gud-def gud-run    "run"	 nil    "Run the program.")

  (add-hook 'completion-at-point-functions #'gud-gdb-completion-at-point
            nil 'local)
  (set (make-local-variable 'gud-gdb-completion-function) 'gud-gdb-completions)

  (local-set-key "\C-i" 'completion-at-point)
  (setq comint-prompt-regexp "^(.*gdb[+]?) *")
  (setq paragraph-start comint-prompt-regexp)
  (setq gdb-first-prompt t)
  (setq gud-running nil)
  (setq gud-filter-pending-text nil)
  (run-hooks 'gud-gdb-mode-hook))

(provide 'lldb-gud)
;;; lldb-gud.el ends here

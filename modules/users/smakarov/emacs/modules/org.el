;;; package --- Summary
;;; Commentary:
;;; Settings for org-mode

;;; Code:

(use-package poporg
  :bind (("C-c /" . poporg-dwim)))

(use-package ox-md
  :defer t)
(use-package org-tempo)

(use-package ox-latex
  :defer t
  :config
    (add-to-list 'org-latex-classes
               '("course" "\\documentclass{BYUPhys}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package org-ref
  :defer t
  :custom
  (reftex-default-bibliography '("~/Projects/Hometask/bibliography/references.bib"))
  (org-ref-bibliography-notes "~/Projects/Hometask/bibliography/notes.org")
  (org-ref-default-bibliography '("~/Projects/Hometask/bibliography/references.bib"))
  (org-ref-pdf-directory '("~/Projects/Hometask/bibliography/bibtex-pdfs/"))
  (bibtex-completion-biography "~/Projects/Hometask/bibliography/references.bib")
  (bibtex-completion-library-path "~/Projects/Hometask/bibliography/bibtex-pdfs")
  (bibtex-completion-notes-path "~/Projects/Hometask/bibliography/helm-bibtex-notes")
  (bibtex-completion-pdf-open-function 'org-open-file))

(use-package org-gcal
  :custom
  (org-gcal-client-id "@orgGcalClientId@")
  (org-gcal-client-secret "@orgGcalClientSecret@")
  (org-gcal-fetch-file-alist '(("setser200018@gmail.com" . "~/org/schedule.org")))
  :defer t)

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :defer t
  :init
  (defun bh/verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))
  :mode (("\\.org$" . org-mode))
  :config
  (org-babel-do-load-languages 'org-babel-load-languages
        '((emacs-lisp . t)
          (C . t)
          (dot . t)
          (gnuplot . t)
          (latex . t)
          (shell . t)))
  :custom
  (org-agenda-files (list "~/org"))
  (org-log-done t)
  (org-enforce-todo-dependencies t)
  (org-use-fast-todo-selection t)
  (org-default-notes-file "~/org/notes.org")
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                       (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  (org-todo-keyword-faces '(("TODO" :foreground "red" :weight bold)
                            ("NEXT" :foreground "blue" :weight bold)
                            ("DONE" :foreground "forest green" :weight bold)
                            ("WAITING" :foreground "orange" :weight bold)
                            ("HOLD" :foreground "magenta" :weight bold)
                            ("CANCELLED" :foreground "forest green" :weight bold)))
  (org-refile-targets '((nil :maxlevel . 9)
                        (org-agenda-files :maxlevel . 9)))
  (org-refile-target-verify-function 'bh/verify-refile-target)
  (org-agenda-custom-commands '(("N" todo "NEXT")))
  (org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                  ("WAITING" ("WAITING" . t))
                                  ("HOLD" ("WAITING") ("HOLD" . t))
                                  (done ("WAITING") ("HOLD"))
                                  ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                  ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                  ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))
  (org-capture-templates
        '(("t" "TODO" entry (file+headline "~/org/notes.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")))
  (org-latex-listings 'minted)
  (org-latex-packages-alist '(("AUTO" "babel" t ("pdflatex"))
                              ("AUTO" "polyglossia" t ("xelatex" "lualatex"))))
  (org-latex-pdf-process '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
	                        "%bib %b"
	                        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
	                        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (org-confirm-babel-evaluate (lambda (lang body)
                                     (not (or (string= lang "dot")
                                              (string= lang "sql"))))))

;;; org.el ends here

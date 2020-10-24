;;; package --- Summary
;;; Commentary:
;;; Settings for org-mode

;;; Code:

(use-package ox-md)
(use-package org-tempo)

(use-package ox-latex
  :config
    (add-to-list 'org-latex-classes
               '("course" "\\documentclass{BYUPhys}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package org-ref
 :config
 (setq reftex-default-bibliography '("~/Projects/Hometask/bibliography/references.bib"))
 (setq org-ref-bibliography-notes "~/Projects/Hometask/bibliography/notes.org"
       org-ref-default-bibliography '("~/Projects/Hometask/bibliography/references.bib")
       org-ref-pdf-directory '("~/Projects/Hometask/bibliography/bibtex-pdfs/")
       org-ref-completion-library 'org-ref-ivy-cite)
 (setq bibtex-completion-biography "~/Projects/Hometask/bibliography/references.bib"
       bibtex-completion-library-path "~/Projects/Hometask/bibliography/bibtex-pdfs"
       bibtex-completion-notes-path "~/Projects/Hometask/bibliography/helm-bibtex-notes")
 (setq bibtex-completion-pdf-open-function 'org-open-file))

(use-package org-gcal
  :config
  (setq org-gcal-client-id "@orgGcalClientId@"
        org-gcal-client-secret "@orgGcalClientSecret@"
        org-gcal-fetch-file-alist '(("setser200018@gmail.com" . "~/org/schedule.org"))))

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-agenda-files (list "~/org")
        org-log-done t
        org-enforce-todo-dependencies t)
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("AUTO" "babel" t ("pdflatex"))
                                   ("AUTO" "polyglossia" t ("xelatex" "lualatex")))
        org-latex-pdf-process '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
	                        "%bib %b"
	                        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
	                        "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-confirm-babel-evaluate (lambda (lang body)
                                     (not (or (string= lang "dot")
                                              (string= lang "sql")))))
  (org-babel-do-load-languages 'org-babel-load-languages
        '((emacs-lisp . t)
          (C . t)
          (dot . t)
          (gnuplot . t)
          (latex . t)
          (shell . t))))

;;; org.el ends here

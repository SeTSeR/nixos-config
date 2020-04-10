;;; package --- Summary
;;; Commentary:
;;; Settings for org-mode

;;; Code:

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/hobby.org"))

(use-package ob-C
  :commands (org-babel-execute:C
             org-babel-expand-body:C))

(use-package ob-C++
  :commands (org-babel-execute:C++
             org-babel-expand-body:C++))

(use-package ob-dot
  :commands (org-babel-execute:dot
             org-babel-expand-body:dot))

(use-package ob-emacs-lisp
  :commands (org-babel-execute:emacs-lisp
             org-babel-expand-body:emacs-lisp))

(use-package ob-haskell
  :commands (org-babel-execute:haskell
             org-babel-expand-body:haskell))

(use-package ob-latex
  :commands (org-babel-execute:latex
             org-babel-expand-body:latex
             org-babel-prep-session:latex))

(use-package ob-org
  :commands (org-babel-execute:org
             org-babel-expand-body:org
             org-babel-prep-session:org))

(use-package ob-plantuml
  :commands (org-babel-execute:plantuml
             org-babel-prep-session:plantuml
             org-babel-variable-assignments:plantuml)
  :config (setq org-plantuml-jar-path
                (expand-file-name "@plantUMLjar@")))

(use-package ob-python
  :commands (org-babel-execute:python))

(use-package ob-scheme
  :commands (org-babel-execute:scheme
             org-babel-expand-body:scheme))

(use-package ob-shell
  :commands (org-babel-execute:sh
             org-babel-expand-body:sh
             org-babel-execute:bash
             org-babel-expand-body:bash))

(use-package ob-sql
  :commands (org-babel-execute:sql))

(use-package ob-gnuplot
  :commands (org-babel-execute:gnuplot))

(use-package ox-md)
(use-package ox-textile)
(use-package org-tempo)

(use-package org-ref
 :config
 (setq reftex-default-bibliography '("~/Projects/Hometask/bibliography/references.bib"))
 (setq org-ref-bibliography-notes "~/Projects/Hometask/bibliography/notes.org"
       org-ref-default-bibliography '("~/Projects/Hometask/bibliography/references.bib")
       org-ref-pdf-directory '("~/Projects/Hometask/bibliography/bibtex-pdfs/"))
 (setq bibtex-completion-biography "~/Projects/Hometask/bibliography/references.bib"
       bibtex-completion-library-path "~/Projects/Hometask/bibliography/bibtex-pdfs"
       bibtex-completion-notes-path "~/Projects/Hometask/bibliography/helm-bibtex-notes")
 (setq bibtex-completion-pdf-open-function 'org-open-file))

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-log-done t)
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -bibtex -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -bibtex -output-directory %o %f")))

;;; org.el ends here

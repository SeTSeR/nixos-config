;;; package --- Summary
;;; Commentary:
;;; Settings for org-mode

;;; Code:

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
                             "~/org/hobby.org"))

(use-package ox-md)
(use-package ox-textile)
(use-package org-tempo)

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

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-log-done t)
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
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

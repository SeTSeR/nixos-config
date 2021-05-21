;;;  nix-proced-readable-mode.el --- Make proced filenames more readable in NixOS and GuixSD

;; © 2019-∞ Peter 11111000000 <11111000000@email.com>

;; Autor: Peter 11111000000 <11111000000@email.com>
;; Maintainer: Peter 11111000000 <11111000000@email.com>
;; URL: https://gist.github.com/11111000000/e20247bafb425a58bd9d9198a16d56d0
;; Keywords: guix nix proced
;; Package-Version: 0.1
;; Version: 0.1

;;; License

;; This file is not part of GNU Emacs.
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;
;; Make proced filenames more readable in NixOS and GuixSD
;;

;;; Code:

(defvar nix-proced-readable-mode-keywords
  '(("\\(/nix/store/[0-9a-z]*-\\)"
     (1 '(face nil invisible t)))
    ("\\(/gnu/store/[0-9a-z]*-\\)"
     (1 '(face nil invisible t)))
    ))

(define-minor-mode nix-proced-readable-mode
  "Make proced filenames more readable in NixOS and GuixSD"
  :lighter " proced-hash-filter-mode"
  (if nix-proced-readable-mode
      (progn
        (make-variable-buffer-local 'font-lock-extra-managed-props)
        (add-to-list 'font-lock-extra-managed-props 'invisible)
        (font-lock-add-keywords nil
                                nix-proced-readable-mode-keywords)
        (font-lock-mode t)
        )
    
    (progn
      (font-lock-remove-keywords nil
                                 nix-proced-readable-mode-keywords)
      (font-lock-mode t)
      )
    )
  
  )

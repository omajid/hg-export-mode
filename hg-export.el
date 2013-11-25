;;; hg-export-mode -- a mode for reading hg's export files

;; Copyright (c) 2013 Omair Majid

;; Author: Omair Majid <omair.majid@gmail.com>
;; Version: 0.1.0
;; Homepage: https://github.com/omajid/hg-export-mode
;; Keywords: convenience diff hg

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for working with files produced by hg export.

;;; Code:

(defvar hg-export-mode-hook nil)

(defvar hg-export-user-face 'hg-export-user-face)

(defgroup hg-export-faces nil
  "Faces used in HG/Export mode"
  :group 'hg-export
  :group 'faces)

(defface hg-export-user-face
  '((t (:inherit font-lock-variable-name-face :weight bold)))
  "Face for user names"
  :group 'hg-export-faces)

(define-derived-mode hg-export-mode diff-mode "HG/Export"
  "Major mode for working with hg's export/patch files"
  (let ((hg-export-date-regexp "^# Date \\([0-9]+\\) \\([0-9]+\\)")
	(hg-export-user-regexp "^\\(# User \\)\\(.*\\)$")
	(display-as-time
	 (lambda ()
	   (progn
	     (put-text-property (match-beginning 1)
				(match-end 1)
				'display (format-time-string
					  "%Y-%m-%dT%T%z"
					  (seconds-to-time
					   (+ (string-to-number (match-string 1))
					      (string-to-number (match-string 2))))
					  1))
	     (put-text-property (match-beginning 2)
				(match-end 2)
				'display "")))))
    (font-lock-add-keywords
     nil
     `((,hg-export-date-regexp . (,display-as-time))
       (,hg-export-user-regexp (1 'font-lock-comment-face)
			       (2 hg-export-user-face))))))


(provide 'hg-export-mode)

;;; hg-export.el ends here

;;; hg-export-mode -- a mode for reading hg's export files

;;; Commentary:
; Makes it easier to work on patches produced by 'hg export':
; 
; - Show header timestamps as dates
;
;
; My first mode.  Please be gentle.

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
	(show-time
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
     `((,hg-export-date-regexp . (,show-time))
       (,hg-export-user-regexp (1 'font-lock-comment-face)
			       (2 hg-export-user-face))))))


(provide 'hg-export-mode)
;;; hg-export.el ends here

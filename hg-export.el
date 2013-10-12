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

(define-derived-mode
  hg-export-mode diff-mode "HG/Export"
  "Major mode for working with hg's export/patch files"
  (let ((hg-export-date-regexp "^# Date \\([0-9]+\\) \\([0-9]+\\)")
	(show-time
	 (lambda ()
	   (put-text-property (match-beginning 1)
			      (match-end 1)
			      'display (format-time-string
					"%Y-%m-%d"
					(seconds-to-time
					 (string-to-number (match-string 1))))))))
    (font-lock-add-keywords
     nil
     `((,hg-export-date-regexp . (,show-time))))))


(provide 'hg-export-mode)
;;; hg-export.el ends here

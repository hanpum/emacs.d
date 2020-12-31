(setq emacsroot "~/.emacs.d")
(setq orgroot "~/.emacs.d/gtd")
(setq org-directory orgroot)


(use-package org
  :config
  (auto-fill-mode t)
  (require 'org-ref)
  (add-to-list 'org-export-backends 'md)
  (define-key org-mode-map (kbd "C-c C-c") (lambda ()
					     (interactive)
					     (org-ctrl-c-ctrl-c)
					     (org-redisplay-inline-images)))
  
  ;; highlight
  (setf org-highlight-latex-and-related '(latex script entities))

  ;; set variables
  (setq org-agenda-files (list (concat orgroot "/inbox.org")
			       "~/projects/sds/competive_analysis/competetor.org"
			       (concat orgroot "/paper.org"))

	org-ditaa-jar-path (expand-file-name "ditaa0_9.jar" "~/.local/lib")
	plantuml-jar-path (expand-file-name "plantuml.jar" "~/.local/lib")
	org-plantuml-jar-path (expand-file-name "plantuml.jar" "~/.local/lib")
	plantuml-default-exec-mode 'jar

	org-latex-compiler "xelatex"
	org-export-async-debug nil

	;; add todo keywords
	org-todo-keywords '((sequence "TODO" "ONGOING" "NEXT" "SOMEDAY" "WAIT(w@)" "|" "DONE(d@/!)" "CANCEL(c@/!)"))


	;; set tag list 
	org-tag-alist '((:startgroup . "       type") 
			("@sds" . ?s)
			(:endgroup . nil))

	;; capture
	org-default-notes-file (concat org-directory "/inbox.org")
	org-capture-templates
	'(("t" "Task"     entry (file+headline "" "Tasks")   "* TODO %? %t\n %i\n %a")
	  ("T" "Tool"     entry (file+headline "" "Tools")   "* TODO %? %t\n %i\n %a")
	  ("n" "Note"     entry (file+headline "" "Notes")   "* %? %t\n %i\n %a")
	  ("r" "Reading"  entry (file+headline "" "Reading") "* TODO %? %t\n %i\n %a")
	  ("p" "Paper"    entry (file+headline "" "Papers")  "* TODO %? %t\n %i\n %a")
	  ("c" "Calendar" entry (file+headline "" "Calendars") "* TODO %? %t\n %i\n %a"))

	org-refile-targets '( (nil :level . 1)))


  (mapcar
   (lambda (item)
     (setq-local npath (concat orgroot item))
     (message npath)
     ;;(add-to-list 'org-refile-targets '(npath :level . 1))
     )
   '("/inbox.org" "/arch/2020/7.org" "/cancel.org"))

	;; refine
	;; org-refile-targets '(
	;; 		     ( nil :level . 1)
	;; 		     ( (concat orgroot "/inbox.org") :level . 1)
	;; 		     ( (concat orgroot "/arch/2020/4.org") :level . 1)
	;; 		     ( (concat orgroot "/cancel.org") :level . 1)
	;; 		     ( (concat orgroot "/note.org") :maxlevel . 1)
	;; 		     ( (concat orgroot "/canceled.org") :maxlevel . 1)
	;; 		     ( (concat orgroot "/paper.org") :maxlevel . 1)
	;; 		     ( (concat orgroot "/finished.org") :maxlevel . 1)))


  (org-babel-do-load-languages 'org-babel-load-languages
			       '((ditaa t)
				 (plantuml t)
				 (latex t)
				 (shell t)
				 (org t)
				 (dot t)
				 (emacs-lisp t)))

  ;; the following lines are always need
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (global-set-key "\C-cc" 'org-capture)

  ;; shortcut keys
  (mapcar (lambda (item)
	    (add-to-list 'org-structure-template-alist item t))
	  '(("n" . "note")
	    ("w" . "warning")
	    ("T" . "tip")
	    ("u" . "caution")
	    ("m" . "important"))))


(use-package org-ref
  :ensure t
  :init
  (setq bibtex-completion-pdf-field "file"
	bibtex-completion-display-formats '((t . "${author:15}  ${year:4}  ${keywords:20}  ${title:*} ${=has-pdf=:1} ${=has-note=:1} "))
	bibtex-completion-additional-search-fields '("keywords" "tags")
	bibtex-completion-pdf-symbol "P"
	bibtex-completion-notes-symbol "N"

	org-ref-notes-function (lambda (key)
				 (let* ((bibtex-completion-bibliography (org-ref-find-bibliography)))
				   (bibtex-completion-edit-notes
				    (list (car
					   (org-ref-get-bibtex-key-and-file key)))))) 

	bibtex-autokey-year-length 4 
	bibtex-autokey-name-year-separator "-"
	bibtex-autokey-year-title-separator "-"
	bibtex-autokey-titleword-separator "-"
	bibtex-autokey-titlewords 2
	bibtex-autokey-titleword-length 5
	bibtex-autokey-titlewords-stretch 1)
  :commands org-ref-helm-insert-cite-link
  :config
  (let* ((paperDir (concat emacsroot "/data/papers")))
    (setq bibtex-completion-notes-path (concat paperDir "/notes")
	  bibtex-completion-library-path (concat paperDir "/pdfs")

	  org-ref-open-pdf-function 'org-ref-open-bibtex-pdf
	  org-ref-pdf-directory (concat paperDir "/pdfs")
	  org-ref-notes-directory (concat paperDir "/notes")
	  org-ref-default-bibliography (directory-files (concat paperDir "/bibs") t "[-a-zA-Z0-9]*\.bib")

	  bibtex-completion-notes-template-multiple-files (with-temp-buffer
							    (insert-file-contents (concat paperDir "/notes/template.org"))
							    (buffer-string))))
  ;; (use-package org-ref-citeproc)
  ;; (setq org-export-before-parsing-hook '(orcp-citeproc))
  )

;; (add-to-list 'bibtex-mode-hook '(lambda nil (require 'org-ref)))

;; todo remove this to plantuml config section
(defun my-plantuml-completion-at-point ()
  "Function used for `completion-at-point-functions' in `plantuml-mode'."
  (let ((completion-ignore-case t)
	(bounds (bounds-of-thing-at-point 'symbol))
	(keywords plantuml-kwdList))
    (when (and bounds keywords)
      (list (car bounds)
	    (cdr bounds)
	    keywords
	    :exclusive 'no
	    :company-docsig #'identity))))

(add-hook 'plantuml-mode-hook (lambda()
				(add-hook 'completion-at-point-functions 'my-plantuml-completion-at-point)))


(provide 'init-org)

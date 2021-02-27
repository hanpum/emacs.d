(use-package geiser
  :bind (("C-c h m" . (lambda ()
			(interactive)
			(let ((word (symbol-name (symbol-at-point))))
			  (if word
			      (progn
				(info "mit-scheme-ref")
				(Info-index word))
			    (message "can't find manual"))))))
  :config
  (setq geiser-active-implementations '(mit)
	;; disable auto-complete as very slow
	geiser-log-verbose-p nil
	geiser-log-verbose-debug-p nil
	geiser-repl-company-p t
	geiser-mode-company-p t))

(use-package emacs-lisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
	      ("C-c ." . 'find-function)
	      ("C-c ," . 'pop-global-mark)))


(provide 'init-lisp)

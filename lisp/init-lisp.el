(use-package geiser
  :config
  (setq geiser-active-implementations '(mit)
	;; disable auto-complete as very slow
	geiser-repl-company-p nil
	geiser-mode-company-p nil))

(use-package emacs-lisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
	      ("C-c ." . 'find-function)
	      ("C-c ," . 'pop-global-mark)))


(provide 'init-lisp)

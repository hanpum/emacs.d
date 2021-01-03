(use-package geiser
  :config
  (setq geiser-active-implementations '(mit)
	;; disable auto-complete as very slow
	geiser-repl-company-p nil
	geiser-mode-company-p nil))

(provide 'init-lisp)

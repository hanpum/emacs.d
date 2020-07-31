(use-package company-jedi
  :after python
  :config
  (setq
   jedi:use-shortcuts t
   jedi:complete-on-dot t
   jedi:imenu-create-index-function 'jedi:create-flat-imenu-index))

;; configuration for python
(use-package python
  :after company
  :bind (:map python-mode-map
	      ([f5] . 'my/run-current-buffer)
	      ("C-c ." . 'jedi:goto-definition)
	      ("C-c C-c" . 'comment-region)
	      ("C-c h m" . 'jedi:show-doc))
  :hook (python-mode .
		     (lambda nil
		       (progn
			 (flycheck-mode)
			 (add-to-list 'company-backends 'company-jedi)
			 (setq-local
			  imenu-create-index-function #'python-imenu-create-flat-index))))
  :config
  (jedi:setup)
  (setq python-shell-interpreter "python3"))

(provide 'init-python)

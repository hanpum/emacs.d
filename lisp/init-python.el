(use-package company-jedi
  :after python
  :hook (python-mode . jedi:setup)
  :config
  (setq
   jedi:use-shortcuts t
   jedi:complete-on-dot t
   jedi:environment-virtualenv (append python-environment-virtualenv '("--python" "/usr/local/bin/python3"))
   jedi:server-args '("--log-traceback" "--log-level" "DEBUG")
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
			 (hs-minor-mode)
			 (flycheck-mode)
			 (make-local-variable 'company-backends)
			 (add-to-list 'company-backends 'company-jedi)
			 (setq-local
			  imenu-create-index-function #'python-imenu-create-flat-index))))
  :config
  (jedi:setup)
  (setq python-shell-interpreter "python3"))

(provide 'init-python)

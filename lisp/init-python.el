(use-package company-jedi
  :after python
  :config
  (setq
   jedi:use-shortcuts t
   jedi:complete-on-dot t)
  )

;; configuration for python
(use-package python
  :after company
  :bind (:map python-mode-map
	      ([f5] . 'my/run-current-buffer)
	      ("C-c ]" . 'jedi:goto-definition)
	      ("C-c h i" . 'jedi:show-doc))
  :hook (python-mode . flycheck-mode)
  :config
  (jedi:setup)
  (setq python-shell-interpreter "python3")
  (add-to-list 'company-backends 'company-jedi))

(provide 'init-python)

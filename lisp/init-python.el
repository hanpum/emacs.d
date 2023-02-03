

;; configuration for python
(use-package python
  :after company
  :bind (:map python-mode-map
              ([f5] . 'my/run-current-buffer)
              ("C-c ." . 'jedi:goto-definition)
              ("C-c ," . 'jedi:goto-definition-pop-marker)
              ("C-c C-c" . 'comment-region)
              ("C-c h m" . 'jedi:show-doc))
  :hook (python-mode . (lambda nil
                         (progn
                           (hs-minor-mode)
                           (flycheck-mode)
                           (make-local-variable 'company-backends)
                           (add-to-list 'company-backends 'company-jedi)
                           (setq-local
                            imenu-create-index-function #'python-imenu-create-flat-index))))
  :config
  (jedi:setup)
  (require 'python-black)
  (setq python-shell-interpreter "python3"))

(use-package python-black
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

(provide 'init-python)

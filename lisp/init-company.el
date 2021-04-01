;; enable company-mode default
(use-package company
  ;;:init (global-company-mode 1)
  :bind (:map company-active-map
	      ("M-n" . nil)
	      ("M-p" . nil)
	      ("C-n" . company-select-next-or-abort)
	      ("C-p" . company-select-previous-or-abort)
	      ("C-c [?\t]" . helm-company)
	      :map company-mode-map
	      ("C-c [?\t]" . helm-company))
  :config
  (setq company-idle-delay 0.05
	company-minimum-prefix-length 1
	company-selection-wrap-around t
	company-tooltip-align-annotations t
	company-transformers '(company-sort-by-occurrence)

	;; remove some backends
	company-backends (seq-filter (lambda (func)
				       (not
					(or (eq func 'company-clang)
					    (eq func 'company-cmake)
					    (eq func 'company-gtags)
					    (eq func 'company-semantic))))
				     company-backends)))



;; disable semantic
(semantic-mode -1)
(setq semantic-default-submodes nil)


(add-hook 'after-init-hook '(lambda nil
			      (progn
				(global-company-mode))))
(provide 'init-company)

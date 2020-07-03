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
	company-minimum-prefix-length 2
	company-selection-wrap-around t
	company-tooltip-align-annotations t
	company-transformers '(company-sort-by-occurrence))
  (setq company-backends (delete 'company-semantic company-backends)))



;;(use-package ede
;;  :init
;;  (global-ede-mode)
;;  :commands global-ede-mode
;;  :hook ((c-mode c++-mode) . ede-minor-mode))
;;(add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb)))

;; (require 'cc-mode)
;; (use-package semantic
;;   :config
;;   (use-package semantic/ia)
;;   (use-package semantic/sb)
;;   (semantic-add-system-include "/usr/local/include")
;;   (semantic-add-system-include "/usr/local/include/c++/5.5.0" 'c++-mode)
;;   (semantic-add-system-include "/usr/local/include/boost" 'c++-mode)
;;   (setq semantic-default-submodes (append semantic-default-submodes
;; 					  '(global-semantic-stickyfunc-mode
;; 					    global-semantic-highlight-func-mode
;; 					    global-semantic-show-parser-state-mode
;; 					    global-semantic-show-unmatched-syntax-mode))))
;; (global-semantic-idle-summary-mode 1)

;; disable semantic
(semantic-mode -1)
(setq semantic-default-submodes nil)


(add-hook 'after-init-hook '(lambda nil
			      (progn
				(global-company-mode))))
(provide 'init-company)

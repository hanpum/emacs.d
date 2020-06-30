;; enable company-mode default
(use-package company
  ;;:init (global-company-mode 1)
  :bind (:map company-active-map
	      ("C-n" . company-select-next-or-abort)
	      ("C-p" . company-select-previous-or-abort)
	      ("C-c [?\t]" . helm-company)
	      :map company-mode-map
	      ("C-c [?\t]" . helm-company))
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 2)
  (setq company-backends (delete 'company-semantic company-backends)))


(use-package company-c-headers
  :commands company-c-headers
  :config
  (add-to-list 'company-c-headers-path-system "/usr/local/include/c++/5.5.0/"))


(defun my:setupCMode nil
  "do configuration for c/c++ mode"
  (progn
    (add-to-list 'company-backends 'company-c-headers)))

(add-hook 'c-mode-hook 'my:setupCMode nil t)
(add-hook 'c++-mode-hook 'my:setupCMode nil t)
(add-hook 'cmake-mode-hook (lambda ()
			     (add-to-list 'company-backends 'company-cmake)))


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


;; configuration for python
(use-package python
  :after company
  :bind (:map python-mode-map
	      ([f5] . 'my/run-current-buffer))
  :config
  (jedi:setup)
  (setq python-shell-interpreter "python3")
  (add-to-list 'company-backends 'company-jedi))


(add-hook 'after-init-hook '(lambda nil
			      (progn
				(global-company-mode))))

(add-hook 'scheme-mode
	  (lambda ()
	    (setq company-backends
		  (delete 'geiser-company-backend company-backends))))

(provide 'init-company)

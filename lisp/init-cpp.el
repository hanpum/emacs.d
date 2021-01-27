(use-package cmake-mode
  :ensure nil
  :config
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-cmake))


(use-package company-c-headers
  :commands company-c-headers
  :config
  (add-to-list 'company-c-headers-path-system "/usr/local/include/c++/5.5.0/"))


(use-package helm-rtags
  :after helm)

(use-package company-rtags
  :after company rtags
  :config
  (make-local-variable 'company-backends)
  (setq company-backends (seq-filter (lambda (func)
				       (not
					(or (eq func 'company-clang)
					    (eq func 'company-cmake)
					    (eq func 'company-gtags))))
				     company-backends))
  (add-to-list 'company-backends 'company-rtags))


(use-package flycheck-rtags
  :after flycheck rtags cc-mode)


(use-package rtags
  :commands rtags-diagnostics
  :bind (:map c-mode-base-map
	      ("C-c j" . 'rtags-imenu)
	      ("C-c ." . 'rtags-find-symbol-at-point)
	      ("M-RET" . 'rtags-fixit)
	      ("C-c ," . 'rtags-location-stack-back)
	      ("C-c r" . 'rtags-find-references-at-point))
  :config
  ;;(rtags-enable-standard-keybindings)
  (setq rtags-use-helm t
	rtags-display-result-backend 'helm
	rtags-autostart-diagnostics t
	rtags-completions-enabled t)
  (require 'helm-rtags)
  (require 'company-rtags)
  (require 'flycheck-rtags))


(use-package cc-mode
  :ensure nil
  :hook ((c++-mode c-mode) . (lambda nil
				(flycheck-mode)
				(flycheck-select-checker 'rtags)
				(setq-local flycheck-highlighting-mode 'lines)))
  :config
  (require 'rtags)
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-c-headers))


(provide 'init-cpp)

(use-package cmake-mode
  :ensure nil
  :config
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-cmake))


(use-package cmake-font-lock
  :commands cmake-font-lock-activate
  :hook (cmake-mode . cmake-font-lock-activate))


(use-package company-c-headers
  :commands company-c-headers
  :config
  (add-to-list 'company-c-headers-path-system "/usr/local/include/c++/5.5.0/"))


(use-package helm-rtags
  :after helm rtags)


(use-package company-rtags
  :after company rtags)


(use-package flycheck-rtags
  :after flycheck rtags)


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
	rtags-rc-log-enabled t
	rtags-completions-enabled t
	rtags-autostart-diagnostics t
	rtags-display-result-backend 'helm)
  )


(use-package highlight-doxygen)


(use-package cc-mode
  :ensure nil
  :hook ((c++-mode c-mode) . (lambda nil
			       (flycheck-mode)
			       (flycheck-select-checker 'rtags)
			       (setq-local flycheck-highlighting-mode 'lines)
			       (highlight-doxygen-mode)
			       ;; (rtags-start-process-unless-running)
			       (make-local-variable 'company-backends)
			       (add-to-list 'company-backends 'company-rtags)
			       (add-to-list 'company-backends 'company-c-headers)))
  :config
  (require 'rtags)
  (require 'company-rtags)
  (require 'flycheck-rtags)
  (require 'company-c-headers)
  (require 'highlight-doxygen))


(use-package bazel-mode)
(use-package protobuf-mode
  :mode "\\.pb\\'")


(provide 'init-cpp)

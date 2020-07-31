;; gc config for boost startup
(setq gc-cons-threshold (* 100 1000 1000))
(toggle-debug-on-error)

(setq emacsroot "~/.emacs.d")

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ("org" . "https://elpa.emacs-china.org/org/")))

(package-initialize)
(require 'use-package)
(setq use-package-verbose t
      use-package-always-defer t
      use-package-always-ensure t)

(setq package-check-signature nil)

;; setup customize init scripts path 
(add-to-list 'load-path (expand-file-name "lisp" emacsroot))


(require 'init-misc)

(require 'init-org)

(require 'init-helm-gtags)

(require 'init-company)

(require 'init-tex)

(require 'init-python)
(require 'init-cpp)
(require 'init-lisp)



;; start up time profile
(add-hook 'emacs-startup-hook (lambda ()
				(message "emacs start in %s with %d garbage collections"
					 (format "%.2fseconds" (float-time (time-subtract after-init-time before-init-time)))
					 gcs-done)))

(setq g-cons-threshold (* 20 1000 1000))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(electric-pair-pairs (quote ((34 . 34) (8216 . 8217) (8220 . 8221))))
 '(package-selected-packages
   (quote
    (cmake-ide company-rtags flycheck-rtags helm-rtags rtags bazel-mode protobuf-mode org-ref markdown-mode markdown-mode+ markdown-preview-mode markdown-toc google-translate org-plus-contrib tide js2-refactor js2-mode yaml-mode yasnippet-snippets use-package srefactor sr-speedbar session rainbow-mode projectile-codesearch org-make-toc latex-math-preview json-mode highlight-parentheses highlight-doxygen helm-projectile helm-mt helm-gtags helm-flycheck helm-company graphviz-dot-mode geiser function-args flycheck-plantuml exec-path-from-shell evil conda company-tabnine company-shell company-reftex company-math company-jedi company-c-headers cmake-font-lock cdlatex bison-mode auctex)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

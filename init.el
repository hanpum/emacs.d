;; gc config for boost startup
(setq gc-cons-threshold (* 100 1000 1000))
(toggle-debug-on-error)

(setq emacsroot "~/.emacs.d")

(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
			 ("melpa" . "http://elpa.zilongshanren.com/melpa/")
			 ("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(package-initialize)
(require 'use-package)
(setq use-package-verbose t
      use-package-always-defer t)


;; setup customize init scripts path 
(add-to-list 'load-path (expand-file-name "lisp" emacsroot))


(require 'init-misc)

(require 'init-org)

(require 'init-helm-gtags)

(require 'init-company)

(require 'init-tex)

(fa-config-default)

(setq conda-anaconda-home "/Users/wxm71/Applications/anaconda3")
(setq conda-env-home-directory "/Users/wxm71/Applications/anaconda3/envs")


;; start up time profile
(add-hook 'emacs-startup-hook (lambda ()
				(message "emacs start in %s with %d garbage collections"
					 (format "%.2fseconds" (float-time (time-subtract after-init-time before-init-time)))
					 gcs-done)))

(setq g-cons-threshold (* 20 1000 1000))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(electric-pair-pairs (quote ((34 . 34) (8216 . 8217) (8220 . 8221))))
 '(org-agenda-files
   (quote
    ("~/projects/sds/competive_analysis/competetor.org" "~/.emacs.d/gtd/paper.org")))
 '(package-selected-packages
   (quote
    (esup org-ref markdown-mode markdown-mode+ markdown-preview-mode markdown-toc google-translate org-plus-contrib tide js2-refactor js2-mode yaml-mode yasnippet-snippets use-package srefactor sr-speedbar session rainbow-mode projectile-codesearch org-make-toc latex-math-preview json-mode highlight-parentheses highlight-doxygen helm-projectile helm-mt helm-gtags helm-flycheck helm-company graphviz-dot-mode geiser function-args flycheck-plantuml exec-path-from-shell evil conda company-tabnine company-shell company-reftex company-math company-jedi company-c-headers cmake-font-lock cdlatex bison-mode auctex)))
 '(safe-local-variable-values
   (quote
    ((checkdoc-minor-mode . t)
     (org-image-actual-width . 200px)
     (org-image-actual-width . 100px)
     (org-confirm-babel-evaluate)
     (bibtex-completion-bibliography . "cs224n.bib")
     (hexo-new-format . org))))
 '(session-use-package t nil (session)))

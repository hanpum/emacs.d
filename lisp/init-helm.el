(use-package helm
  :init
  (helm-mode 1)
  (global-unset-key (kbd "C-x c"))
  :bind (("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files)
	 ("C-c C-j" . helm-semantic-or-imenu) 
	 ("C-c o" . helm-occur)
	 ("C-c h m" . helm-man-woman)
	 ("C-h f" . helm-apropos)
	 ("C-h v" . helm-apropos)
	 ("C-c p f" . project-find-file)
	 :map helm-map
	 ([tab] . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action)
	 ("C-z" . helm-select-action))
  :config
  ;; (use-package helm-config)
  (helm-autoresize-mode 1)
  (setq helm-scroll-amount 8
	Man-width-max 120
	helm-M-x-fuzzy-match t
	helm-ag-use-agignore t
	helm-ag-use-grep-ignore-list t
	helm-ag-insert-at-point 'symbol
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20
	helm-split-window-in-side-p t
	helm-buffers-fuzzy-matching nil
	helm-ff-search-library-in-sexp t
	helm-echo-input-in-header-line t
	helm-move-to-line-cycle-in-source t
	helm-ff-file-name-history-use-recentf t)
  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))
  ;; set MANPATH in shell script with
  ;; export MANPATH=`manpath`
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages))


(use-package projectile
  :commands projectile-global-mode
  :init (projectile-global-mode)
  :bind (:map projectile-mode-map
	      ("C-c p" . 'projectile-command-map))
  :config
  (require 'helm-projectile)
  (setq projectile-globally-ignored-file-suffixes '(".bz2" ".log" ".rpm")
	projectile-completion-system 'helm
	projectile-enable-caching t))


(use-package helm-projectile
  :after projectile helm
  :config
  (setq grep-find-ignored-directories
	(append grep-find-ignored-directories '("tmp"
						".tmp"
						"aliws"
						"aliws_updater"
						"debug_data"
						"bazel-ant1"
						"bazel-testlogs"
						"platform_bot_data"
						"dingding_bot/data"
						"ye_wu_zhi_da/model"))
	grep-find-ignored-files (append grep-find-ignored-files '("*.db" "*.tar" "*.tgz"))
	projectile-switch-project-action 'helm-projectile-find-file)
  (helm-projectile-on))

(use-package helm-ag)

(provide 'init-helm)

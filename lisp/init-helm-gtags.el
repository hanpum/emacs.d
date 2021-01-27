(use-package helm
  :init
  (helm-mode 1)
  (global-unset-key (kbd "C-x c"))
  :bind (("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files)
	 ("C-c C-j" . helm-semantic-or-imenu) 
	 ("C-c C-o" . helm-occur)
	 ("C-c h m" . helm-man-woman)
	 :map helm-map
	 ([tab] . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action)
	 ("C-z" . helm-select-action))
  :config
  ;; (use-package helm-config)
  (helm-autoresize-mode 1)
  (setq helm-scroll-amount 8
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

(use-package helm-ag)

(provide 'init-helm-gtags)

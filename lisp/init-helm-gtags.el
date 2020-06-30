(use-package helm
  :init
  (helm-mode 1)
  (global-unset-key (kbd "C-x c"))
  :bind (("C-C h" . helm-command-prefix)
	 ("M-x" . helm-M-x)
	 ("M-y" . helm-show-kill-ring)
	 ("C-x C-f" . helm-find-files)
	 :map helm-map
	 ([tab] . helm-execute-persistent-action)
	 ("C-i" . helm-execute-persistent-action)
	 ("C-z" . helm-select-action))
  :config
  ;; (use-package helm-config)
  (helm-autoresize-mode 1)
  (setq helm-scroll-amount 8
	helm-M-x-fuzzy-match t
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


(use-package helm-gtags
  :hook ((c-mode c++-mode) . helm-gtags-mode)
  :bind (:map helm-gtags-mode-map
	      ("C-c g a" . helm-gtags-tags-in-this-function)
	      ("C-j" . helm-gtags-select)
	      ("C-c r" . helm-gtags-find-rtag)
	      ("C-c ]" . helm-gtags-find-tag)
	      ("C-w ]" . helm-gtags-find-tag-other-window)
	      ("C-c [" . helm-gtags-pop-stack)
	      ("C-c <" . helm-gtags-previous-history)
	      ("C-c >" . helm-gtags-next-history))
  :config
  (setq helm-gtags-ignore-case t
	helm-gtags-auto-update t
	helm-gtags-use-input-at-cursor t
	helm-gtags-pulse-at-cursor t
	helm-gtags-prefix-key "\C-cg"
	helm-gtags-suggested-key-mapping t))



(provide 'init-helm-gtags)

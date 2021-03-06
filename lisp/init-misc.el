(defun my/run-current-buffer ()
  "save current buffer and run it(for examples, python/shell scripts)"
  (interactive)
  (let* ((outputBuf "run-output"))
    ;; save file if necessary
    (if (or
	 (not (buffer-file-name))
	 (buffer-modified-p))
	(save-buffer))
    ;; change file mode and run it
    (setq fname (buffer-file-name))
    (setq command (concat "chmod +x " fname "; " fname))
    (executable-interpret (read-shell-command "Run: " command))))


;; diable auto create backup file
(setq make-backup-files nil)


;; show line number
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(setq linum-format "%-d ")
(linum-mode 1)
(line-number-mode)
(column-number-mode t)


;; configuration for shell
(setq shell-file-name "/bin/zsh")

;; load shell enviroment variable
(use-package exec-path-from-shell
  :demand t
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (if (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize)))

(auto-fill-mode t)
(setq fill-column 100)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c g") 'revert-buffer)
(global-set-key (kbd "C-c e") 'eval-buffer)
(global-set-key (kbd "C-A-s") 'isearch-forward)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-A-r") 'isearch-backward)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)


(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)


;; disable menu in terminal
(if (equal window-system nil)
    (menu-bar-mode 0))


;; enable copy/paste co-work with X-system
(setq select-enable-clipboard t)

;; render color value
(use-package rainbow-mode
  :ensure t
  :init
  (rainbow-mode t))


(set-face-attribute 'default nil :height 140 :family "Monospace")


;; mode for edit shell script
(use-package sh-script
  :ensure t
  :bind (:map sh-mode-map
	      ([f5] . 'my/run-current-buffer)))


;; enable highlight-parentheses
(use-package highlight-parentheses
  :ensure t
  :init
  (electric-pair-mode t)
  (global-highlight-parentheses-mode t))



;; enable evil model default
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)     ;; enable tab in org mode
  (evil-mode 1)
  :bind (:map evil-motion-state-map
	      (":" . helm-M-x))
  :config
  ;; or add to evil-emacs-state-modes, and remove from evil-motion-state-modes
  (dolist (mode '(Info-mode profiler-report-mode term-mode geiser-repl-mode))
    (evil-set-initial-state mode 'emacs)))

(use-package sr-speedbar
  :bind ("C-c n" . sr-speedbar-toggle)
  :config
  (setq speedbar-show-unknown-files t
	c-basic-offset 4))


;; setup for session
(use-package session
  :ensure t
  :hook (after-init . session-initialize))


(use-package desktop
  :init
  (desktop-save-mode 1)
  (setq desktop-dirname (expand-file-name "data/desktop" emacsroot)))


(use-package cmake-font-lock
  :commands cmake-font-lock-activate
  :hook (cmake-mode . cmake-font-lock-activate))


;; compress file reading
(use-package jka-compr)


(use-package picture
  :hook (picture-mode . (lambda nil
			  (progn
			    (whitespace-mode t)
			    (setq indent-tabs-mode nil)))))


(use-package yasnippet
  :init (yas-global-mode 1))

(use-package yasnippet-snippets)


(use-package hexo
  :init
  (add-hook 'hexo-mode-hook 'evil-local-mode))

(use-package bazel-mode)


(use-package google-translate
  :init 
  (setq google-translate-default-source-language "en"
	google-translate-default-target-language "zh-CN"
	google-translate-output-destination nil
	google-translate-show-phonetic t)
  :bind (("C-c t" . google-translate-at-point)
	 ("C-c T" . google-translate-query-translate))
  :config 
  (use-package google-translate-default-ui))


(use-package srefactor
  :commands srefactor-refactor-at-point
  :bind (:map c-mode-map
	      ("M-RET" . srefactor-refactor-at-point)
	      :map c++-mode-map
	      ("M-RET" . srefactor-refactor-at-point)))

(use-package markdown-mode)

(add-to-list 'auto-mode-alist
	     '("\\.grm\\'" . conf-mode))

(use-package flycheck
  :config
  (setq flycheck-display-errors-delay 0.1))

(use-package hl-line-mode
  :ensure nil
  :init
  (global-hl-line-mode)
  ;;(set-face-background hl-line-face "gray13")
  )

(use-package protobuf-mode
  :mode "\\.pb\\'")


(use-package projectile
  :commands projectile-global-mode
  :init (projectile-global-mode)
  :bind (:map projectile-mode-map
	      ("C-c p" . 'projectile-command-map))
  :config
  (require 'helm-projectile)
  (setq projectile-globally-ignored-file-suffixes '(".bz2" ".log" ".rpm"))
  (setq projectile-completion-system 'helm))


(use-package helm-projectile
  :after projectile helm
  :config
  (setq grep-find-ignored-directories
	(append grep-find-ignored-directories '("bazel-ant1" 
  "bazel-testlogs" "aliws_updater" "platform_bot_data" "dingding_bot/data" "aliws"
  "ye_wu_zhi_da/model" "debug_data"))
	grep-find-ignored-files (append grep-find-ignored-files '("*.db" "*.tar" "*.tgz")))
  (helm-projectile-on))


(use-package man
  :hook (Man-mode . (lambda nil
		      (progn
			(set-face-attribute 'Man-overstrike nil :inherit 'bold :foreground "orange red")
			(set-face-attribute 'Man-underline nil :inherit 'underline :foreground "forest green")))))

(prefer-coding-system 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(setq server-socket-dir (concat emacsroot "/server/"))

(use-package imenu
  :commands imenu
  :config
  (setq imenu-sort-function 'imenu--sort-by-name))

(xterm-mouse-mode)

(provide 'init-misc)

(defun my/run-current-buffer ()
  "save current buffer and run it(for examples, python/shell scripts)"
  (interactive)
  (let*
      ((outputBuf "run-output"))

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
  :config
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


(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)


;; disable menu in terminal
(if (equal window-system nil)
    (menu-bar-mode 0))


;; enable copy/paste co-work with X-system
(setq select-enable-clipboard t)

;; render color value
(rainbow-mode t)


(set-face-attribute 'default nil :height 140 :family "Monospace")


;; mode for edit shell script
(use-package sh-script
  :ensure t
  :bind (:map sh-mode-map
	      ([f5] . 'my/run-current-buffer)))


;; enable highlight-parentheses
(use-package highlight-parentheses
  :ensure t
  :config
  (electric-pair-mode t)
  (global-highlight-parentheses-mode t))


;; enable evil model default
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil)     ;; enable tab in org mode
  (evil-mode 1)
  
  :config
  (evil-set-initial-state 'term-mode 'emacs)
  
  :bind (:map evil-motion-state-map
	      (":" . helm-M-x)))


(use-package sr-speedbar
  :config
  (setq speedbar-show-unknown-files t
	c-basic-offset 4)
  (global-set-key (kbd "C-c n") 'sr-speedbar-toggle))


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
  :ensure t
  :config
  (yas-global-mode 1))

(use-package hexo
  :ensure t)


(use-package google-translate
  :config 
  (use-package google-translate-default-ui)
  (global-set-key "\C-ct" 'google-translate-at-point)
  (global-set-key "\C-cT" 'google-translate-query-translate)
  (setq google-translate-default-source-language "en"
	google-translate-default-target-language "zh-CN"
	google-translate-output-destination nil
	google-translate-show-phonetic t))

(use-package markdown-mode
  :config
  )
(setq server-socket-dir (concat emacsroot "/server/"))


(provide 'init-misc)

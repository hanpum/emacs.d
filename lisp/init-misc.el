;; using space instead of hard tab
;;(global-set-key (kbd "C-c ,") 'pop-global-mark)

(setq-default tab-width 4
              indent-tabs-mode nil
              shell-file-name "/bin/zsh"
              help-window-select t ; always activate help window
              make-backup-files nil ; don't create backup file
              select-enable-clipboard t ; enable copy/paste co-work with X-system
              shell-command-prompt-show-cwd t ; show cwd while running shell command
              server-socket-dir (concat emacsroot "/server/"))


(prefer-coding-system 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)


;; show line number in left and mode line
(global-linum-mode)
(line-number-mode)
(column-number-mode)
(setq-default linum-format "%-d ")

(global-hl-line-mode)


(auto-fill-mode)
(setq-default fill-column 80)


;; key bind
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c g") 'revert-buffer)
(global-set-key (kbd "C-c e") 'eval-buffer)
(global-set-key (kbd "C-A-s") 'isearch-forward)


;; customized mode mapping
(add-to-list 'auto-mode-alist
             '("\\.grm\\'" . conf-mode))


(xterm-mouse-mode)

;; disable menu in terminal
(if (equal window-system nil)
    (menu-bar-mode 0))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

(set-face-attribute 'default nil :height 140 :family "Monospace")


(defun my/run-current-buffer ()
  "Save current buffer and run it(for examples, python/shell scripts)"
  (interactive)
  ;; save file if necessary
  (if (or (not (buffer-file-name))
          (buffer-modified-p))
      (save-buffer))
  ;; change file mode and run it
  (setq fname (buffer-file-name))
  (setq command (concat "chmod +x " fname "; " fname))
  (executable-interpret (read-shell-command "Run: " command)))


;; load shell enviroment variable
(use-package exec-path-from-shell
  :demand t
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (if (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize)))


;; render color value
(use-package rainbow-mode
  :demand t
  :init
  (rainbow-mode t))


;; mode for edit shell script
(use-package sh-script
  :bind (:map sh-mode-map
              ([f5] . 'my/run-current-buffer)))


(use-package highlight-parentheses
  :demand t
  :config
  (electric-pair-mode t)
  (global-highlight-parentheses-mode t))


;; enable evil model default
(use-package evil
  :demand t
  :init 
  (setq evil-want-C-i-jump nil)     ; don't using tab for jump list navigation
  :bind (:map evil-motion-state-map
              (":" . helm-M-x))
  :config
  (evil-mode 1)
  ;;(define-key evil-motion-state-map "TAB" nil)
  ;; disable evil for some mode
  (dolist (mode '(Info-mode profiler-report-mode term-mode geiser-repl-mode rtags-mode helm-occur-mode))
    (evil-set-initial-state mode 'emacs)))


(use-package sr-speedbar
  :bind ("C-c n" . sr-speedbar-toggle)
  :config
  (setq c-basic-offset 4
        speedbar-show-unknown-files t))


;; setup for session
(use-package session
  :hook (after-init . session-initialize))


(use-package desktop
  :demand t
  :config
  (desktop-save-mode 1)
  (setq desktop-dirname (expand-file-name "data/desktop" emacsroot)))


;; compress file reading
(use-package jka-compr)


(use-package picture
  :hook (picture-mode . (lambda nil
                          (progn
                            (whitespace-mode t)
                            (setq indent-tabs-mode nil)))))


;; TODO: only using in programming mode
;; (use-package yasnippet
;;   :config
;;   (yas-global-mode 1)
;;   (use-package yasnippet-snippets))


;; (use-package hexo
;;   :init
;;   (add-hook 'hexo-mode-hook 'evil-local-mode))


(use-package google-translate
  :bind (("C-c t" . google-translate-at-point)
         ("C-c T" . google-translate-query-translate))
  :config 
  (setq google-translate-default-source-language "en"
        google-translate-default-target-language "zh-CN"
        google-translate-output-destination nil
        google-translate-show-phonetic t)
  (use-package google-translate-default-ui))


(use-package srefactor
  :bind (:map c-mode-map
              ("M-RET" . srefactor-refactor-at-point)
              :map c++-mode-map
              ("M-RET" . srefactor-refactor-at-point)))


(use-package markdown-mode)


(use-package flycheck
  :config
  (setq flycheck-display-errors-delay 0.1))


(use-package man
  :hook (Man-mode . (lambda nil
                      (progn
                        (set-face-attribute 'Man-overstrike nil :inherit 'bold :foreground "orange red")
                        (set-face-attribute 'Man-underline nil :inherit 'underline :foreground "forest green")))))


(use-package imenu
  :commands imenu
  :config
  (setq imenu-sort-function 'imenu--sort-by-name))


(use-package gradle-mode)
(use-package flycheck-gradle)


(provide 'init-misc)

;;; init-misc ends

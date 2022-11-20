(defadvice message (before message-with-timestamp activate)
  "message with timestamp"
  (if (not (or (< (length (ad-get-args 0)) 1)
	       (null (ad-get-arg 0))
	       (string-equal (ad-get-arg 0) "%s")))
      (let ((deactivate-mar nil))
	(save-excursion
	  (set-buffer "*Messages*")
	  (read-only-mode -1)
	  (goto-char (point-max))
	  (if (not (bolp))
	      (newline))
	  (insert (format-time-string "[%F %T.%3N] "
				      (current-time)))
	  (read-only-mode 1)))))


;; gc config for boost startup
(setq gc-cons-threshold (* 100 1000 1000))

(toggle-debug-on-error)

(setq emacsroot "~/.emacs.d")

(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(require 'package)
(package-initialize)

;; install use-package if missing
(dolist (pkg '(use-package))
  (unless (package-installed-p pkg)
    (progn
      (message "refresh package content...")
      (package-refresh-contents)
      (message "begin to install %s" pkg)
      (package-install pkg)
      (message "%s install finished" pkg))))

(require 'use-package)
(setq use-package-verbose t
      use-package-always-defer t
      use-package-always-ensure t)
(setq package-check-signature nil)

;; setup customize init scripts path 
(add-to-list 'load-path (expand-file-name "lisp" emacsroot))

(setq custom-file (expand-file-name "custom.el" emacsroot))

(require 'init-misc)
(require 'init-org)

(require 'init-helm)

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

(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)


;; customize face while run in GUI
(when (display-graphic-p)
  (load-theme 'nova t)
  (set-default-font "monaco 16" nil t)
  ;; possible alpha value: (active . inactive) or both
  (set-frame-parameter nil 'alpha '(96 . 90)))

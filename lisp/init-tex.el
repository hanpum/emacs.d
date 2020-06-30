(use-package tex-mode
  :demand t
  :hook (after-init . (lambda nil
			(setenv "PATH"
				(concat "/Library/TeX/texbin" ":" (getenv "PATH")))))
  :hook (LaTeX-mode . (lambda nil
			(progn
			  (setq-default
			   TeX-engine 'xetex
			   TeX-PDF-mode t)
			  (cdlatex-mode t)
			  (reftex-mode t))))
  :config
  (turn-on-reftex)
  (setq latex-run-command 'xelatex))


(provide 'init-tex)

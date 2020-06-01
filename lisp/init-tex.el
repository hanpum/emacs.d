(use-package tex-mode
  :hook (LaTeX-mode . (lambda nil
			(progn
			  (setenv "PATH"
				  (concat "/Library/TeX/texbin" ":"
					  (getenv "PATH")))
			  (setq-default
			   TeX-engine 'xetex
			   TeX-PDF-mode t)
			  (cdlatex-mode t)
			  (reftex-mode t))))
  :config
  (turn-on-reftex)
  (setq latex-run-command 'xelatex))


(provide 'init-tex)

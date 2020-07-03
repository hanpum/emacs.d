(add-hook 'scheme-mode
	  (lambda ()
	    (setq company-backends
		  (delete 'geiser-company-backend company-backends))))

(provide 'init-lisp)

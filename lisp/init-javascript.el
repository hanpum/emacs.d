(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . javascript-mode))
  :init
  (setq-default js2-basic-offset 2)
  (setq-default js2-global-externs '("module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON")))


(provide 'init-javascript)

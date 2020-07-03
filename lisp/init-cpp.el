(use-package company-c-headers
  :commands company-c-headers
  :config
  (add-to-list 'company-c-headers-path-system "/usr/local/include/c++/5.5.0/"))


(defun my:setupCMode nil
  "do configuration for c/c++ mode"
  (progn
    (add-to-list 'company-backends 'company-c-headers)))

(add-hook 'c-mode-hook 'my:setupCMode nil t)
(add-hook 'c++-mode-hook 'my:setupCMode nil t)
(add-hook 'cmake-mode-hook (lambda ()
			     (add-to-list 'company-backends 'company-cmake)))

(provide 'init-cpp)

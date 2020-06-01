(require 'cl-lib)
(require 'company)

(defun company-hanpu (command &optional arg &rest ignored)
  "company complete backend develop learn"

  (message (format "call compnay-hanpu: %s" command))

  (interactive '('interactive))

  (case command
    (interactive
     (company-begin-backend 'company-hanpu))

    (prefix
     (and
      (string-equal (buffer-name) "test.el")
      (company-grab-symbol)))

    (candidates
     (remove-if-not (lambda (c) (string-prefix-p arg c))
		(list "foo" "foolish" "bar" "baaar"))))
  )

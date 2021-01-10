(progn
  ;;美化
  (use-package
	all-the-icons-ivy-rich
	:ensure t
	:init (all-the-icons-ivy-rich-mode 1))
  (use-package
	ivy-rich
	:ensure t
	:init (ivy-rich-mode 1) 
	(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
	:config (setq ivy-rich-display-transformers-list '(ivy-switch-buffer
													   (:columns ((ivy-rich-switch-buffer-icon
																   (:width 2))
																  (ivy-rich-candidate
																   (:width 30))
																  (ivy-rich-switch-buffer-size
																   (:width 7))
																  (ivy-rich-switch-buffer-indicators
																   (:width 4
																		   :face error
																		   :align right))
																  (ivy-rich-switch-buffer-major-mode
																   (:width 12
																		   :face warning))
																  (ivy-rich-switch-buffer-project
																   (:width 15
																		   :face success))
																  (ivy-rich-switch-buffer-path
																   (:width (lambda (x)
																			 (ivy-rich-switch-buffer-shorten-path
																			  x
																			  (ivy-rich-minibuffer-width
																			   0.3))))))
																 :predicate (lambda (cand)
																			  (get-buffer cand)))
													   counsel-find-file
													   (:columns ((ivy-read-file-transformer)
																  (ivy-rich-counsel-find-file-truename
																   (:face font-lock-doc-face))))
													   counsel-M-x
													   (:columns ((counsel-M-x-transformer
																   (:width 40))
																  (ivy-rich-counsel-function-docstring
																   (:face font-lock-doc-face)))) ; return docstring of the command
													   counsel-recentf
													   (:columns ((ivy-rich-candidate
																   (:width 0.8))
																  (ivy-rich-file-last-modified-time
																   (:face font-lock-comment-face)))) ; return last modified time of the file
													   counsel-describe-function
													   (:columns
														((counsel-describe-function-transformer
														  (:width 40))
														 (ivy-rich-counsel-function-docstring
														  (:face font-lock-doc-face)))) ; return docstring of the function
													   counsel-describe-variable
													   (:columns
														((counsel-describe-variable-transformer
														  (:width 40))
														 (ivy-rich-counsel-variable-docstring
														  (:face font-lock-doc-face)))) ; return docstring of the variable
													   )))
  ;; 美化
  (use-package
	ivy-posframe
    :disabled
	:ensure t
	:hook (ivy-mode ivy-posframe-mode)
	:custom (ivy-posframe-parameters '((left-fringe . 8)
									   (right-fringe . 8)))
	(ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))))
;; counsel提供对项目管理的支持
(use-package
  counsel-projectile
  :ensure t
  :hook ((counsel-mode . counsel-projectile-mode))
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point))
  ;;:bind (:map leader-key
  ;;            ("p" . #'projectile-command-map)))

(use-package ivy-fuz
  :ensure t)

(provide 'init-ivy)

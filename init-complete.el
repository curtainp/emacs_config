;; company补全框架
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous)))

;; tabnine 机器学习补全
(use-package company-tabnine
  :ensure t
  :config
	(setq company-backends
				'(
					(company-tabnine company-dabbrev company-keywords company-files company-capf)))
  (defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
    (let ((company-message-func (ad-get-arg 0)))
      (when (and company-message-func
                 (stringp (funcall company-message-func)))
        (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
          ad-do-it))))
	;; add snippets support for all backends
	(defvar company-mode/enable-yas t
		"Enable yasnippet for all backends.")
	(defun company-mode/backend-with-yas (backend)
		(if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
				backend
			(append (if (consp backend) backend (list backend))
							'(:with company-yasnippet))))
	(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  (setq company-idle-delay 0)
  (setq company-show-numbers nil)
	(setq company-dabbrev-downcase nil)
	(setq company-dabbrev-ignore-case t))


(provide 'init-complete)

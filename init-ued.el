;; 增强了搜索功能
(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper-isearch)
   ("C-r" . swiper)
   ("C-c C-r" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-h k" . counsel-descbinds)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ("C-h u" . counsel-unicode-char)
   )
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

;;浮动窗口支持
(use-package posframe
  :ensure t
  :config
  (setq posframe-mouse-banish nil))

;; 集成了很多非常有用的的功能
(use-package counsel
  :ensure t
  :bind
  (("C-x C-r" . 'counsel-recentf)
   ("C-x d" . 'counsel-dired))
  :config
  ;; 默认的 rg 配置
  ;; (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s")
  (setq counsel-rg-base-command (list "rg"
									  "-M" "240"
									  "--with-filename" "--no-heading" "--line-number" "--color"
									  "never" "%s"
									  "-g" "!package-config.org"
									  "-g" "!site-lisp"
									  "-g" "!doc"
									  "-g" "!themes"
                                      "-g" "!etc-cache"))
  (setq counsel-fzf-cmd "fd -I --exclude={site-lisp,etc/snippets,themes,/eln-cache,/var,/elpa,/url,/auto-save-list,.cache,doc/} --type f | fzf -f \"%s\" --algo=v1")
  ;; Integration with `projectile'
  (with-eval-after-load 'projectile
    (setq projectile-completion-system 'ivy)))


(use-package snails
  :disabled
  :defer 0
  :load-path "~/.emacs.d/curtain-emacs-conf/extension/snails"
  :config
  (setq snails-default-backends '(snails-backend-current-buffer
								  snails-backend-command
								  snails-backend-bookmark
								  snails-backend-buffer
								  snails-backend-rg
								  snails-backend-fd
								  snails-backend-eaf-browser-history
								  snails-backend-eaf-github-search
								  snails-backend-google-suggestion)
		snails-prefix-backends '(("*" '(snails-backend-current-buffer))
								 (">" '(snails-backend-command))
								 ("@" '(snails-backend-bookmark))
								 ("#" '(snails-backend-buffer))
								 ("$" '(snails-backend-rg))
								 ("-" '(snails-backend-fd))
								 ("=" '(snails-backend-eaf-browser-history))
								 ("." '(snails-backend-eaf-github-search))
								 ("," '(snails-backend-google-suggestion)))
		snails-default-show-prefix-tips t
		snails-backend-eaf-browser-history-limit 10))

(provide 'init-ued)


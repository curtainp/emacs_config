;; 进行一些基础配置
;; refer manateelazycat emacs config

;; 字体设置
(let ((emacs-font-size 14)
      emacs-font-name)
  (cond
   ((featurep 'cocoa)
    (setq emacs-font-name "Monaco"))
   ((string-equal system-type "gnu/linux")
    (setq emacs-font-name "WenQuanYi Micro Hei Mono")))
  (when (display-grayscale-p)
    (set-frame-font (format "%s-%s" (eval emacs-font-name) (eval emacs-font-size)))
    (set-fontset-font (frame-parameter nil 'font) 'unicode (eval emacs-font-name))

    (setq nox-doc-tooltip-font (format "%s-%s" emacs-font-name emacs-font-size))
    ))


;;主题设置
(unless (package-installed-p 'moe-theme)
  (package-install 'moe-theme))
(require 'moe-theme)
(load-theme 'moe-dark t)

;;MISC设置
(setq
 ;; 当窗口变化时不要缩放frame
 frame-inhibit-implied-resize t
 initial-major-mode 'fundamental-mode
 ;; 不用自动启用package
 package-enable-at-startup nil
 package--init-file-ensured t)

(tool-bar-mode -1)      ;; 禁用工具栏
(menu-bar-mode -1)      ;; 禁用菜单栏
(scroll-bar-mode -1)    ;; 禁用滚动条
(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-message t)

;;no auto-save
(setq make-backup-files nil)
(setq auto-save-default nil)
;; 自动保存配置
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)
(setq auto-save-delete-trailing-whitespace t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-compacting-font-caches t) ;使用字体缓存，避免卡顿
(setq ring-bell-function 'ignore blink-cursor-mode nil)

;; 默认使用utf-8编码
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

;;让'_'视作单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
					  (modify-syntax-entry ?_ "w")))
;;让'-'视作单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
					  (modify-syntax-entry ?- "w")))

;;允许插入制表符"tab"
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;macos 下exec-path修复
(when (featurep 'cocoa)
  (use-package exec-path-from-shell
    :ensure t
    :config
    (setq exec-path-from-shell-check-startup-files nil)
    (defvar cache-path-from-shell-loaded-p nil)
    (defadvice exec-path-from-shell-initialize (around cache-path-from-shell-advice activate)
      (if cache-path-from-shell-loaded-p
          (message "all shell environment variables has loaded")
        (setq cache-path-from-shell-loaded-p t)
        ad-do-it))
    ))
;; 高亮对应的括号
(show-paren-mode 1)
;;awesome-pair
(use-package awesome-pair
  :load-path "~/.emacs.d/curtain-emacs-conf/extension/awesome-pair"
  :ensure t
  :config
  (dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'maxima-mode-hook
               'ielm-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'php-mode-hook
               'python-mode-hook
               'js-mode-hook
               'go-mode-hook
               'qml-mode-hook
               'jade-mode-hook
               'css-mode-hook
               'ruby-mode-hook
               'coffee-mode-hook
               'rust-mode-hook
               'qmake-mode-hook
               'lua-mode-hook
               'swift-mode-hook
               'web-mode-hook
               'markdown-mode-hook
               'llvm-mode-hook
               'conf-toml-mode-hook
               ))
  (add-hook hook '(lambda () (awesome-pair-mode 1))))
  :bind (:map awesome-pair-mode-map
              ("(" . #'awesome-pair-open-round)
              ("(" . #'awesome-pair-open-round)
              ("[" . #'awesome-pair-open-bracket)
              ("{" . #'awesome-pair-open-curly)
              (")" . #'awesome-pair-close-round)
              ("]" . #'awesome-pair-close-bracket)
              ("}" . #'awesome-pair-close-curly)
              ("=" . #'awesome-pair-equal)
              ("%" . #'awesome-pair-match-paren)
              ("\"" . #'awesome-pair-double-quote)
              ))

;; 不显示 *scratch*
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)


;; 增强了搜索功能
(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-c C-r" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file))
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

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



(provide 'init-basic)

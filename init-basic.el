;; 进行一些基础配置
;; refer manateelazycat emacs config

;; 字体设置
(let ((emacs-font-size 15)
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


;;允许插入制表符"tab"
(setq-default indent-tabs-mode t)
(setq-default tab-width 2)
(tool-bar-mode -1)      ;; 禁用工具栏
(menu-bar-mode -1)      ;; 禁用菜单栏
(scroll-bar-mode -1)    ;; 禁用滚动条
(setq display-line-numbers-type 'relative)
(setq global-linum-mode t)
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

;; 默认使用utf-8编码
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

;; 增加长行处理性能
(setq bidi-inhibit-bpa t)
(setq-default bidi-paragraph-direction 'left-to-right)
;; 增加IO性能
(setq process-adaptive-read-buffering nil)
(setq read-process-output-max (* 1024 1024))
(blink-cursor-mode -1)                  ;指针不闪动
(transient-mark-mode 1)                 ;标记高亮
(setq-default comment-style 'indent)    ;设定自动缩进的注释风格
(setq ring-bell-function 'ignore)       ;关闭烦人的出错时的提示声
(setq mouse-yank-at-point t)            ;粘贴于光标处,而不是鼠标指针处
(setq x-select-enable-clipboard t)      ;支持emacs和外部程序的粘贴
(setq split-width-threshold nil)        ;分屏的时候使用上下分屏
(setq inhibit-compacting-font-caches t) ;使用字体缓存，避免卡顿
(setq confirm-kill-processes nil)       ;退出自动杀掉进程
(setq async-bytecomp-allowed-packages nil) ;避免magit报错

(setq ad-redefinition-action 'accept)   ;不要烦人的 redefine warning
(setq frame-resize-pixelwise t) ;设置缩放的模式,避免Mac平台最大化窗口以后右边和下边有空隙

;; 平滑地进行半屏滚动，避免滚动后recenter操作
(setq scroll-step 1
      scroll-conservatively 10000)

;;macos 下exec-path修复
(when (featurep 'cocoa)
  (use-package exec-path-from-shell
    :ensure t
    :config
		(exec-path-from-shell-initialize)
    ;; (setq exec-path-from-shell-check-startup-files nil)
    ;; (defvar cache-path-from-shell-loaded-p nil)
    ;; (defadvice exec-path-from-shell-initialize (around cache-path-from-shell-advice activate)
    ;;   (if cache-path-from-shell-loaded-p
    ;;       (message "all shell environment variables has loaded")
    ;;     (setq cache-path-from-shell-loaded-p t)
    ;;     ad-do-it))
    ))

;;(if (featurep 'cocoa)
;;    (progn
;;      (setq ns-use-native-fullscreen nil)
;;      (setq ns-use-fullscreen-animation nil)
;;      (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;;      (run-at-time "2sec" nil
;;                   (lambda ()
;;                     (toggle-frame-fullscreen)
;;                     ))))
(toggle-frame-fullscreen)
;; 高亮对应的括号
(show-paren-mode 1)
;;awesome-pair
(use-package awesome-pair
  :load-path "~/.emacs.d/curtain-emacs-conf/extension/awesome-pair"
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

;;让'_'视作单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
					  (modify-syntax-entry ?_ "w")))
;;让'-'视作单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
					  (modify-syntax-entry ?- "w")))

(provide 'init-basic)

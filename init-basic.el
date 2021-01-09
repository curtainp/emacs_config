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

;; melpa国内源设置
(require 'package)
(setq package-archives
             '(("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
	       ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
(package-initialize)
(package-refresh-contents)

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
(setq make-backup-files nil) ;;no auto-save
(setq auto-save-default nil)
;; 自动保存配置
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)
(setq auto-save-delete-trailing-whitespace t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-compacting-font-caches t) ;使用字体缓存，避免卡顿
;; 不显示 *scratch*
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)




(provide 'init-basic)

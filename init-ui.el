;; UI 设置
(use-package all-the-icons
	:ensure t)

(use-package dashboard
	:ensure t
	:init
	(setq dashboard-banner-logo-title "Curtain Emacs - Enjoy Programming & Writing"
				dashboard-center-content t
				dashboard-startup-banner "~/.config/emacs/logo.png"
				dashboard-footer (format "Powered by Curtain, %s" (format-time-string "%Y")))
	:config
	(dashboard-setup-startup-hook)
	(setq dashboard-set-heading-icons t)
	(setq dashboard-set-file-icons t))


;;;###autoload
(defun ada/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 '(90 . 90) '(100 . 100)))))

;; 增加减少透明
;;;###autoload
(defun ada/adjust-opacity (frame incr)
  "调整frame的背景透明度"
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame, which not GUI env"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
	 (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
	 (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))

(defun ada/less-alpha ()
  (interactive)
  (ada/adjust-opacity nil 2))

(defun ada/plus-alpha ()
  (interactive)
  (ada/adjust-opacity nil -2))


;;awesome-tray
(use-package awesome-tray
  ;;:disabled
  :load-path (lambda () (concat user-emacs-directory "lisp/extension/awesome-tray"))
  :hook (after-init . awesome-tray-mode)
  :config
  (setq awesome-tray-active-modules '("location" "parent-dir" "buffer-name" "awesome-tab" "evil" "git")))

;; valign表格对齐
(use-package valign
  ;;:disabled
  :load-path (lambda () (concat user-emacs-directory "lisp/extension/valign"))
  :hook ((org-mode markdown-mode) . valign-mode)
  :config
  (setq valign-fancy-bar nil))

(use-package awesome-tab
  ;;:disabled
  :load-path "~/.config/emacs/lisp/extension/awesome-tab"
  :hook (after-init . awesome-tab-mode)
  :bind
  (("C-c h" . awesome-tab-backward-tab)
   ("C-c l" . awesome-tab-forward-tab)
   ("C-c H" . awesome-tab-backward-tab-other-window)
   ("C-c L" . awesome-tab-forward-tab-other-window)
   ("C-c b" . awesome-tab-switch-group)
   ("C-c g" . awesome-tab-ace-jump))
  :config
  (defun awesome-tab-hide-tab (x)
    (let ((name (format "%s" x)))
      (or
       (string-prefix-p "*epc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*Warnings*" name)
       (string-prefix-p "*Messages*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "flycheck" name)
       (string-prefix-p "*LSP" name)
       (string-prefix-p "*Youdao" name)
       (string-prefix-p "*company-box" name)
       (string-prefix-p "*Go-Tran" name)
       (string-prefix-p "*hydra-posframe" name)
       (string-prefix-p "*which-key*" name)
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       ))))

;; line number
(setq line-number-display-limit large-file-warning-threshold)
(setq line-number-display-limit-width 1000)

(dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               'java-mode-hook
               'asm-mode-hook
               'haskell-mode-hook
               'rcirc-mode-hook
               'erc-mode-hook
               'sh-mode-hook
               'makefile-gmake-mode-hook
               'python-mode-hook
               'js-mode-hook
               'html-mode-hook
               'css-mode-hook
               'apt-utils-mode-hook
               'tuareg-mode-hook
               'go-mode-hook
               'coffee-mode-hook
               'qml-mode-hook
               'markdown-mode-hook
               'slime-repl-mode-hook
               'package-menu-mode-hook
               'cmake-mode-hook
               'php-mode-hook
               'web-mode-hook
               'coffee-mode-hook
               'sws-mode-hook
               'jade-mode-hook
               'vala-mode-hook
               'rust-mode-hook
               'ruby-mode-hook
               'qmake-mode-hook
               'lua-mode-hook
               'swift-mode-hook
               'llvm-mode-hook
               'conf-toml-mode-hook
               'nxml-mode-hook
               'nim-mode-hook
               ))
  (add-hook hook (lambda () (display-line-numbers-mode))))

(provide 'init-ui)

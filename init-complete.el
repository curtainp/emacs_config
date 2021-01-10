;; company补全框架
(use-package company
  :hook (prog-mode . company-mode)
  :init (setq company-tooltip-align-annotations t company-idle-delay 0.1 company-echo-delay 0
              company-minimum-prefix-length 2 company-require-match nil company-dabbrev-ignore-case
              nil company-dabbrev-downcase nil company-show-numbers t)
  :config
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous))

;; tabnine 机器学习补全
(use-package company-tabnine
  :disabled
  :ensure t
  :after 'company-mode
  'company-tabnine-mode
  :config (add-to-list 'company-backends #'company-tabnine))

;; 美化company
(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; 代码片段
(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/curtain-emacs-conf/snippets")))


(provide 'init-complete)

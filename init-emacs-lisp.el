(use-package lispy
 :ensure t
 :hook (emacs-lisp-mode . lispy-mode))

;; lisp符号操作工具
(use-package symbol-overlay
  :ensure t
  :hook (emacs-lisp-mode . symbol-overlay-mode))

;; 增强*help* buffer的功能
(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)))

;; 为*help*中的函数提供elisp例子
(use-package elisp-demos
  :ensure t
  :config
  (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))
(provide 'init-emacs-lisp)

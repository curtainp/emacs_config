;; Emacs对语言服务器支持的插件
(use-package lsp-mode
  :ensure t
  ;;:commands (lsp)
  :hook ((c-mode c++-mode python-mode go-mode sh-mode) . lsp)
  :custom
  (lsp-idle-delay 200)
  (lsp-auto-guess-root nil)
  (lsp-file-watch-threshold 2000)
  (read-process-output-max (* 1024 10240))
  (lsp-eldoc-hook nil)
  (lsp-prefer-flymake nil)
  :bind (:map lsp-mode-map
			  ("C-c C-f" . lsp-format-buffer)
			  ("M-RET" . lsp-ui-sideline-apply-code-actions))
  :config
  (setq lsp-prefer-capf t))

;; 微软的python语言服务器-新版
(use-package lsp-pyright
  :ensure t
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))
  :init
  (when (executable-find "python3")
    (setq lsp-pyright-python-executable-cmd "python3")))  ; or lsp-deferred

;; 美化lsp-mode
(use-package
  lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  ;; sideline
  (setq lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-update-mode 'line
        ;; sideline
        lsp-ui-sideline-delay 1)
  ;; peek
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  ;; doc
  (setq lsp-ui-doc-enable t
        ;; 文档显示的位置
        lsp-ui-doc-position 'top
        ;; 显示文档的延迟
        lsp-ui-doc-delay 2))

(provide 'init-lsp)

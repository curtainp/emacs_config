;; misc配置

(use-package vterm
  :commands (vterm)
  :ensure t
	:config (setq vterm-shell "zsh"))


(use-package pdf-tools
	:disabled
	:ensure t
	:hook ('doc-view-mode 'pdf-view-mode)
	:bind (:map pdf-view-mode-map
							("j" . #'pdf-view-next-line-or-next-page)
							("k" . #'pdf-view-previous-line-or-previous-page)
							("l" . #'image-forward-hscroll)
							("h" . #'image-backward-hscroll)))
;; 撤销树
(use-package undo-tree
	:disabled
  :ensure t
  :hook (after-init . global-undo-tree-mode)
  :init (setq undo-tree-visualizer-timestamps t undo-tree-enable-undo-in-region nil undo-tree-auto-save-history nil)

  ;; HACK: keep the diff window
  (with-no-warnings (make-variable-buffer-local 'undo-tree-visualizer-diff)
                    (setq-default undo-tree-visualizer-diff t))
;; 项目管理
(use-package
  projectile
  :ensure t)

;; ASCII艺术字
(use-package figlet
  :ensure t
  :config
  (setq figlet-default-font "standard"))

;; 写作模式，让你专注与写作状态
(use-package writeroom-mode
	:disabled
  :ensure t
  :hook (writeroom-mode . (lambda () (progn
																			 (nlinum-mode -1)
																			 (git-gutter-mode -1)
																			 (toggle-truncate-lines -1)))))

(provide 'init-misc)

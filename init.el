(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))
(add-subdirs-to-load-path "~/.emacs.d/curtain-emacs-conf")

(let (
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))

  (with-temp-message ""
    (require 'init-package)
    (require 'init-evil)
    ;; 加载基础配置(melpa源,字体,窗口,主题)
    (require 'init-basic)
    (require 'init-ui)
    (require 'init-ued)
    ;;(require 'init-keybind)
    ;;(require 'init-misc)
    (require 'init-complete)
    (require 'init-prog)
    (require 'init-org)
    ;;(require 'init-ivy)
    ;;(require 'init-treemacs)
    (require 'init-lsp)
    (require 'init-python)
    (require 'init-cc)
    (require 'init-emacs-lisp)
    ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 '(org-download yasnippet-snippets writeroom-mode vterm use-package undo-tree treemacs-projectile treemacs-persp treemacs-magit symbol-overlay quickrun python-black pdf-tools org-bullets moe-theme modern-cpp-font-lock major-mode-hydra lsp-ui lsp-treemacs lsp-pyright live-py-mode lispy ivy-posframe ivy-fuz highlight-indent-guides helpful figlet evil elisp-demos dashboard counsel-projectile company-tabnine company-box ccls all-the-icons-ivy-rich)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

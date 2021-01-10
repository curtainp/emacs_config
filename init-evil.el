;; evil相关设置

;;(add-to-list 'load-path "~/.emacs.d/elpa/evil/")
;;(require 'evil)
;;(evil-mode 1)
(use-package evil
  :load-path "~/.emacs.d/elpa/evil"
  :ensure t
  :hook (after-init . evil-mode))

(provide 'init-evil)

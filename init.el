(defun add-subdirs-to-load-path (dir)
  "Recursive add directories to `load-path'."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))
(add-subdirs-to-load-path "/home/curtain/.emacs.d/curtain-emacs-conf")

;; 加载基础配置(melpa源,字体,窗口,主题)
(require 'init-basic)
(let (
      (gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))

  (with-temp-message ""
    (require 'init-evil)
    (require 'init-awesome-tray)
    (require 'init-awesome-tab)
    (require 'init-awesome-pair)
    ))

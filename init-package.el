;; melpa国内源设置
(require 'package)

(package-initialize)

;;(setq package-archives
;;             '(("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
;;	         ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
;;(setq package-archives
;;             '(("melpa" . "http://elpa.emacs-china.org/melpa/")
;;	         ("gnu" . "http://elpa.emacs-china.org/gnu/")))

(setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
			 ("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/melpa-stable/")
			 ("org" . "http://mirrors.ustc.edu.cn/elpa/org/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(provide 'init-package)

;; 大量可用的代码片段
(use-package
  yasnippet-snippets
  :ensure t
  :after yasnippet)

;; 编译运行当前文件
(use-package
  quickrun
  :ensure t
  :commands(quickrun)
  ;;:bind (:map leader-key
  ;;            ("c r" . #'quickrun))
  :init (setq quickrun-timeout-seconds nil)
  (setq quickrun-focus-p nil)
  (setq quickrun-input-file-extension nil)
  :config
  (quickrun-add-command "python3"
    '((:command .
                "python3")
      (:exec .
             "%c %s")
      (:tempfile .
                 nil))
    :default "python")
  (quickrun-add-command "c++/c2a"
	'((:command . "g++")
      (:exec    . ("%c -std=c++2a %o -o %e %s"
				   "%e %a"))
      (:remove  . ("%e")))
	:default "c++"))

(provide 'init-prog)

;; 大量可用的代码片段
(use-package
  yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package citre
	:defer t
	:init
	(require 'citre-config)
	(global-set-key (kbd "C-x 7") 'citre-jump)
  (global-set-key (kbd "C-x 8") 'citre-jump-back)
  (global-set-key (kbd "C-x 9") 'citre-ace-peek)
  (global-set-key (kbd "C-x 0") 'citre-update-this-tags-file)
	:config
	(setq
	 citre-default-create-tags-file-location 'global-cache
	 citre-use-project-root-when-creating-tags t
	 citre-prompt-language-for-ctags-command t)
	(defun citre-jump+ ()
		(interactive)
		(condition-case _
				(citre-jump)
				(error (call-interactively #'xref-find-definitions))))
	)


(provide 'init-prog)

;; Python
(use-package 
  python 
  :ensure t 
  :hook (inferior-python-mode . (lambda () 
                                  (process-query-on-exit-flag (get-process "Python")))) 
  :init
  ;; Disable readline based native completion
  (setq python-shell-completion-native-enable nil) 
  :config
  ;; Default to Python 3. Prefer the versioned Python binaries since some
  ;; systems stupidly make the unversioned one point at Python 2.
  (when (and (executable-find "python3") 
             (string= python-shell-interpreter "python")) 
    (setq python-shell-interpreter "/usr/bin/python3"))
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell (exec-path-from-shell-copy-env "PYTHONPATH"))
  ;; Live Coding in Python
  (use-package live-py-mode
    :ensure t
    :after python
    )
  (use-package python-black
	:ensure t
    :after python
	:hook (python-mode . python-black-on-save-mode)))

(use-package elpy
  :disabled
  :ensure t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (push "~/.local/bin/" exec-path))

(provide 'init-python)

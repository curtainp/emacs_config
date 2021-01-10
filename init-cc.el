(use-package ccls
  :ensure t
  :defer t
  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp)))
  :custom
  (ccls-executable (executable-find "ccls"))
  (ccls-sem-highlight-method 'font-lock)
  (ccls-enable-skipped-ranges nil)
  ;; :config
  ;; (lsp-register-client
  ;;  (make-lsp--client
  ;; 	:new-connection (lsp-tramp-connection (cons ccls-executable ccls-args))
  ;; 	:major-modes '(c-mode c++-mode)
  ;; 	:server-id 'ccls-remote
  ;; 	:multi-root nil
  ;; 	:remote? t
  ;; 	;; :notification-handlers
  ;; 	;; (lsp-ht ("$ccls/publishSkippedRanges" #'ccls--publish-skipped-ranges)
  ;; 	;; 		("$ccls/publishSemanticHighlight" #'ccls--publish-semantic-highlight))
  ;; 	:initialization-options (lambda () ccls-initialization-options)
  ;; 	:library-folders-fn nil))
  )

(use-package modern-cpp-font-lock
  :ensure t
  :diminish t
  :init (modern-c++-font-lock-global-mode t))

(provide 'init-cc)

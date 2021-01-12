(use-package go-mode
  :functions (go-packages-gopkgs go-update-tools)
  :bind (:map go-mode-map
         ("C-g R" . go-remove-unused-imports)
         ("C-g d" . godoc-at-point))
  :config
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-envs '("GOPATH" "GO111MODULE" "GOPROXY")))

	;; Install or update tools
  (defvar go--tools '("golang.org/x/tools/cmd/goimports"
                      "github.com/go-delve/delve/cmd/dlv"
                      "github.com/josharian/impl"
                      "github.com/cweill/gotests/..."
                      "github.com/fatih/gomodifytags"
                      "github.com/davidrjenni/reftools/cmd/fillstruct")
    "All necessary go tools.")

  ;; Do not use the -u flag for gopls, as it will update the dependencies to incompatible versions
  ;; https://github.com/golang/tools/blob/master/gopls/doc/user.md#installation
  (defvar go--tools-no-update '("golang.org/x/tools/gopls@latest")
    "All necessary go tools without update the dependencies.")

	(defun go-update-tools ()
		"Install or update go tools."
		(interactive)
		(unless (executable-find "go")
			(user-error "Unable to find `go' in `exec-path'!"))

		(message "Installing go tools...")
		(let ((proc-name "go-tools")
					(proc-buffer "*Go Tools*"))
			(dolist (pkg go--tools-no-update)
				(set-process-sentinel
				 (start-process proc-name proc-buffer "go" "get" "-v" pkg)
				 (lambda (proc _)
					 (let ((status (process-exit-status proc)))
						 (if (= 0 status)
								 (message "Installed %s" pkg)
							 (message "Failed to install %s: %d" pkg status))))))

			(dolist (pkg go--tools)
				(set-process-sentinel
				 (start-process proc-name proc-buffer "go" "get" "-u" "-v" pkg)
				 (lambda (proc _)
					 (let ((status (process-exit-status proc)))
						 (if (= 0 status)
								 (message "Installed %s" pkg)
							 (message "Failed to install %s: %d" pkg status))))))))

  ;; Try to install go tools if `gopls' is not found
  (unless (executable-find "gopls")
    (go-update-tools)))

(use-package go-dlv
	:ensure t)

(use-package go-fill-struct
	:ensure t)

(use-package go-impl
	:ensure t)

;; Install: See https://github.com/golangci/golangci-lint#install
(use-package flycheck-golangci-lint
:if (executable-find "golangci-lint")
:after flycheck
:defines flycheck-disabled-checkers
:hook (go-mode . (lambda ()
										"Enable golangci-lint."
										(setq flycheck-disabled-checkers '(go-gofmt
																												go-golint
																												go-vet
																												go-build
																												go-test
																												go-errcheck))
										(flycheck-golangci-lint-setup))))

(provide 'init-go)


(use-package org
  :ensure t
  :init
  (require 'org-capture)
  :bind
  ("C-c c" . 'org-capture)
  ("C-c a" . 'org-agenda)
  ("M-H" . 'org-shiftmetaleft)
  ("M-L" . 'org-shiftmetaright)
  :custom
  (org-todo-keywords '((sequence "[STUDY](s)" "[TODO](t)" "[WAIT](w!))" "|" "[DONE](d!/@)" "[CACELED](c!@)")
                       (sequence "[BUG](b!)" "[NEW](n/@)" "[KNOWN](k!/@)" "[FIXING](W!/@)" "|" "[FIXED](f!)")))
  :config
  (setq org-todo-keyword-faces '(("[STUDY]" . (:foreground "white" :background "#2ECC71" :weight bold))
                                 ("[TODO]" . (:foreground "white" :background "#F1C40F" :weight bold))
                                 ("[WAIT]" . (:foreground "white" :background "#5498DB" :weight bold))
                                 ("[DONE]" . (:foreground "black" :background "snow " :weight bold))
                                 ("[CACEL]" . (:foreground "white" :background "#566573" :weight bold))
                                 ("[BUG]" . (:foreground "white" :background "#E74C3C" :weight bold))
                                 ("[NEW]" . (:foreground "white" :background "#D35400" :weight bold))
                                 ("[KNOWN]" . (:foreground "white" :background "#17A589" :weight bold))
                                 ("[FIXING]" . (:foreground "white" :background "#BB8FCE" :weight bold))
                                 ("[FIXED]" . (:foreground "white" :background "#566573" :weight bold))))

  (setq org-log-mode 'note) ; Set the log mode type
  (setq org-src-fontify-natively t)
  (setq org-startup-folded nil) ; Don't fold contents by normal
  (setq org-M-RET-may-split-line '((headline . nil))) ; Don't split text
  (setq org-hide-leading-stars t) ; Hide the leading stars
  (setq org-odd-levels-only t) ; Only odd the levels
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t) ; Highlight code in babel and not ask

  ;; GTD
  (unless (file-exists-p "~/.emacs.d/gtd")
    (make-directory "~/.emacs.d/gtd"))
  (setq org-agenda-files '("~/.emacs.d/gtd"))
  (defvar org-agenda-dir "" "gtd org files location")
  (setq-default org-agenda-dir "~/.emacs.d/gtd")
  ;; org-agenda-dir files
  (setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
  (setq org-agenda-file-insp (expand-file-name "inspirations.org" org-agenda-dir))
  (setq org-agenda-file-task (expand-file-name "tasks.org" org-agenda-dir))
  (setq org-capture-templates
   '(("t" "Task")
     ("tw" "Work Task" entry (file+headline org-agenda-file-task "Work")
      "* [TODO] %^{Work Mainly Content} %t\n  %^g\n  %?" :clock-in t :clock-keep t)
     ("ts" "Work Study" entry (file+headline org-agenda-file-task "Study")
      "* [STUDY] %^{Study for work} %t\n  %^g\n  %?" :clock-in t :clock-keep t)
     ("i" "inspiration" entry (file+headline org-agenda-file-insp "Inspiration")
      "* %^{What idea?} %U\n %^g\n  %?\n")
     ("n" "Note" entry (file+headline org-agenda-file-note "Note")
      "* %^{Note} %U\n %^g\n %?\n")))

  ;; 设置org-babel支持运行的代码
  (org-babel-do-load-languages
   'org-babel-load-languages
   '( (python . t)
      (shell . t)
      (emacs-lisp . t)
      (C . t)
      (C++ . t))))

;; 美化org
(use-package
  org-bullets
  :ensure t
  :after org
  :hook ('org-mode . 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "✿" "☭")))

(use-package gkroam
  :disabled
  :ensure t
  :hook (after-init-hook . gkroam-mode)
  :init
  (setq gkroam-root-dir "~/Documents/org/"
		gkroam-window-margin 4
		org-startup-folded nil)
  :bind
  (("C-c r I" . gkroam-index)
   ("C-c r d" . gkroam-daily)
   ("C-c r f" . gkroam-find)
   ("C-c r i" . gkroam-insert)
   ("C-c r c" . gkroam-capture)
   ("C-c r e" . gkroam-link-edit)
   ("C-c r n" . gkroam-smart-new)
   ("C-c r b" . gkroam-toggle-beautify)
   ("C-c r t" . gkroam-toggle-brackets)
   ("C-c r g" . gkroam-update)
   ("C-c r G" . gkroam-update-all))
  :config
  ;; when this minor mode is on, show and hide brackets dynamically.
  (gkroam-dynamic-brackets-mode -1))

(provide 'init-org)

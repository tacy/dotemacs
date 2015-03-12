;;; s-WinKey // M-AltKey // C-CtrlKey //S-ShitfKey

(load-theme 'manoj-dark t)


;;; key binding
(global-set-key (kbd "C-<f2>") (lambda() (interactive) (kill-ring-save-file-name 5)))


;;;python setting
;;ipython setting
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "-i"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; virtualenv setting
(setq python-shell-virtualenv-root "/home/tacy/workspace/python/myenv")
;;(setq python-shell-extra-pythonpaths '("/home/tacy/workspace/python/swift"))
(setq jedi:server-args
      '("--virtual-env" "~/workspace/python/myenv"))
(add-hook 'python-mode-hook 'electric-indent-mode)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)


;;;org mode setting
;;(add-to-list 'load-path "~/.emacs.d/customizations/htmlize")
;;(require 'htmlize)
(setq org-publish-project-alist '(
  ("org-myblog"
          ;; Path to your org files.
          :base-directory "~/myblog/org/"
          :base-extension "org"

          ;; Path to your Jekyll project.
          :publishing-directory "~/myblog/jekyll/"
          :recursive t
          :publishing-function org-html-publish-to-html
          :headline-levels 4
          :html-extension "html"
          :with-toc nil
          :body-only t
    )

    ("org-static-myblog"
          :base-directory "~/myblog/org/"
          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
          :publishing-directory "~/myblog/jekyll/"
          :recursive t
          :publishing-function org-publish-attachment)

    ("myblog" :components ("org-myblog" "org-static-myblog"))
))

(require 'org)
(defun org-custom-link-img-follow (path)
  (org-open-file-with-emacs
   (format "../images/%s" path)))

(defun org-custom-link-img-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<img src=\"/images/%s\" alt=\"%s\"/>" path desc))))

(org-add-link-type "img" 'org-custom-link-img-follow 'org-custom-link-img-export)

;; turn on soft wrapping mode for org mode
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
(setq org-src-fontify-natively t)
(setq org-export-with-sub-superscripts nil)
;;(add-hook 'message-mode-hook 'turn-on-orgstruct)
;;(add-hook 'message-mode-hook 'turn-on-orgstruct++)


;; golang
(setq gopackage '(go-mode))
(dolist (package gopackage)
  (unless (package-installed-p package)
    (package-install package)))
(add-hook 'go-mode-hook 'flycheck-mode)

(let ((gobin (expand-file-name "~/mytools/go/bin")))
  (setenv "PATH" (concat gobin  ":" (getenv "PATH")))
  (add-to-list 'exec-path gobin))

(let ((gopathbin (expand-file-name "~/workspace/go/bin")))
  (setenv "PATH" (concat gopathbin  ":" (getenv "PATH")))
  (add-to-list 'exec-path gopathbin))

(setenv "GOPATH" "/home/tacy/workspace/go")
(setenv "GOROOT" "/home/tacy/mytools/go")

; Go Oracle
(load-file "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")

; Go autocomplete - gocode
(load-file "$GOPATH/src/github.com/nsf/gocode/emacs/go-autocomplete.el")

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'go-oracle-mode)

(provide 'post-startup)
;;; post-startup.el ends here

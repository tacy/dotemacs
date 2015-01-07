;;; s-WinKey // M-AltKey // C-CtrlKey //S-ShitfKey

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

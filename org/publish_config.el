(require 'package)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p '(webfeeder htmlize))
  (when (not (package-installed-p p))
    (package-install p)))

(eval-when-compile
  (require 'org)
  (require 'ox-publish)
  (require 'ox-html)
  (require 'htmlize)
  (require 'webfeeder))

(setq org-html-validation-link nil
      ;; https://emacs-china.org/t/org-emacs-script-org-publish-all/20782
      org-html-htmlize-output-type 'css
      org-export-with-toc 1
      org-export-with-sub-superscripts '{})

(setq org-html-postamble-format
      '(("en"
         "
<p>dongdigua(dongdigua.github.io) CC BY-NC-SA, 禁止转载到私域(公众号，非自己托管的博客等)</p>
<p class=\"date\">Date: %d Build: %T</p>
<p>Proudly made with Emacs Org mode</p>
<p>If you have any idea, please contact me! I may add your comment</p>
")))

(setq org-html-home/up-format "
<div id=\"org-div-home-and-up\">
 <a accesskey=\"h\" href=\"%s\"> index </a>
 |
 <a accesskey=\"H\" href=\"%s\"> ~dongdigua </a>
</div>")

(setq org-publish-project-alist
      '(("org-pages"
         :base-directory "."
         :base-extension "org"
         :publishing-directory "./../"
         :recursive t
         :publishing-function org-html-publish-to-html
         :preserve-breaks t

         :html-head "<link rel='stylesheet' href='css/main.css' /><link rel='stylesheet' href='css/org.small.css' />"
         ;; :html-head-include-default-style nil
         :html-link-home "https://dongdigua.github.io"
         :html-link-up "./../posts"
         :html-postamble t
         )))


;; from .emacs
(defun my/orgurl (proto)
  (defvar proto proto) ;; important
  (org-link-set-parameters proto
                           :export
                           (lambda (link description format _)
                             (let ((url (format "%s:%s" proto link)))
                               (format "<a href=\"%s\">%s</a>" url (or description url))))))
(my/orgurl "gopher")
(my/orgurl "gemini")

;; https://emacs.stackexchange.com/questions/36366/disable-auto-id-generation-in-org-mode-html-export
;; BUG: will cause toc not working, but I don't use much, so just add id manually
(defun html-body-id-filter (output backend info)
  "Remove random ID attributes generated by Org."
  (when (eq backend 'html)
    (replace-regexp-in-string
     " href=\"#org[[:alnum:]]\\{7\\}\""
     ""
     (replace-regexp-in-string
      " id=\"[[:alpha:]-]*org[[:alnum:]]\\{7\\}\""
      ""
      output t)
    t)))
(add-to-list 'org-export-filter-final-output-functions 'html-body-id-filter)


(defun myweb-publish ()
     "Publish myweb."
     (interactive)
     (setq debug-on-error t)
     (org-publish-all)

     (webfeeder-build
      "feed.xml"
      "./../"
      "https://dongdigua.github.io"
      (delete "kernel.html" (delete "404.html" (delete "xmr.html" (delete "index.html" (directory-files "./../" nil ".*\.html$")))))
      :title "dongdigua's blog"
      :description "Blog!"
      :builder 'webfeeder-make-rss)

     (kill-emacs))


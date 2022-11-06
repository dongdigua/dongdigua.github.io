;; this file and Makefile from:
;; https://www.cnblogs.com/banjia/archive/2012/09/29/2708966.html
;; CSDN, 阿里云, 这些垃圾都在未授权盗搬, 结果这个东西有些地方都过时了. 能不能有点创新...

;; System Crafter's video: https://youtu.be/AfkrzFodoNw

(eval-when-compile
  (require 'package)
  (package-initialize)

  (require 'org)
  (require 'ox)
  (require 'webfeeder))

;; https://emacs.stackexchange.com/questions/36366/disable-auto-id-generation-in-org-mode-html-export
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

(setq org-html-validation-link nil
      org-export-with-sub-superscripts nil)
(setq org-html-postamble-format
      '(("en"
         "
<p class=\"author\">Author: %a</p>
<p class=\"date\">Date: %d</p>
<p class=\"date\">Build: %T</p>
")))

(setq org-publish-project-alist
      '(("org-pages"
         :base-directory "."
         :base-extension "org"
         :publishing-directory "./../"
         :recursive t
         :exclude "画大饼.org"
         :publishing-function org-html-publish-to-html
         :preserve-breaks t

         :org-html-validation-link nil
         ;; https://github.com/rgb-24bit/org-html-theme-list org-joshua
         :html-head "<link rel='stylesheet' type='text/css' href='css/main.css' />"
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

(defun myweb-publish ()
     "Publish myweb."
     (interactive)
     (setq debug-on-error t)
     (org-publish-all)

     (webfeeder-build
      "feed.xml"
      "./../"
      "https://dongdigua.github.io"
      (delete "xmr.html" (delete "index.html" (directory-files "./../" nil ".*\.html$")))
      :title "dongdigua's blog"
      :description "Blog!"
      :builder 'webfeeder-make-rss)
     )


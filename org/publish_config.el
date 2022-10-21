;; this file and Makefile from:
;; https://www.cnblogs.com/banjia/archive/2012/09/29/2708966.html
;; CSDN, 阿里云, 这些垃圾都在未授权盗搬, 结果这个东西有些地方都过时了. 能不能有点创新...

;; System Crafter's video: https://youtu.be/AfkrzFodoNw

(require 'org)
(require 'ox)

(setq org-html-validation-link nil)
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
         :html-link-up "./../"
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
      "rss.xml"
      "./../"
      "https://dongdigua.github.io"
      (delete "index.html" (directory-files "./../" nil ".*\.html$"))
      :title "dongdigua's blog"
      :description "Blog!"
      :builder 'webfeeder-make-rss)
     )


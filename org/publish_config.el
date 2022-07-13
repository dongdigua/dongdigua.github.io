;; this file and Makefile from:
;; https://www.cnblogs.com/banjia/archive/2012/09/29/2708966.html
;; CSDN, 阿里云, 这些垃圾都在未授权盗搬, 结果这个东西有些地方都过时了
;; 能不能有点创新...

(require 'org)
(require 'ox)

(setq org-html-validation-link nil)
(setq org-publish-project-alist
      '(("org-pages"
         :base-directory "."
         :base-extension "org"
         :publishing-directory "./../org-html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :html-head "<link rel='stylesheet' type='text/css' href='./../css/org-css.css' />"  ; instead of :style
         )))

(defun myweb-publish ()
     "Publish myweb."
     (interactive)
     (setq debug-on-error t)
     (org-publish-all))


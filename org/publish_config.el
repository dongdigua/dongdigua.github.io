;; this file and Makefile from:
;; https://www.cnblogs.com/banjia/archive/2012/09/29/2708966.html
;; CSDN, 阿里云, 这些垃圾都在未授权盗搬, 结果这个东西有些地方都过时了
;; 能不能有点创新...

(require 'org)
(setq org-publish-project-alist
      '(("org-pages"
         :base-directory "."
         :base-extension "org"
         :publishing-directory "./.."
         :recursive t
         :publishing-function org-html-export-to-html
         )))

(defun myweb-publish ()
     "Publish myweb."
     (interactive)
     (setq debug-on-error t)
     (org-publish-all))


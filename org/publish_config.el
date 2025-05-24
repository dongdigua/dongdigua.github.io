(require 'package)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p '(webfeeder htmlize rust-mode elixir-mode go-mode))
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
      org-html-head-include-default-style nil
      org-export-with-toc 1
      org-export-with-sub-superscripts '{})

(setq org-html-postamble-format
      '(("en"
         "
<p>dongdigua CC BY-NC-SA 禁止转载到私域(公众号，非自己托管的博客等)</p>
<p>Email me to add comment</p>
<p>Proudly made with Emacs Org mode</p>
<p class=\"date\">Date: %d Size: PAGE_SIZE (≈ SWD_CO2 mg CO2e)</p>
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

         :html-doctype "html5"
         :html-html5-fancy t
         :html-head "<link rel='stylesheet' href='css/main.css' /><link rel='stylesheet' href='css/org.small.css' /><link rel='stylesheet' href='css/dark.css' />"
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


(defun my/delete-multiple (src l)
  (mapcar (lambda (x) (setq src (delete x src))) l)
  src)


(defun myweb-publish ()
     "Publish myweb."
     (interactive)
     (setq debug-on-error t)
     (org-publish-all)

     (webfeeder-build
      "feed.xml"
      "./../"
      "https://dongdigua.github.io"
      (my/delete-multiple (directory-files "./../" nil ".*\.html$")
                          '("posts.html"
                            "projects.html"
                            "about.html"
                            "my_timeline.html"
                            "kernel.html"
                            "404.html"
                            "xmr.html"
                            "index.html"))
      :title "dongdigua's blog"
      :description "Blog!"
      :builder 'webfeeder-make-rss)

     (kill-emacs))


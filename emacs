(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; print line and column number
(column-number-mode t)
(line-number-mode t)

;; show the matching pairs of parenthesis 
(require 'paren)
(show-paren-mode)

(global-set-key [dead-grave] "`")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(define-key key-translation-map [dead-grave] "`")
(define-key key-translation-map [dead-acute] "'")
(define-key key-translation-map [dead-circumflex] "^")
(define-key key-translation-map [dead-diaeresis] "\"")
(define-key key-translation-map [dead-tilde] "~")


(add-to-list 'load-path
	     "/home/afk/.opam/4.01.0+ocp1-20150120/share/emacs/site-lisp")
 (require 'ocp-indent)
(set-face-attribute 'default nil :height 105)

(add-to-list 'load-path "/home/afk/dev/tuareg/")


;; XML syntax color 
(load "/usr/share/emacs24/site-lisp/nxml-mode-20041004/rng-auto.el")
  (setq auto-mode-alist
        (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
	      auto-mode-alist))


;; GraphViz syntax color 
(load-file "/usr/share/emacs24/site-lisp/graphviz-dot-mode.el") 

;; Scala
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/scala-mode2/")
(require 'scala-mode2)

;; Emacs columns marker
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; sass, generating css 
(add-to-list 'load-path (expand-file-name "~/dev/nandane/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(add-to-list 'load-path "/usr/share/emacs24/site-lisp/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; All backup files are saved in ~/.trash

(setq make-backup-files nil)
(setq backup-directory-alist            '((".*" . "~/.Trash")))





(starter-kit-load "org")

(setq org-default-notes-file (concat "~/HesamResearch/WorkInProgress/org-files/refile-" system-name ".org"))
(setq org-directory "~/HesamResearch.com/WorkInProgress/org-files")

(setq org-agenda-files (mapcar 'abbreviate-file-name (split-string
(shell-command-to-string "find ~/HesamResearch -name \"*.org\"")
"\n")))

(require 'org-ac)

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "org-ac")

(org-ac/config-default)

;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-gray30)

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)

;(load "color-theme-colorful-obsolescence")
(load "color-theme-zenburn")
(color-theme-zenburn)
;(load "color-theme-tangotango")
;(load "color-theme-railscast")
;(load "color-theme-leuven")
;(load "color-theme-folio")
;(load "color-theme-zenash")
;(load "color-theme-manoj")

(set-frame-parameter (selected-frame) 'alpha '(95 95));Remove it if it does not work properly
(add-to-list 'default-frame-alist '(alpha 95 95))     ;Remove it if it does not work properly

; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
; initilize package.el
(package-initialize)
; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)
; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (setq achead:include-directories
   (append '("/usr/include/c++/5"
             "/usr/include/x86_64-linux-gnu/c++/5"
             "/usr/include/c++/5/backward"
             "/usr/lib/gcc/x86_64-linux-gnu/5/include"
             "/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed"
             "/usr/include/x86_64-linux-gnu")
             achead:include-directories)))
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


; start flymake-google-cpplint-load
; let's define a function for flymake initialization
(defun my:flymake-google-init () 
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/home/hesam/.cache/pip/wheels/f5/ba/81/00c14f0d4606c2f5de5273d2c35efa6355bb6fa6e5fa8ca104"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs part II
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic part III
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode 
(global-ede-mode 1)
; create a project for our program.
(ede-cpp-root-project "my project" :file "~/GTA2016/main.cc"
                      :include-path '("/../include"))
; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

(require 'flyspell-correct-popup)
(define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-previous-word-generic)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;(setq python-shell-interpreter "~/anaconda3/bin/python3.5")
(setq org-babel-python-command "python")

(add-hook 'org-mode-hook #'(lambda ()

                             ;; make the lines in the buffer wrap around the edges of the screen.

                             ;; to press C-c q  or fill-paragraph ever again!
                             (visual-line-mode)
                             (org-indent-mode)))
(setq text-mode-hook
      '(lambda() (auto-fill-mode 0)))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)


;Ref
(starter-kit-install-if-needed 'org-ref)   
(setq reftex-default-bibliography '("~/hesam.shams@gmail.com/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/hesam.shams@gmail.com/bibliography/notes.org"
      org-ref-default-bibliography '("~/hesam.shams@gmail.com/bibliography/references.bib")
      org-ref-pdf-directory "~/hesam.shams@gmail.com/bibliography/bibtex-pdfs/")

(setq helm-bibtex-bibliography "~/hesam.shams@gmail.com/bibliography/references.bib")
(setq helm-bibtex-library-path "~/hesam.shams@gmail.com/bibliography/bibtex-pdfs")


;; alternative
(setq helm-bibtex-pdf-open-function 'org-open-file)

(setq helm-bibtex-notes-path "~/hesam.shams@gmail.com/bibliography/helm-bibtex-notes.org")
(require 'org-ref)

(setq bibtex-autokey-year-length 4
    bibtex-autokey-name-case-convert-function (quote capitalize)
    bibtex-autokey-name-year-separator "-"
    bibtex-autokey-year-title-separator "-"
    bibtex-autokey-titleword-separator "-"
    bibtex-autokey-titlewords 2 bibtex-autokey-titlewords-stretch 1
    bibtex-autokey-titleword-length 5)

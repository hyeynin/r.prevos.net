;; Minimal init file to develop R code in Emacs
(package-initialize)

;; Package archives
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "http://orgmode.org/elpa/"))))

;;ESS - Emacs Speaks Statistics
(require 'ess-site)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))
(setq org-confirm-babel-evaluate nil)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
  (add-hook 'org-mode-hook 'org-display-inline-images)   
;; Line numbers
(add-hook 'ess-mode-hook 'linum-mode)
;; Redefine asign key
(require 'ess-smart-underscore)
;; Auto complete
(require 'auto-complete-config)
(ac-config-default)

;;Org BibTeX references
(require 'org-ref)
(org-ref-define-citation-link "citeA" ?a)
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	))

;; Org Mode Latex Templates
(require 'ox-latex)

;; American Psychological Association papers
(add-to-list 'org-latex-classes '("apa6"
    "\\documentclass[a4paper, jou]{apa6}
     [NO-DEFAULT-PACKAGES]
     \\usepackage[hidelinks]{hyperref}
     \\usepackage{apacite}
     \\usepackage[british]{babel}
     \\usepackage{ccicons}"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%Rs}")
	       ))

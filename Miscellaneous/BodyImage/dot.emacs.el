;; Minimal configuration
;; https://r.prevos.net

(package-initialize)

;; MELPA
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Activate ESS
(require 'ess-site)

;; Org-Mode LaTeX class definition
;; American Psychological Association
(add-to-list 'org-latex-classes
	     '("apa6"
	       "\\documentclass[a4paper, apacite, jou, 11pt]{apa6}
                \\usepackage[british]{babel}
                \\usepackage{ccicons}"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%Rs}")
))

;;Org BibTeX references
(require 'org-ref)
;; Add APA citation command
(org-ref-define-citation-link "citeA" ?a)
;; Redefine LaTeX run
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))

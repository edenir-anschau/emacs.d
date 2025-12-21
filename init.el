(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(load-theme 'modus-vivendi-tinted)
(tool-bar-mode -1)
(hl-line-mode nil)
(set-frame-font "JetBrainsMono Nerd Font Mono Medium 14" nil t)

;; packages to install: cider, denote, company, paredit, raindbown-delimiters

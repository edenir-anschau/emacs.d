(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(tool-bar-mode -1)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)

(load-theme 'modus-vivendi-tinted)
(set-frame-font "JetBrainsMono Nerd Font Mono Medium 14" nil t)

(setq project-mode-line 1)

(which-key-mode 1) ;;documentation at https://github.com/justbur/emacs-which-key

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/Documents/notes/"))

  (denote-rename-buffer-mode 1))

(use-package avy
  :ensure
  :bind
  (("C-:" . avy-goto-char)
   ("M-g w" . avy-goto-word-1)
   ("M-g l" . avy-goto-line)))

(use-package cider
  :ensure t)


;; packages to install: cider, company, paredit or smartparens, raindbown-delimiters

;; Do I need this?
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(avy cider denote)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

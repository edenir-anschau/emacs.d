(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(tool-bar-mode -1)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(setq auto-save-visited-file-name t)

(load-theme 'modus-vivendi-tinted)
(set-frame-font "JetBrains Mono Medium 12" nil t)

(setq project-mode-line 1)
(setq tab-always-indent 'complete)

(fset 'yes-or-no-p 'y-or-n-p)

(which-key-mode 1) ;;documentation at https://github.com/justbur/emacs-which-key

(use-package ledger-mode
  :ensure t
  :mode ("\\.ledger\\'" "\\.journal\\'"))

;;(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(use-package magit
  :ensure t)

(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-auto-update-doc nil)

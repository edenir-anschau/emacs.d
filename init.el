;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; Emacs activates installed packages before loading this file.
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :custom
  (company-auto-update-doc nil))

;; Interface
(tool-bar-mode -1)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)

(load-theme 'catppuccin :no-confirm)
;; Configure existing frames and defaults for future daemon client frames.
;; Face heights are in tenths of a point: 140 means 14 pt.
(dolist (frame '(nil t))
  (set-face-attribute 'default frame
                      :family "JetBrains Mono"
                      :weight 'medium
                      :height 140))

(setq project-mode-line t)
(which-key-mode 1)

;; Editing
(global-set-key (kbd "C-c e") #'end-of-buffer)
(global-set-key (kbd "C-c a") #'beginning-of-buffer)

(setq tab-always-indent 'complete
      use-short-answers t)
;; Auto-save writes directly to the visited file.
(setq auto-save-visited-file-name t)

;; Org-capture
(require 'org-capture)
(setq org-capture-templates
      '(("n" "Quick Note" entry
         (file "~/org/inbox.org")
         "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n"
         :empty-lines 1)))
(global-set-key (kbd "C-c c") #'org-capture)

(defun my/org-capture-frame ()
  "Open a capture in a dedicated frame with a single window."
  (interactive)
  (let ((frame (make-frame '((name . "org-capture")
                             (my/org-capture . t))))
        capture-started)
    (unwind-protect
        (progn
          (select-frame-set-input-focus frame)
          (org-capture nil "n")
          ;; Keep only the capture window created by Org.
          (when (bound-and-true-p org-capture-mode)
            (delete-other-windows)
            (setq capture-started t)))
      ;; Close the empty frame if capture fails or is canceled before starting.
      (unless capture-started
        (when (frame-live-p frame)
          (delete-frame frame))))))

(defun my/org-capture-delete-frame ()
  "Close the dedicated capture frame."
  (when (and (frame-live-p (selected-frame))
             (frame-parameter nil 'my/org-capture))
    (delete-frame)))

(add-hook 'org-capture-after-finalize-hook
          #'my/org-capture-delete-frame)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c4df9006b9eb32599d758800a32f3487c2cdf13826084511783b47d419024af2"
     default))
 '(package-selected-packages '(catppuccin-theme company magit org-roam)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

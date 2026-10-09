;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

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

(load-theme 'modus-vivendi-tinted)
;; An explicit height avoids inheriting terminal height 1 during daemon startup.
(set-face-attribute 'default nil
                    :font "JetBrains Mono Medium 12"
                    :height 120)

(setq project-mode-line t)
(which-key-mode 1)

;; Editing
(setq tab-always-indent 'complete
      use-short-answers t)
;; Auto-save writes directly to the visited file.
(setq auto-save-visited-file-name t)

;; Org-capture
(require 'org-capture)
(setq org-capture-templates
      '(("n" "Quick Note" entry
         (file "~/org/inbox.org")
         "* %^{Título}\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%?\n"
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

;; -*- mode: elisp -*-

;; Get package up and running
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;;
;; Packages
;;

(use-package undo-fu)
;; store undo in ~/.emacs.d/undo-fu-session
(use-package undo-fu-session
  :config (global-undo-fu-session-mode))

(use-package general
  :demand t
  :config
  (general-create-definer leader-def
    :prefix "SPC")
  (general-create-definer local-leader-def
    :prefix "SPC m"))

(use-package ace-window
  :after general
  :config
  (general-define-key
   :states 'normal
   "C-w" 'ace-window))

(use-package evil
  :demand t
  :init (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode t)
  (evil-ex-define-cmd "q[uit]" 'kill-buffer-and-window))

(use-package org)

(use-package lsp-mode)

(use-package python
  :hook (python-mode . lsp))

(use-package poetry)

(use-package dimmer
  :config (dimmer-mode t))

(use-package monokai-theme
  :config (load-theme 'monokai t))

;; User packages
(add-to-list 'load-path (expand-file-name "user" user-emacs-directory))
(require 'boss-man)

;; Auxiliary files
; Custtomizations in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

; Put all backup files under ~/.emacs.d/backup/
(let ((backup-dir
       (expand-file-name "backup" user-emacs-directory)))
  (setq backup-directory-alist `(("." . ,backup-dir))))

; No lockfiles
(setq create-lockfiles nil)

;; Appearance
(set-frame-font "UbuntuMono 13" nil t)
(menu-bar-mode 0)
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen t)
(column-number-mode)
(global-hl-line-mode t)

;; Whitespace
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; Editing
(transient-mark-mode t)
(setq sentence-end-double-space nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq show-paren-delay 0)
(show-paren-mode)

;; org mode fix
(with-eval-after-load "org"
  (when (version-list-= (version-to-list org-version) '(9 4 4))
    (defun org-return-fix (fun &rest args)
      "Fix https://emacs.stackexchange.com/questions/64886."
      (let* ((context (if org-return-follows-link (org-element-context)
            (org-element-at-point)))
             (element-type (org-element-type context)))
    (if (eq element-type 'src-block)
        (apply #'org--newline args)
      (apply fun args))))
    (advice-add 'org-return :around #'org-return-fix)))

(with-eval-after-load "org-src"
  (when (version-list-= (version-to-list org-version) '(9 4 4))
    (defun org-src--contents-for-write-back ()
      "Return buffer contents in a format appropriate for write back.
Assume point is in the corresponding edit buffer."
      (let ((indentation-offset
         (if org-src--preserve-indentation 0
           (+ (or org-src--block-indentation 0)
          (if (memq org-src--source-type '(example-block src-block))
              org-src--content-indentation
            0))))
        (use-tabs? (and (> org-src--tab-width 0) t))
        (source-tab-width org-src--tab-width)
        (contents (org-with-wide-buffer (buffer-string)))
        (write-back org-src--allow-write-back))
    (with-temp-buffer
      ;; Reproduce indentation parameters from source buffer.
      (setq indent-tabs-mode use-tabs?)
      (when (> source-tab-width 0) (setq tab-width source-tab-width))
      ;; Apply WRITE-BACK function on edit buffer contents.
      (insert (org-no-properties contents))
      (goto-char (point-min))
      (when (functionp write-back) (save-excursion (funcall write-back)))
      ;; Add INDENTATION-OFFSET to every non-empty line in buffer,
      ;; unless indentation is meant to be preserved.
      (when (> indentation-offset 0)
        (while (not (eobp))
          (skip-chars-forward " \t")
          ;; (unless (eolp)     ;ignore blank lines
          (let ((i (current-column)))
        (delete-region (line-beginning-position) (point))
        (indent-to (+ i indentation-offset)))
          ;;)
          (forward-line)))
      (buffer-string))))))

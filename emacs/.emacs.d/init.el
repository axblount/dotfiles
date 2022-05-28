;;; -*- mode: elisp; lexical-binding: t; -*-

;; Manage packages with straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;;
;; Packages
;;

(use-package evil
  :init
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode t)
  ;; this prevents :q from quitting emacs.
  ;; instead use :qa ot quit completely
  (evil-ex-define-cmd "q[uit]" 'kill-buffer-and-window))

(use-package general)

;; better undo for evil mode
(use-package undo-fu)

;; store undo in ~/.emacs.d/undo-fu-session
(use-package undo-fu-session
  :config (global-undo-fu-session-mode))

(use-package ace-window)

(use-package org
  :hook (org-mode . auto-fill-mode)
  :config
  (let ((org-journal-file (expand-file-name "journal.org"
                                            org-directory))
        (org-notes-file (expand-file-name "notes.org"
                                          org-directory)))
    (setq org-capture-templates
          `(("j" "Journal"
             entry
             (file+datetree ,org-journal-file)
             "* %?\n     Entered on %U\n%i\n%a")
            ("t" "Todo"
             entry
             (file+headline ,org-notes-file "Tasks")
             "* TODO %?\n%i\n%a")
            ("i" "Idea"
             entry
             (file+headline ,org-notes-file "Ideas"))))))

(use-package neotree
  :init
  (setq neo-smart-open t))

(use-package projectile
  :config
  (projectile-mode t))

(use-package lsp-mode
  :hook (c-mode . lsp)
  :init
  (setq lsp-enable-indentation nil)
  (setq lsp-clients-clangd-args
        '("-j=4"
          "--clang-tidy")))

(use-package company
  :hook (after-init . global-company-mode))

(use-package python
  :hook (python-mode . eglot-ensure))

(use-package dimmer
  :config (dimmer-mode t))

;; (use-package zenburn-theme
;;   :config
;;   (setq zenburn-scale-org-headlines t
;;         zenburn-scale-outline-headlines t)
;;   (load-theme 'zenburn t))

(use-package magit)

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)


;;
;; Plain Emacs config, nothing package specific
;;

;; Custtomizations in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
(load custom-file))

;; Put all backup files under ~/.emacs.d/backup/
(let ((backup-dir
        (expand-file-name "backup" user-emacs-directory)))
  (add-to-list 'backup-directory-alist
               `("." . ,backup-dir)))

;; No lockfiles
(setq create-lockfiles nil)

;; Appearance
(setq inhibit-startup-screen t)
(add-to-list 'default-frame-alist
             '(font . "Ubuntu Mono 13"))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
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

(setq show-paren-delay 0)
(show-paren-mode)

;; Don't follow symlinks when editing files, just edit in place
;; and pretend it's not a symlink
(setq vc-follow-symlinks nil)

;; C-Mode
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "k&r")))
(setq c-basic-offset 4)


;;;
;;; Keybinds
;;;

;; "Everywhere"
(general-def 'motion
  "C-w" 'ace-window
  "g [" 'backward-page
  "g ]" 'forward-page)

;; Leader bindings
(general-create-definer leader-def
  :prefix "SPC")

(general-create-definer local-leader-def
  :prefix "SPC m")

(leader-def 'normal
  "d" 'neotree-toggle
  "p" 'projectile-command-map
  "f n" 'flymake-goto-next-error
  "f p" 'flymake-goto-prev-error)

;; Org Mode
(local-leader-def '(normal motion) org-mode-map
  "t" 'org-todo)

;; NeoTree
(general-def '(normal motion) neotree-mode-map
  "RET" 'neotree-enter
  "TAB" 'neotree-quick-look
  "q" 'neotree-hide
  "g" 'neotree-refresh
  "n" 'neotree-next-line
  "p" 'neotree-previous-line
  "H" 'neotree-hidden-file-toggle
  "A" 'neotree-stretch-toggle)


;;;
;;; Miscellaneous
;;;

;; Save and load scratch buffer
(let ((scratch-file (expand-file-name ".scratch"
                                      user-emacs-directory)))
  (add-hook 'kill-emacs-hook
            #'(lambda ()
                (with-current-buffer "*scratch*"
                  (write-file scratch-file))))
  (add-hook 'after-init-hook
            #'(lambda ()
                (when (file-exists-p scratch-file)
                  (with-current-buffer "*scratch*"
                    (insert-file-contents scratch-file))))))

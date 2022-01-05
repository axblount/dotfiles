(require 'general)
(require 'evil)
(require 'org)

(define-minor-mode boss-man-mode
  "A simple minor mode for org under evil"
  :init-value nil
  :lighter " BM"
  :keymap (make-sparse-keymap)
  :group 'boss-man-mode)

(add-hook 'org-mode-hook 'boss-man-mode)

(general-define-key
  :states 'normal
  :keymaps 'boss-man-mode-map
  "TAB" 'org-cycle
  "t" 'org-todo
  "<" 'org-metaleft
  ">" 'org-metaright
  "gj" 'org-forward-heading-same-level
  "gk" 'org-backward-heading-same-level)

(local-leader-def ; "SPC"
  :states 'normal
  :keymaps 'boss-man-mode-map
  "g" 'org-goto
  "*" 'org-toggle-heading
  "RET" 'org-meta-return
  "S-RET" 'org-insert-heading-respect-content
  "i t" 'org-insert-todo-heading
  "t S-t" 'org-insert-todo-heading-respect-content)

(provide 'boss-man)

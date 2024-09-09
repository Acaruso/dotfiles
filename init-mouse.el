;; RightMouseButton pastes
(defun paste-with-mouse (click)
  "Paste at mouse click point."
  (interactive "e")
  (let ((pos (posn-point (event-start click))))
    (if pos
        (progn
          (goto-char pos)
          (yank))
      (mouse-yank-at-click click))))
(global-set-key (kbd "<mouse-3>") 'paste-with-mouse)

;; C-RightMouseButton copies
;; actually just copy by highlighting text with mouse
(defun copy-with-mouse (click)
  "Copy the selected text with Ctrl + mouse-3."
  (interactive "e")
  (if (use-region-p)
      (progn
        (kill-ring-save (region-beginning) (region-end))
        (message "Text copied"))
    (message "No region selected")))
(global-set-key (kbd "C-<mouse-3>") 'copy-with-mouse)

;; M-RightMouseButton toggles normal/insert mode
(defun toggle-evil-mode-with-mouse ()
  "Toggle between Evil normal and insert modes with the middle mouse button."
  (interactive)
  (if (evil-normal-state-p)
      (evil-insert-state)  ; If in normal mode, switch to insert mode
    (evil-normal-state))) ; Otherwise, switch to normal mode
(global-set-key (kbd "M-<mouse-3>") 'toggle-evil-mode-with-mouse)

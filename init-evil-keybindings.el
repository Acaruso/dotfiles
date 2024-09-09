(evil-define-key 'normal dired-mode-map "h" 'dired-up-directory)

(evil-define-key 'normal dired-mode-map "l" 'dired-find-file)

;; use M-hjkl to navigate windows (panes)
(eval-after-load 'evil
  '(progn
     (define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)))

(eval-after-load 'evil
  '(progn
     ;; Bind Ctrl-h/j/k/l for scrolling operations
     (define-key evil-normal-state-map (kbd "C-k") 'my-evil-scroll-line-up)
     (define-key evil-normal-state-map (kbd "C-j") 'my-evil-scroll-line-down)
     ;; C-/ comments out selection in visual block mode
     (define-key evil-normal-state-map (kbd "C-/") 'smart-comment)
     (define-key evil-normal-state-map (kbd "C-SPC") 'keyboard-quit)
     (define-key evil-normal-state-map (kbd "C-l") 'avy-goto-line)
     ))

(defun my-evil-scroll-line-up ()
  (interactive)
  (evil-scroll-line-up 1)
  (previous-line))

(defun my-evil-scroll-line-down ()
  (interactive)
  (evil-scroll-line-down 1)
  (next-line))

(with-eval-after-load 'evil-collection-ibuffer
  (evil-define-key 'normal ibuffer-mode map (kbd "l") 'ibuffer-visit-buffer))

(evil-define-key 'normal ibuffer-mode map (kbd "l") 'ibuffer-visit-buffer)

(define-key evil-normal-state-map (kbd "SPC") 'execute-extended-command)
(define-key ivy-minibuffer-map (kbd "C-SPC") 'minibuffer-keyboard-quit)

(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)

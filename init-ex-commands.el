(evil-ex-define-cmd "evb" 'eval-buffer)

(evil-ex-define-cmd "ib" 'ibuffer)

(evil-ex-define-cmd "pf" 'projectile-find-file)
(evil-ex-define-cmd "pg" 'projectile-grep)
(evil-ex-define-cmd "ff" 'find-file)

(evil-ex-define-cmd "sr" 'split-window-right)

(evil-ex-define-cmd "sd" 'split-window-below)

(evil-ex-define-cmd "dw" 'delete-window)

(evil-ex-define-cmd "sb" 'bookmark-set)

(evil-ex-define-cmd "jb" 'bookmark-jump)

(evil-ex-define-cmd "es" 'eshell)

(defun my-dired-current-directory ()
  (interactive)
  (dired default-directory))

(evil-ex-define-cmd "di" 'my-dired-current-directory)

(evil-ex-define-cmd "dir" 'dired)

(evil-ex-define-cmd "q" 'kill-buffer)

(evil-ex-define-cmd "f" (lambda ()
			              (interactive)
                          (counsel-etags-find-tag-at-point)
                          (recenter)))

(evil-ex-define-cmd "b" (lambda ()
			              (interactive)
			              (pop-tag-mark)
			              (recenter)))

(evil-ex-define-cmd "/" 'smart-comment)

(evil-ex-define-cmd "t" 'counsel-etags-menu)

(defun counsel-etags-menu ()
  (interactive)
  (ivy-read "etags command: " counsel-etags-commands
            :action (lambda (x)
                      (funcall (cdr x)))))

(defvar counsel-etags-commands
  '(("recent tags" . (lambda ()
		               (counsel-etags-recent-tag)
		               (recenter)))
    ("find tag" . counsel-etags-find-tag)))

(evil-ex-define-cmd "wi" 'counsel-window-menu)
(evil-ex-define-cmd "win" 'counsel-window-menu)

(defun counsel-window-menu ()
  (interactive)
  (ivy-read "window command: " counsel-window-commands
            :action (lambda (x)
                      (funcall (cdr x)))))

(defvar counsel-window-commands
  '(("delete-window" . delete-window)
  ("split-window-below" . split-window-below)
  ("split-window-right" . split-window-right)))

(evil-ex-define-cmd "cfg" 'counsel-config-menu)

(defun counsel-config-menu ()
  (interactive)
  (ivy-read "window command: " counsel-config-commands
            :action (lambda (x)
                      (funcall (cdr x)))))

(defvar counsel-config-commands
  '(("init.el" . (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
    ("init-evil-keybindings.el" . (lambda () (interactive) (find-file "~/.emacs.d/init-evil-keybindings.el")))
    ("init-ex-commands.el" . (lambda () (interactive) (find-file "~/.emacs.d/init-ex-commands.el")))
    ("init-mouse.el" . (lambda () (interactive) (find-file "~/.emacs.d/init-mouse.el")))
    ("init-packages.el" . (lambda () (interactive) (find-file "~/.emacs.d/init-packages.el")))
    ("init-scrolling.el" . (lambda () (interactive) (find-file "~/.emacs.d/init-scrolling.el")))
    ))

(define-key evil-normal-state-map "/" 'swiper)

(evil-ex-define-cmd "fs" 'toggle-frame-fullscreen)

(evil-ex-define-cmd "kill" 'save-buffers-kill-emacs)

(defun copy-file-path-to-clipboard ()
  (interactive)
  (if-let ((file-path (buffer-file-name)))
      (progn
        (kill-new file-path)
        (message "Copied buffer file path: %s" file-path))
    (message "Current buffer is not associated with a file!")))
(evil-ex-define-cmd "copy-path" 'copy-file-path-to-clipboard)

;; jump to org link
(evil-ex-define-cmd "jl" (lambda ()
                           (interactive)
                           (org-open-at-point)
                           (recenter)))

(defun insert-src-block (src-code-type)
  "Inserts a source code block in Org mode."
  (interactive "sEnter programming language: ")
  (newline-and-indent)
  (insert (format "#+BEGIN_SRC %s\n" src-code-type))
  (newline-and-indent)
  (insert "#+END_SRC")
  (previous-line 2)
  (end-of-line))
(evil-ex-define-cmd "src" 'insert-src-block)


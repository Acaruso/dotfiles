(evil-ex-define-cmd "evb" 'eval-buffer)

(evil-ex-define-cmd "ib" 'ibuffer)

(evil-ex-define-cmd "ff" 'find-file)

(evil-ex-define-cmd "sr" 'split-window-right)

(evil-ex-define-cmd "sd" 'split-window-below)

(evil-ex-define-cmd "sb" 'bookmark-set)

(evil-ex-define-cmd "jb" 'bookmark-jump)

(evil-ex-define-cmd "es" 'eshell)

(defun my-dired-current-directory ()
  (interactive)
  (dired default-directory))

(evil-ex-define-cmd "di" 'my-dired-current-directory)

(evil-ex-define-cmd "dir" 'dired)

(evil-ex-define-cmd "dw" 'delete-window)
;; (evil-ex-define-cmd "qq" (lambda ()
;; 			   (interactive)
;; 			   (kill-buffer)
;; 			   (delete-window)))

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


(defvar counsel-etags-commands
  '(("recent tags" . counsel-etags-recent-tag)
    ("find tag" . counsel-etags-find-tag)))

(defvar counsel-etags-commands
  '(("recent tags" . (lambda ()
		       (counsel-etags-recent-tag)
		       (recenter)))
    ("find tag" . counsel-etags-find-tag)))

(defun counsel-etags-menu ()
  (interactive)
  (ivy-read "etags command: " counsel-etags-commands
            :action (lambda (x)
                      (funcall (cdr x)))))

(evil-ex-define-cmd "t" 'counsel-etags-menu)



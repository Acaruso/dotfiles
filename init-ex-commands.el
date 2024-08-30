(evil-ex-define-cmd "evb" 'eval-buffer)

(evil-ex-define-cmd "ib" 'ibuffer)

(evil-ex-define-cmd "ff" 'find-file)

(evil-ex-define-cmd "sr" 'split-window-right)

(evil-ex-define-cmd "bs" 'bookmark-set)

(evil-ex-define-cmd "bj" 'bookmark-jump)

(evil-ex-define-cmd "es" 'eshell)

(defun my-dired-current-directory ()
  (interactive)
  (dired default-directory))

(evil-ex-define-cmd "di" 'my-dired-current-directory)

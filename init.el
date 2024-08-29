;; Options stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages '(lsp-mode evil magit))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight regular :height 113 :width normal)))))

;; MELPA stuff ------------------------------------------------------------

(require 'package) ; Initialize package management

;; Add MELPA repository
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Initialize the package system
(when (< emacs-major-version 27)
  (package-initialize))

;; Refresh package contents if the package list is not already available
(unless package-archive-contents
  (package-refresh-contents))

;; other -----------------------------------------------------------------

(defun edit-emacs-config ()
  "Open the init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defalias 'config 'edit-emacs-config)

(setq bookmark-save-flag 1)

;; `l` navigates up a directory in dired
(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "l") 'dired-up-directory))

(defun dired-open-in-place ()
  (interactive)
  (dired-find-alternate-file))  ; `a` key in Dired

(defun dired-up-directory-same-buffer ()
  "Go up a directory but reuse the same buffer."
  (interactive)
  (find-alternate-file ".."))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-open-in-place)
  (define-key dired-mode-map (kbd "l") 'dired-up-directory-same-buffer)
  (put 'dired-find-alternate-file 'disabled nil))  ; Disable the warning

;; evil mode
(require 'evil)
(evil-mode 1)

(evil-define-key 'normal dired-mode-map "h" 'dired-up-directory)

(evil-define-key 'normal dired-mode-map "l" 'dired-find-file)

;; use M-hjkl to navigate windows (panes)
(eval-after-load 'evil
  '(progn
     (define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)))

;; use C-jk to scroll up and down
(eval-after-load 'evil
  '(progn
     ;; Bind Ctrl-h/j/k/l for scrolling operations
     (define-key evil-normal-state-map (kbd "C-k") 'evil-scroll-line-up)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-scroll-line-down)
     ))

(with-eval-after-load 'help-mode
  (define-key help-mode-map (kbd "M-j") 'evil-window-down)
  (define-key help-mode-map (kbd "M-k") 'evil-window-up))
 
;; help stuff
;; press C-c h to bring up custom help window
(defun my-custom-help ()
  "Show a custom help buffer."
  (interactive)
  (let ((help-text
         (concat
          "Custom Help\n"
          "===========\n\n"
          "Basic Keybindings:\n"
          "- `C-x C-f`: Find file\n"
          "- `C-x b`: Switch buffer\n"
          "- `C-x k`: Kill buffer\n"
          "- `C-x C-c`: Quit Emacs\n\n"
          "Evil Mode:\n"
          "- `/`: Search forward\n"
          "- `?`: Search backward\n"
          "- `n`: Repeat search forward\n"
          "- `N`: Repeat search backward\n")))
    (with-help-window "*My Help*"
      (princ help-text))))

(global-set-key (kbd "C-c h") 'my-custom-help)

;; scrolling stuff
;; Scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ; scroll window under mouse
(setq scroll-step 1) ; keyboard scroll one line at a time
(setq scroll-conservatively 10000) ; Move the point only when it reaches the window edges
(setq scroll-margin 3) ; Start scrolling when the point is this many lines from window edges

;; display line numbers
(global-display-line-numbers-mode)

;; (setq tramp-ssh-controlmaster-options
;; (concat
;; "-i \"C:\\Users\\ajc\\keypairs\\ajc-key-pair.pem\" "
;; "-o ControlMaster=auto "
;; "-o ControlPath='tramp.%%C' "
;; "-o ControlPersist=no"))

;; (setq tramp-ssh-controlmaster-options
;;       (concat
;;        "-i \"C:\\\\Users\\\\ajc\\\\keypairs\\\\ajc-key-pair.pem\" "  ; Double backslashes for proper escaping
;;        "-o ControlMaster=auto "
;;        "-o ControlPath='tramp.%%C' "
;;        "-o ControlPersist=no"))

(setq tramp-ssh-controlmaster-options
      "-i C:/Users/ajc/keypairs/ajc-key-pair.pem -o ControlMaster=auto -o ControlPath=tramp.%%C -o ControlPersist=no")

(setq tramp-verbose 10)  ; Increase the verbosity level to get detailed logs

;; /ssh:ubuntu@ec2-54-234-49-150.compute-1.amazonaws.com#22:/

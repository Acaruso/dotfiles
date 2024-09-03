;; Options stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(custom-safe-themes
   '("8d146df8bd640320d5ca94d2913392bc6f763d5bc2bb47bed8e14975017eea91"
     default))
 '(package-selected-packages
   '(amx company company-ctags counsel counsel-etags evil evil-collection
	 evil-nerd-commenter key-chord lsp-mode magit modus-themes
	 smart-comment))
 '(tool-bar-mode nil))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Monospace" :foundry "outline" :slant normal :weight regular :height 100 :width normal)))))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight regular :height 113 :width normal)))))

;;(message "Available fonts: %s" (font-family-list))

;; (set-frame-font "Inconsolata-12" nil t)
;; (set-frame-font "Ubuntu Sans Mono-11" nil t)
;; (set-frame-font "DejaVu Sans Mono-11" nil t)
;; (set-frame-font "Liberation Mono-11" nil t)

;; (when (member "Inconsolata" (font-family-list))
;;   (set-face-attribute 'default nil
;;                       :family "Inconsolata"
;;                       :foundry "outline"
;;                       :slant 'normal
;;                       :weight 'normal
;;                       :height 113
;;                       :width 'normal))

;; don't use bold font when displaying code
(set-face-bold 'font-lock-keyword-face nil)
(set-face-bold 'font-lock-type-face nil)

(load-file "~/.emacs.d/init-packages.el")

(load-file "~/.emacs.d/init-ex-commands.el")

(load-file "~/.emacs.d/init-evil-keybindings.el")

(load-file "~/.emacs.d/init-scrolling.el")

;; other -----------------------------------------------------------------

(defun config ()
  "Open the init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

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

(defun list-installed-packages ()
  "Print a list of all installed packages."
  (interactive)
  (with-current-buffer (get-buffer-create "*Installed Packages*")
    (erase-buffer)
    (dolist (pkg package-alist)
      (let ((name (car pkg))
            (desc (car (cdr pkg))))
        (when (package-installed-p name)
          (insert (format "%s: %s\n" name (package-desc-summary desc))))))
    (switch-to-buffer (current-buffer))))

(blink-cursor-mode 0)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set the tab width and standard indent to 4 spaces
(setq-default tab-width 4)
(setq-default standard-indent 4)

(defun my-c-mode-hook ()
  (setq c-basic-offset 4)   ;; Set indentation level to 4 spaces
  (c-set-offset 'substatement-open 0)   ;; Don't indent braces
  ;; (c-set-style "bsd")
)

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; (setq-default c-basic-offset 4)

;; (custom-set-variables
;;  '(c-basic-offset 4))

;; (defun debug-c-hook ()
;;   (message "c-basic-offset is now set to: %s" c-basic-offset))

;; (add-hook 'c-mode-common-hook 'debug-c-hook t)  ;; 't' to ensure it runs last

(message "init.el loaded")

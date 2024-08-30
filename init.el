;; Options stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages '(counsel evil-collection key-chord lsp-mode evil magit))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight regular :height 113 :width normal)))))

(load-file "~/.emacs.d/init-packages.el")

(load-file "~/.emacs.d/init-ex-commands.el")

(load-file "~/.emacs.d/init-evil-keybindings.el")

(load-file "~/.emacs.d/init-scrolling.el")

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

(message "init.el loaded")

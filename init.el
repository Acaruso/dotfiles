;; Options stuff

;; (customize-set-variable 'scroll-bar-mode nil)
;; (customize-set-variable 'horizontal-scroll-bar-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(custom-safe-themes
   '("8d146df8bd640320d5ca94d2913392bc6f763d5bc2bb47bed8e14975017eea91" default))
 '(horizontal-scroll-bar-mode nil)
 '(package-selected-packages
   '(org-autolist eshell-bookmark avy auto-highlight-symbol highlight-symbol amx company company-ctags counsel counsel-etags evil evil-collection evil-nerd-commenter key-chord lsp-mode magit modus-themes smart-comment))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(menu-bar-mode -1)

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

(set-frame-font "Consolas-11" nil t)
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
(load-file "~/.emacs.d/init-mouse.el")

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

;; (setq tramp-verbose 10)  ; Increase the verbosity level to get detailed logs

(when (eq system-type 'windows-nt)
  ;; Get the tramp-methods variable populated
  (require 'tramp)
  ;; Add the '-tt' flag to the login arguments for "ssh" ONLY
  (push '("-tt")
        (cadr (assoc 'tramp-login-args
                     (assoc "ssh" tramp-methods)))))

;; supposedly this is also necessary for tramp
(when (eq system-type 'windows-nt)
  (prefer-coding-system 'utf-8-unix))

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

;; automatically insert closing quotes, parens, etc.
(electric-pair-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; disable scrollbars
;; (customize-set-variable 'scroll-bar-mode nil)
;; (customize-set-variable 'horizontal-scroll-bar-mode nil)

;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (scroll-bar-mode -1)
;;             (horizontal-scroll-bar-mode -1)))

;; (defun my/disable-scroll-bars (frame)
;;   (modify-frame-parameters frame
;;                            '((vertical-scroll-bars . nil)
;;                              (horizontal-scroll-bars . nil))))
;; (add-hook 'after-make-frame-functions 'my/disable-scroll-bars)

;; (add-to-list 'default-frame-alist
;;              '(vertical-scroll-bars . nil))

;; org mode stuff

(defun org-indent-item-custom ()
  "Indent an org list item."
  (interactive)
  (if (org-at-item-p)
      (org-indent-item)
    (insert "\t")))

(defun org-outdent-item-custom ()
  "Outdent an org list item."
  (interactive)
  (if (org-at-item-p)
      (org-outdent-item)
    (delete-backward-char 1)))

(with-eval-after-load 'org
  ;; Unbind the default TAB actions
  (define-key org-mode-map (kbd "TAB") nil)
  (define-key org-mode-map (kbd "<tab>") nil)

  ;; Bind new TAB behavior
  (define-key org-mode-map (kbd "TAB") 'org-indent-item-custom)
  (define-key org-mode-map (kbd "<tab>") 'org-indent-item-custom)
  (define-key org-mode-map (kbd "<S-tab>") 'org-outdent-item-custom)
  (define-key org-mode-map (kbd "<S-iso-lefttab>") 'org-outdent-item-custom)

  ;; (define-key org-mode-map (kbd "M-h") 'evil-window-left)
  ;; (define-key org-mode-map (kbd "M-j") 'evil-window-down)
  ;; (define-key org-mode-map (kbd "M-k") 'evil-window-up)
  ;; (define-key org-mode-map (kbd "M-l") 'evil-window-right)
  )

(with-eval-after-load 'org
  (with-eval-after-load 'evil
    (evil-define-key 'normal org-mode-map (kbd "M-h") 'evil-window-left)
    (evil-define-key 'normal org-mode-map (kbd "M-j") 'evil-window-down)
    (evil-define-key 'normal org-mode-map (kbd "M-k") 'evil-window-up)
    (evil-define-key 'normal org-mode-map (kbd "M-l") 'evil-window-right)
  ))

(message "init.el loaded")

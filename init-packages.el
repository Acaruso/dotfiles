;; package init -------------------------------------------------------------------------

(require 'package) ; Initialize package management

;; Add MELPA repository
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Initialize the package system -- this is not necessary for emacs v27 or above
(when (< emacs-major-version 27)
  (package-initialize))

;; Refresh package contents if the package list is not already available
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'magit)
  (package-install 'magit))

(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))

(setq evil-want-keybinding nil)

(unless (package-installed-p 'evil)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))
(evil-collection-init)

(unless (package-installed-p 'smart-comment)
  (package-install 'smart-comment))

(unless (package-installed-p 'key-chord)
  (package-install 'key-chord))

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(setq key-chord-two-keys-delay 0.3)

(unless (package-installed-p 'counsel)
  (package-install 'counsel))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(unless (package-installed-p 'counsel-etags)
  (package-install 'counsel-etags))

(unless (package-installed-p 'company)
  (package-install 'company))

(add-hook 'after-init-hook 'global-company-mode)

(unless (package-installed-p 'company-ctags)
  (package-install 'company-ctags))

(with-eval-after-load 'company
  (company-ctags-auto-setup))

(unless (package-installed-p 'amx)
  (package-install 'amx))

(amx-mode)

(setq counsel-M-x-function 'amx)

(unless (package-installed-p 'modus-themes)
  (package-install 'modus-themes))

(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'projectile)
(projectile-mode +1)
(setq projectile-completion-system 'ivy)

(unless (package-installed-p 'counsel-projectile)
  (package-install 'counsel-projectile))
(counsel-projectile-mode)

;; (unless (package-installed-p 'auto-highlight-symbol)
;;   (package-install 'auto-highlight-symbol))
;; (require 'auto-highlight-symbol)
;; (global-auto-highlight-symbol-mode t)

(unless (package-installed-p 'avy)
  (package-install 'avy))
(setq avy-background t)

(unless (package-installed-p 'eshell-bookmark)
  (package-install 'eshell-bookmark))
(add-hook 'eshell-mode-hook 'eshell-bookmark-setup)

(unless (package-installed-p 'eshell-bookmark)
  (package-install 'eshell-bookmark))

;; (eval-when-compile
;;   (require 'use-package))

;; (use-package org-autolist
;;   :hook (org-mode . org-autolist-mode))

(unless (package-installed-p 'org-autolist)
  (package-install 'org-autolist))
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

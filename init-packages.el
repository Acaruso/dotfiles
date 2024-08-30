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

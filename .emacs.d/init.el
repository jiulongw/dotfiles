(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)

(require 'cl)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defvar my-package-list
  '(
    evil
    evil-commentary
    evil-indent-plus
    evil-leader
    evil-search-highlight-persist
    evil-surround
    evil-visualstar
    linum-relative
    monokai-theme
    multi-term
    projectile)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  "Check if all packages in `my-package-list' are installed."
  (every #'package-installed-p my-package-list))

(unless (my-packages-installed-p)
  (package-refresh-contents)

  ;; install the missing packages
  (dolist (p my-package-list)
    (when (not (package-installed-p p))
      (package-install p))))

;; package initialization
(evil-mode 1)
(evil-commentary-mode)
(global-evil-leader-mode)
(global-evil-visualstar-mode)
(global-evil-search-highlight-persist t)
(global-linum-mode t)
(evil-indent-plus-default-bindings)
(linum-relative-global-mode)
(projectile-global-mode)
(load-theme 'monokai t)

;; turn on whitespace mode, except in shell mode, which is handled by the hook
(global-whitespace-mode)

;; evil leader key
(evil-leader/set-leader ",")
(evil-leader/set-key
  "pf" 'projectile-find-file
  "pg" 'projectile-grep
  "to" 'multi-term
  "tp" 'multi-term-prev
  "tn" 'multi-term-next
  "td" 'multi-term-dedicated-toggle
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "ff" 'toggle-frame-fullscreen
  "fm" 'toggle-frame-maximized
  "w" 'whitespace-mode)

;; Ctrl+L = redraw and clear highlights
(defun redraw-and-clear-highlight ()
  "redraw-dislay and clear search highlight for C-L binding"
  (interactive)
  (redraw-display)
  (evil-search-highlight-persist-remove-all)
  )

(global-set-key (kbd "C-l") 'redraw-and-clear-highlight)

;; multi-term shell
(setq multi-term-dedicated-select-after-open-p t)
(setq multi-term-program "/usr/local/bin/zsh")
(add-hook 'term-mode-hook
          (lambda ()
            (projectile-mode -1)
            (whitespace-mode -1)
            ))

;; org-mode hooks
(add-hook 'org-mode-hook
          (lambda ()
            (linum-relative-mode -1)
            ))

;; show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; language specific indent settings
(setq js-indent-level 2)

;; auto modes
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; backup settings
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.saves"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; UI settings
(tool-bar-mode -1)
(menu-bar-mode -1)

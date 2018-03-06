
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
;;Short windows + return
(global-set-key (kbd "<s-return>") 'ansi-term)

(use-package org-bullets
  :ensure t
  :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq org-ellipsis " ")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-export-with-smart-quotes t)
(setq org-src-window-setup 'current-window)

(use-package org-bullets
:ensure t
:config 
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq x-select-enable-clipboard t)

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)
  (setq locale-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package wrap-region
  :ensure t
  :init (wrap-region-mode t))

(use-package beacon
  :ensure t
  :init
  (beacon-mode t))

;; find the curse when you switch the buffer
(when window-system (global-hl-line-mode t))

;; Add ascii symbals when you are writing their names. ie lambda changes to lambdas symbol
(when window-system (global-prettify-symbols-mode t))

(setq display-time-24hr-format t)
(setq display-time-format "%H:%M - %d %B %Y")

(use-package projectile
  :ensure t
  :init
    (projectile-mode 1))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

(global-subword-mode 1)

(use-package smartparens
:ensure t
:diminish smartparens-mode
:config(add-hook 'prog-mode-hook 'smartparens-mode))

(use-package company
        :ensure t
        :init
        (add-hook 'after-init-hook 'global-company-mode)
        :config
        (add-hook 'js-mode-hook (lambda () (tern-mode t)))
        (add-to-list 'company-backends 'company-tern)
        (add-hook 'css-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-css))))
)

(use-package yasnippet
      :ensure t
      :diminish yas-minor-mode
      :config
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/yasnippet")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/html-mode")      
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/js2-mode")
      (yas-global-mode)
      (global-set-key (kbd "M-/") 'company-yasnippet))

(use-package rainbow-mode
    :init
    (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
      (add-hook hook 'rainbow-mode)))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package linum-relative
  :ensure t
  :config
    (setq linum-relative-current-symbol "")
    (add-hook 'prog-mode-hook 'linum-relative-mode))

(use-package dashboard
  :ensure t
  :config
    (dashboard-setup-startup-hook)
    (setq dashboard-items '((recents  . 5)
                            (projects . 5)))
    (setq dashboard-banner-logo-title "Welcome to Emacs!"))

(use-package company-jedi
  :ensure t
  :init
    (add-to-list 'company-backends 'company-jedi))

(setq-default js-indent-level 2)
 (use-package js2-mode
    :ensure t
    :mode "\\.js\\'"
    :config
    (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")))
  (use-package js2-refactor
    :ensure t
    :config
    (js2r-add-keybindings-with-prefix "C-c C-m")
    (add-hook 'js2-mode-hook 'js2-refactor-mode))
  (use-package rjsx-mode
    :ensure t)
(use-package prettier-js
    :ensure t
    :config
    (setq prettier-js-args '(
                          "--trailing-comma" "es5"
                          "--single-quote" "true"
                          "--print-width" "100"
                          ))
    (add-hook 'js2-mode-hook 'prettier-js-mode)
    (add-hook 'rjsx-mode-hook 'prettier-js-mode))
  (defun jc/use-eslint-from-node-modules ()
    "Set local eslint if available."
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/eslint/bin/eslint.js"
                                          root))))
      (when (and eslint (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint))))
  (use-package web-mode
    :ensure t)
  (use-package markdown-mode
    :ensure t
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
:init (setq markdown-command "multimarkdown"))

(use-package company
  :diminish company-mode
  :init
  (setq company-dabbrev-ignore-case t
        company-dabbrev-downcase nil)
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-tern
    :ensure t
:init (add-to-list 'company-backends 'company-tern)))

(use-package fzf
  :ensure t)
  (use-package flycheck
    :ensure t
    :config
    (add-hook 'after-init-hook 'global-flycheck-mode)
    (add-hook 'flycheck-mode-hook 'jc/use-eslint-from-node-modules)
    (add-to-list 'flycheck-checkers 'proselint))
  (flycheck-define-checker proselint
    "A linter for prose."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message (one-or-more not-newline)
                       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
              line-end))
    :modes (text-mode markdown-mode gfm-mode org-mode))

(use-package switch-window
  :ensure t
  :config
    (setq switch-window-input-style 'minibuffer)
    (setq switch-window-increase 4)
    (setq switch-window-threshold 2)
    (setq switch-window-shortcut-style 'qwerty)
    (setq switch-window-qwerty-shortcuts
        '("a" "s" "d" "f" "j" "k" "l" "i" "o"))
  :bind
    ([remap other-window] . switch-window))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun delete-whole-word()
     (interactive)
(backward-word)
(kill-word 1)
)
(global-set-key (kbd "C-c w w") 'delete-whole-word)

(use-package hungry-delete
  :ensure t
  :config
    (global-hungry-delete-mode))

(use-package sudo-edit
  :ensure t
  :bind
    ("s-e" . sudo-edit))

(global-set-key (kbd "C-x b") 'ibuffer)

(setq ibuffer-expert t)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  )

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex)
  )

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(defun close-all-buffers ()
  "Kill all buffers without regard for their origin."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'close-all-buffers)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun config-visit()
  (interactive)
  (find-file "~/.emacs.d/config.org")
  )
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name) "~/.emacs.d/config.org")
  )
(global-set-key (kbd "C-c r") 'config-reload)

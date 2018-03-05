
(use-package org-bullets
:ensure t
:config 
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

;;scroll line by line
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)

;; find the curse when you switch the buffer
(when window-system (global-hl-line-mode t))
;; Add ascii symbals when you are writing their names. ie lambda changes to lambdas symbol

(when window-system (global-prettify-symbols-mode t)) 
;;(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;
(use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config
    (add-hook 'prog-mode-hook 'smartparens-mode))

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

(use-package yasnippet
      :ensure t
      :diminish yas-minor-mode
      :config
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/yasnippet")
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/html-mode")      
      (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/js-mode")
      (yas-global-mode)
      (global-set-key (kbd "M-/") 'company-yasnippet))

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

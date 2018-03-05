
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'load-path "~/.emacs.d/tern-master")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-hook 'after-init-hook 'global-company-mode)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


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
;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (org-bullets wrap-region ac-emmet emmet-mode yasnippet-snippets js-auto-beautify web-beautify tern-auto-complete company-tern markdown-mode web-mode prettier-js rjsx-mode js2-refactor yasnippet flycheck fzf company-anaconda company-go company smartparens js2-mode beacon spacemacs-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "GOOG" :family "Knack")))))

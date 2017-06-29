;; These are bindings for 26.0.50 or higher

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("SC" . "http://joseito.republika.pl/sunrise-commander/")
))

;; Allow the narrowing to a region within an indirect buffer
(put 'narrow-to-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" "01ce486c3a7c8b37cf13f8c95ca4bb3c11413228b35676025fdf239e77019ea1" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (
     ample-theme
     auto-complete
     autopair
     badger-theme
     column-marker
     counsel-projectile
     dired-narrow
     dracula-theme
     dtrt-indent
     emmet-mode
     ensime
     evil
     evil-anzu
     evil-lion
     evil-magit
     evil-mc
     evil-nerd-commenter
     exec-path-from-shell
     expand-region
     flycheck,
     git-timemachine
     gitignore-mode
     haskell-mode
     highlight-thing
     htmlize
     ivy
     ivy-bibtex
     json-mode
     linum-relative
     magit
     move-text
     org
     org-babel-eval-in-repl
     org-ref
     ox-gfm
     paradox
     protobuf-mode
     rainbow-delimiters
     rainbow-mode
     ranger
     restclient
     reykjavik-theme
     smart-mode-line
     spaceline
     sublime-themes
     sunrise-commander
     use-package
     wc-mode
     web-mode
     writeroom-mode
     )))
 '(paradox-github-token t)
 '(safe-local-variable-values (quote ((org-confirm-babel-evaluate))))
 '(sml/theme (quote automatic)))
(setq load-prefer-newer t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq
 auto-save-interval 20   ; save every 20 characters typed (this is the minimum)
 backup-by-copying t     ; don't clobber symlinks
 kept-new-versions 10    ; keep 10 latest versions
 kept-old-versions 0     ; don't bother with old versions
 delete-old-versions t   ; don't ask about deleting old versions
 version-control t       ; number backups
 vc-make-backup-files t) ; backup version controlled files

(setq ring-bell-function 'ignore)
(require 'iso-transl) ;; For accents

;; overwrite selected when writing
(delete-selection-mode t)

(setq-default tab-width 2 indent-tabs-mode nil)

(global-set-key (kbd "s-_") 'text-scale-decrease)
(global-set-key (kbd "s-+") 'text-scale-increase)
(global-set-key (kbd "s-{") 'previous-buffer)
(global-set-key (kbd "s-}") 'next-buffer)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "s-<f12>") 'toggle-frame-fullscreen)
(global-set-key (kbd "s-O") 'counsel-projectile-switch-project)
(global-set-key (kbd "s-G") 'magit-status)

;; Key-bindings that are some how not the same in Mac and Unix
(global-set-key (kbd "s-k") 'kill-current-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-z") 'undo-tree-undo)
(global-set-key (kbd "s-Z") 'undo-tree-redo)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-a") 'mark-whole-buffer)

(defun my-move-line-or-region-up ()
  (interactive)
  (if mark-active
    (move-text-region-up (region-beginning) (region-end) 1)
    (move-text-line-up)
  )
)
(global-set-key (kbd "M-<down>") 'my-move-line-or-region-down)

(global-set-key (kbd "M-<up>") 'my-move-line-or-region-up)
(defun my-move-line-or-region-down ()
  (interactive)
  (if mark-active
    (move-text-region-down (region-beginning) (region-end) 1)
    (move-text-line-down)
  )
)

;; evil-nerd-commenter
(evilnc-default-hotkeys)

;; Layout
(setq column-number-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
;; Fixes an issue with spaceline on OS X where there were glitches the > < signs
(setq-default ns-use-srgb-colorspace nil)

;; Do not automatically split buffers
;; (defun no-split-window ()
;;   (interactive)
;;   nil)
;; (setq split-window-preferred-function 'no-split-window)

;; Default split direction: horizontally
(setq split-width-threshold 1)

(sml/setup)

(require 'dracula-theme)
(load-theme 'dracula t)

(let ((font-name "Source Code Pro Light 13"))
  (set-default-font font-name)
  (set-frame-font font-name))

(set-face-attribute 'mode-line nil  :height 120)

;; Evil-mode
(use-package evil
  :config
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
  ;; Makes sure that wrapped lines will not move more than a single line
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "<down>") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "<up>") 'evil-previous-visual-line)

  (setq anzu-cons-mode-line-p nil) ;; Disable anzu as it is provided within spaceline already

  (require 'evil-magit)
  (evil-lion-mode t)
)
(evil-mode t)

;; Ivy
(require 'ivy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-s-<tab>") 'ivy-switch-buffer)
(ivy-mode t)

;; Rainbow Delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Show-paren-mode
(show-paren-mode t)
(require 'autopair)
(autopair-global-mode) ;; automatically pairs braces and quotes

;; Auto-complete
(require 'auto-complete)
(ac-config-default)

;; Ensime
(require 'ensime)
(use-package ensime
  :mode
  ("\\.scala\\'" . scala-mode)

  :init
	(add-to-list 'exec-path "/usr/local/bin")
	(setq ensime-search-interface 'ivy)

  :bind (:map ensime-mode-map
    ("s-<return>" . ensime-edit-definition)
    ("M-<return>" . ensime-import-type-at-point)
    ("C-<return>" . ensime-type-at-point)
    ("M-s-f" . ensime-search)
  ))

(add-hook 'scala-mode-hook
          (lambda ()
            (push '(">=" . ?≥) prettify-symbols-alist)
            (push '("<=" . ?≤) prettify-symbols-alist)
            (push '("!=" . ?≠) prettify-symbols-alist)
            (push '("=>" . ?⇒) prettify-symbols-alist)
            (push '("->" . ?→) prettify-symbols-alist)
            (push '("<-" . ?←) prettify-symbols-alist)
            (push '("<<" . ?≪) prettify-symbols-alist)
            (push '(">>" . ?≫) prettify-symbols-alist)
            (prettify-symbols-mode t)))

;; Counsel Projectile
(require 'counsel-projectile)
(counsel-projectile-on)
(global-set-key (kbd "s-f") 'counsel-projectile)

;; Expand Region
(require 'expand-region)
(global-set-key (kbd "s-2") 'er/expand-region)

(use-package org
  :mode
  (("\\.org$" . org-mode))

  :init
  ;; Fixes an issue where exporting HTML file didn't work
  (set-default 'imenu-auto-rescan t)

  :config
  (add-hook 'org-mode-hook (lambda () (writeroom-mode 1)
                             (linum-mode -1)
                             (visual-line-mode t)))

  ;; Disable the size of headings
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0))

  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-latex-caption-above nil) ;; Make sure that captions are below and not above

  ;; Supported programming languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)))

)

;; (use-package ox-gfm
;;   :init
;;   (when (boundp 'org-export-backends)
;;     (customize-set-variable 'org-export-backends
;;                             (cons 'gfm org-export-backends))))

(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; Write room
(use-package writeroom-mode
  :config
  (setq writeroom-mode-line t)
)

;; Rainbow mode (for automatic coloring of html color codes (e.e. #f00))
(require 'rainbow-mode)
(rainbow-mode t)

;; Linum relative lines
(require 'linum-relative)
(linum-mode t)
(linum-relative-global-mode t)
(setq linum-relative-current-symbol "") ;; Shows the real number on the line's position

;; Word Count Mode
(setq wc-modeline-format "[Words: %tw, Chars: %tc]")

;; Web Mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.mustache\\'" . web-mode)
  ("\\.js?\\'" . web-mode)
  :config
  (setq web-mode-tag-auto-close-style t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-indentation t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t)
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'"))))

;; Dtrt-Indent
(require 'dtrt-indent)
(dtrt-indent-mode t)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

;; Anzu
(global-anzu-mode +1)

;; Hooks
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (toggle-frame-fullscreen)

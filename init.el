;; These are bindings for 26.0.50 or higher

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("SC" . "http://joseito.republika.pl/sunrise-commander/")
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (dired-narrow sunrise-commander web-mode sublime-themes git-timemachine restclient haskell-mode protobuf-mode counsel-dash ranger paradox org-babel-eval-in-repl org ox-gfm smart-mode-line autopair dtrt-indent evil-magit column-marker wc-mode evil-mc evil-commentary json-mode use-package dracula-theme badger-theme reykjavik-theme relative-line-numbers rainbow-mode highlight-thing ivy-bibtex org-ref writeroom-mode expand-region neotree evil ivy ample-theme auto-complete magit ensime counsel-projectile rainbow-delimiters)))
 '(paradox-github-token t)
 '(sml/theme (quote automatic)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq load-prefer-newer t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

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

;; Key-bindings that are some how not the same in Mac and Unix
(global-set-key (kbd "s-k") 'kill-current-buffer)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-z") 'undo-tree-undo)
(global-set-key (kbd "s-Z") 'undo-tree-redo)

;;(defun auto-indentation ()
;;  "Automatically sets the indentation to that of the previous line"
;;  (interactive)
;;  (newline)
;;  (indent-relative-maybe)
;;)
;;global-set-key (kbd "RET") 'auto-indentation)

(global-set-key (kbd "s-/") 'comment-region)
(global-set-key (kbd "s-?") 'uncomment-region)

;; Layout
(setq column-number-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(sml/setup)

(require 'dracula-theme)
(load-theme 'dracula t)

(let ((font-name "Inconsolata-17"))
  (set-default-font font-name)
  (set-frame-font font-name)
  )

;; Evil-mode
(require 'evil)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
;; Makes sure that wrapped lines will not move more than a single line
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "<down>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<up>") 'evil-previous-visual-line)
(evil-mode 1)

;; Ivy
(require 'ivy)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-s-<tab>") 'ivy-switch-buffer)
(ivy-mode 1)

;; Rainbow Delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Show-paren-mode
(show-paren-mode t)
(require 'autopair)
(autopair-global-mode);; automatically pairs braces and quotes

;; Auto-complete
(require 'auto-complete)
(ac-config-default)

;; Magit
(require 'magit)
(require 'evil-magit)

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
    ("M-<return>" . ensime-type-at-point)
  )
)

;; Counsel Projectile
(require 'counsel-projectile)
(global-set-key (kbd "s-f") 'counsel-projectile)

;; Neotree
(require 'neotree)
(global-set-key [f8] 'neotree-show)

(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
            )
          )

;; Expand Region
(require 'expand-region)
(global-set-key (kbd "s-2") 'er/expand-region)

;; Org Mode
(require 'org-ref)
(setq org-ref-completion-library 'org-ref-ivy-bibtex)

(use-package org
  :mode
  (("\\.org$" . org-mode))
  :config
  (add-hook 'org-mode-hook (lambda () (writeroom-mode 1)))
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-latex-caption-above nil) ;; Make sure that captions are below and not above
)

;; (use-package ox-gfm
;;   :init
;;   (when (boundp 'org-export-backends)
;;     (customize-set-variable 'org-export-backends
;;                             (cons 'gfm org-export-backends))))

(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; Write room
(require 'writeroom-mode)

;; Rainbow mode (for automatic coloring of html color codes (e.e. #f00))
(require 'rainbow-mode)
(rainbow-mode 1)

;; Relative line numbers
(require 'relative-line-numbers)
(relative-line-numbers-mode 1)

;; Smart Hungry Delete
;; (require 'smart-hungry-delete)
;; (define-key evil-insert-state-map (kbd "<backspace>") 'smart-hungry-delete-backward-char)
;; (define-key evil-insert-state-map (kbd "M-<backspace>") 'smart-hungry-delete-forward-char)

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
(dtrt-indent-mode 1)

;; Hooks
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (toggle-frame-fullscreen)

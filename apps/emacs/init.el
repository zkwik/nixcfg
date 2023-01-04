;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-
;;; Code

;; Use-package is ...
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;;
;;; Functions

(defun emacs-path (path)
  (expand-file-name path user-emacs-directory))

;;
;;; Global settings

(load (emacs-path "settings"))

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta
        mac-command-modifier 'meta)
  ;;(mac-auto-operator-composition-mode)
  (customize-set-variable 'native-comp-driver-options '("-Wl,-w,-no_compact_unwind"))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

;; TAB cycle if there are only few candidates.
(setq completion-cycle-threshold 3)

;; Enable indentation+completion using the TAB key.
(setq tab-always-indent 'complete)

;; The use-package macro allows you to isolate package configuration in your
;; .emacs file in a way that is both performance-oriented and, well, tidy.
(use-package (require 'use-package))

;;
;;; Packages (sorted alphabetically)

(use-package all-the-icons)

(use-package avy
  :bind ("M-j" . avy-goto-char-timer)
  :config (avy-setup-default))

;; Consult provides practical commands based on the Emacs completion function
;; completion-read.  Completion allows you to quickly select an item from a list
;; of candidates.
(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)))

;; Corfu enhances completion at point with a small completion popup.
(use-package corfu
  :init (global-corfu-mode))

(use-package direnv
  :config (direnv-mode))

(use-package doom-modeline
  :config (doom-modeline-mode))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one))

;; A client for Language Server Protocol servers.
(use-package eglot)

;; Embark makes it easy to choose a command to run based on what is near point,
;; both during a minibuffer completion session (in a way familiar to Helm or
;; Counsel users) and in normal buffers.
(use-package embark
  :bind ("C-." . embark-act))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Helpful is an alternative to the built-in Emacs help that provides much more
;; contextual information.
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h x" . helpful-command)
         ("C-h k" . helpful-key)
         ("C-c C-d" . helpful-at-point)))

(use-package go-dlv :after go-mode)

(use-package go-mode
  :preface
  (defun project-find-go-module (dir)
    (when-let ((root (locate-dominating-file dir "go.mod")))
      (cons 'go-module root)))
  :init
  (cl-defmethod project-root ((project (head go-module)))
    (cdr project))
  :bind (:map go-mode-map
              ("C-c C-c C-f" . eglot-format-buffer)
              ("C-c C-c C-i" . eglot-code-action-organize-imports))
  :hook (project-find-functions . project-find-go-module))

(use-package magit)

;; Marginalia are marks or annotations placed at the margin of the page of a
;; book or in this case helpful colorful annotations placed at the margin of the
;; minibuffer for your completion candidates.
(use-package marginalia
  :config (marginalia-mode))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package nix-mode
  :mode "\\.nix\\'")

;; This package provides an orderless completion style that divides the pattern
;; into space-separated components, and matches candidates that match all of the
;; components in any order.
(use-package orderless)

(use-package protobuf-mode
  :mode "\\.proto\\'")

;; Vertico provides a performant and minimalistic vertical completion
;; UI based on the default completion system.
(use-package vertico
  :config (vertico-mode))

(use-package which-key
  :config (which-key-mode))

;; init.el ends here

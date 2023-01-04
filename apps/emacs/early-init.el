;;; early-init.el --- Emacs pre package.el & GUI configuration -*- lexical-binding: t; -*-
;;; Code:

(setq package-enable-at-startup nil)

;; Skipping a bunch of regular expression searching in the
;; file-name-handler-alist should improve start time.
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Emacs collects garbage every 800KB. This is overly aggressive on a modern
;; machine during our init. Temporarily turning it off should decrease startup
;; times. Resetting it afterward will ensure that normal operations don't suffer
;; from a large GC period.
(setq gc-cons-threshold most-positive-fixnum)

(defun gc-after-focus-change ()
  "Run GC when frame loses focus."
  (run-with-idle-timer
   5 nil
   (lambda () (unless (frame-focus-state) (garbage-collect)))))

(defun reset-init-values ()
  (run-with-idle-timer
   1 nil
   (lambda ()
     (setq file-name-handler-alist default-file-name-handler-alist
           gc-cons-threshold 100000000)
     (message "gc-cons-threshold & file-name-handler-alist restored")
     (when (boundp 'after-focus-change-function)
       (add-function :after after-focus-change-function #'gc-after-focus-change)))))

(with-eval-after-load 'use-package
  (add-hook 'after-init-hook 'reset-init-values))

;; Turning off these visual elements before UI initialization should speed up
;; init.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Implicitly resizing the Emacs frame adds to init time.  Fonts larger than the
;; system default can cause frame resizing, which adds to startup time.
(setq frame-inhibit-implied-resize t)

;; Set default font.
(push '(font . "Iosevka") default-frame-alist)
(set-face-attribute 'default nil :family "Iosevka" :height 130 :weight 'semi-light)

;;; early-init.el ends here

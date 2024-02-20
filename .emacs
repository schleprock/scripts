;;; Emacs Load Path
(setq load-path (cons "~/emacslibs" load-path))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(backward-delete-char-untabify-method 'all)
 '(case-fold-search t)
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(compilation-skip-visited t)
 '(compile-command
   "make -k DEBUG=1 BUILD_DOCS=0 NOINLINE=1 -j DEBUGGER_FLAG=-ggdb NOPURGE=1 DISTCC=1; xmessage \"makedebug64 completed\" -center -default okay")
 '(current-language-environment "UTF-8")
 '(default-frame-alist
    '((vertical-scroll-bars . right)
      (tool-bar-lines . 0)
      (menu-bar-lines . 1)
      (width . 80)
      (height . 65)))
 '(default-input-method "rfc1345")
 '(delete-selection-mode t nil (delsel))
 '(global-font-lock-mode t nil (font-lock))
 '(grep-command "grep -n -s ")
 '(grep-files-aliases
   '(("el" . "*.el")
     ("ch" . "*.[ch]")
     ("c" . "*.c")
     ("h" . "*.h")
     ("asm" . "*.[sS]")
     ("m" . "[Mm]akefile*")
     ("l" . "[Cc]hange[Ll]og*")
     ("tex" . "*.tex")
     ("texi" . "*.texi")
     ("cchh" . "*.cc *.hh")))
 '(grep-find-ignored-directories '("SCCS" "RCS" ".svn" ".git"))
 '(grep-find-ignored-files '(".#*" "*.o" "*~" "*.bin" "*.bak" "*.lnk" "*.dll"))
 '(gud-chdir-before-run nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist
   '((vertical-scroll-bars . right)
     (tool-bar-lines . 0)
     (menu-bar-lines . 1)
     (width . 80)
     (height . 65)))
 '(kill-whole-line t)
 '(next-error-highlight t)
 '(perl-indent-level 2)
 '(printer-name "_192_168_4_201")
 '(read-file-name-completion-ignore-case t)
 '(scroll-bar-mode 'right)
 '(scroll-conservatively 5000)
 '(scroll-margin 2)
 '(select-enable-clipboard t)
 '(show-paren-mode t nil (paren))
 '(special-display-frame-alist '((height . 65) (width . 80) (unsplittable . t)))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((undo discard-info))))

(global-set-key [f1] 'undo) ;; Undo
(global-set-key [f2] 'kill-region) ;; cut
(global-set-key [f3] 'copy-region-as-kill) ;; Copy
(global-set-key [f4] 'clipboard-yank) ;; Paste
(global-set-key [f5] 'find-file) ;; C-x C-f
(global-set-key [f6] 'other-window)
(global-set-key [f7] 'save-buffer) ;; C-x C-s

(global-set-key "\C-v" 'clipboard-yank) ;; paste
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-cc" 'compile)
;; remap search to C-f to look the same as windows
(global-set-key (kbd "C-f") 'isearch-forward) 
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

;; This adds additional extensions which indicate files normally
;; handled by cc-mode.
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.hh$" . c++-mode)
        ("\\.yy$" . c++-mode)
		("\\.c$"  . c-mode)
		("\\.h$"  . c-mode)
		("\\.v$"  . verilog-mode)
		("\\.vh$"  . verilog-mode)
		("\\.g$"  . verilog-mode)
		("\\.mk$"  . makefile-mode)
		("\\.make$"  . makefile-mode)
		("\\.script$" . shell-script-mode)
		("\\.scr$" . shell-script-mode))
	      auto-mode-alist))
;; Tell cc-mode not to check for old-style (K&R) function declarations.
;; This speeds up indenting a lot.
(setq c-recognize-knr-p nil)

;;(setq frame-title-format (concat invocation-name "@" system-name ": %b %+%+ %f"))
(setq frame-title-format (concat "%b %+%+ %f  @" system-name ))
;;; ********************
;;; resize-minibuffer-mode makes the minibuffer automatically
;;; resize as necessary when it's too small to hold its contents.

(when (fboundp 'resize-minibuffer-mode)
  (resize-minibuffer-mode)
  (setq resize-minibuffer-window-exactly nil))


; HACK till gnome and ediff play nice.
;
;; (defun kaw-ediff-hook ()
;;   (defconst ediff-control-frame-parameters
;;     (list 
;;      '(name . "Ediff")
;;      ;;'(unsplittable . t)
;;      '(minibuffer . nil)
;;      '(user-position . t)		; Emacs only
;;      '(vertical-scroll-bars . nil)	; Emacs only
;;      '(scrollbar-width . 0)		; XEmacs only
;;      '(menu-bar-lines . 0)		; Emacs only
;;      ;; don't lower and auto-raise
;;      '(auto-lower . nil)
;;      '(auto-raise . t)
;;      ;; this blocks queries from  window manager as to where to put
;;      ;; ediff's control frame. we put the frame outside the display,
;;      ;; so the initial frame won't jump all over the screen
;;      (cons 'top	 100)
;;      (cons 'left 100)
;;      )
;;     "Frame parameters for displaying Ediff Control Panel.
;; Do not specify width and height here. These are computed automatically.")
;;   )

;; (add-hook 'ediff-before-setup-control-frame-hook 'kaw-ediff-hook)


;; If the little GUD source line marker '>' is hard to follow, add the
;; following to your .emacs:

;; ;;-------------------------------------------------------------
;; ;; Add color to the current GUD line
;; ;;
 (defvar gud-overlay
   (let* ((ov (make-overlay (point-min) (point-min))))
     (overlay-put ov 'face 'secondary-selection)
     ov)
   "Overlay variable for GUD highlighting.")

 (defadvice gud-display-line (after my-gud-highlight act)
   "Highlight current line."
   (let* ((ov gud-overlay)
          (bf (gud-find-file true-file)))
     (save-excursion
       (set-buffer bf)
       (move-overlay ov (line-beginning-position) (line-end-position) (current-buffer)))))

 (defun gud-kill-buffer ()
   (if (eq major-mode 'gud-mode)
        (delete-overlay gud-overlay)))

 (add-hook 'kill-buffer-hook 'gud-kill-buffer)
;; ;;-------------------------------------------------------------

;; Have fun,
;; -Stephan
    
;;; Code:

;(require 'xcscope)
;(require 'psvn)

(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons  '("\\.dv\\'" . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons  '("\\.g\\'" . verilog-mode) auto-mode-alist))
(tool-bar-mode 0)

(autoload 'modelica-mode "modelica-mode" "Modelica Editing Mode" t)
(setq auto-mode-alist (cons '("\.mo$" . modelica-mode) auto-mode-alist))

(setq special-display-buffer-names
	  '("*grep*" "*compilation*"))

(add-hook 'c-mode-hook
          (function (lambda ()
                      (setq c-basic-offset 2)
                      (c-set-offset 'substatement-open 0))))

(setq c++-mode-hook c-mode-hook) ;; not sure this is needed
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(global-set-key [mouse-2] 'mouse-yank-at-click)
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)
(setq column-number-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Arial" :foundry "Mono" :slant normal :weight normal :height 98 :width normal)))))
(ido-mode t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.


;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; turn off the symbolic link stuff that emacs creates for open files
(setq create-lockfiles nil)

(setq large-file-warning-threshold nil)

;; move the ediff control panel to the right so it's not right on top of
;; emacs window
(setq ediff-narrow-control-frame-leftward-shift -25)
(setq ediff-control-frame-upward-shift -10)

;; turn off question about open symbolic link to version control
(setq vc-follow-symlinks nil)

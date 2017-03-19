;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Misc EMACS parameters
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq default-tab-width       2
	  transient-mark-mode     t
	  inhibit-startup-message t
	  completion-auto-help    nil
	  default-major-mode     'text-mode)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(defun my-php-indentation () "CL is the best"
	   (c-set-style "whitesmith")

(c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist-intro-after-paren)
(c-set-offset 'arglist-cont 	     'c-lineup-arglist-intro-after-paren)
(c-set-offset 'arglist-close		 'c-lineup-arglist-intro-after-paren)
(c-set-offset 'arglist-intro		 'c-lineup-arglist-intro-after-paren)

	   (setq
		c-basic-offset 				2
		c-auto-newline				nil
		)

;;	   (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)
;;	   (c-set-offset 'arglist-cont 	     'c-lineup-arglist)
;;	   (c-set-offset 'arglist-close		 'c-lineup-arglist)
;;	   (c-set-offset 'arglist-intro		 'c-lineup-arglist-intro-after-paren)
;;	   (setq c-offsets-alists (cons '(arglist-cont-nonempty c-lineup-argcont) c-offsets-alist))
	   )

;; check out https://github.com/andreas-roehler/ar-php-mode

(require 'php-mode)

(setq auto-mode-alist (cons '("\\.php$"   . php-mode)        auto-mode-alist))
(setq auto-mode-alist (cons '("\\.htm$"   . php-mode)        auto-mode-alist))
(setq auto-mode-alist (cons '(".emacs$"   . emacs-lisp-mode) auto-mode-alist))

(autoload 'multi-mode 
  "multi-mode" 
  "Allowing multiple major modes in a buffer." 
  t) 

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
	  '(("php"    . "\\.html?\\'")
		("blade"  . "\\.blade\\."))
	  )

;; (setq auto-mode-alist (cons '("\\.htm$" . htmlphp-mode) auto-mode-alist)) 
;; (setq auto-mode-alist (cons '("\\.html$" . htmlphp-mode) auto-mode-alist)) 

;; (setq load-path (list
;;				 "."
;;				 "/usr/local/lib/emacs/19.29/lisp"
;;				 "/usr/local/lib/emacs/site-lisp"
;;				 (expand-file-name "H:/emacs/misc")
;;				 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Extensions I want completion to ignore
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq completion-ignored-extensions 
	  (append '(".xxx" ".sym" ".bak" ".hsc")
			  completion-ignored-extensions))


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Enable/disable functions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'eval-expression 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;		   Stuff for C-mode and C++-mode
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; https://davidha.wordpress.com/2009/05/15/emacs-cc-modes-built-in-styles-gallery/
;; (add-hook 'php-mode-common-hook '(lambda () (c-set-style "whitesmith")))
;; (add-hook 'php-mode-hook '(lambda () (php-enable-drupal-coding-style)))

 (add-hook 'php-mode-common-hook '(lambda () (my-php-indentation)))
 (add-hook 'php-mode-hook '(lambda () (my-php-indentation)))

;;(add-hook 'c-mode-common-hook '(lambda () (c-set-style "whitesmith")))

;; (setq c-mode-hook	'(lambda () (setq comment-column 44)  (tab4)  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Functions (big ones should live in cltools.el)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun untabify-buffer () "untabify the whole buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun selective-display () "Set selective display to current column"
  (interactive)
  (set-selective-display (current-column)))

(defun fill-even ()
  "Fill paragraph with even right-margin"
  (interactive)
  (fill-paragraph-properly 1))

(defun scroll-up-1-line (&optional count)
  (interactive "p")
  (scroll-up count))

(defun scroll-down-1-line (&optional count)
  (interactive "p")
  (scroll-down count))

(defun next-buffer ()
  (interactive)
  (switch-to-buffer (car (reverse (buffer-list)))))

(defun tab2 () 
  "Setup Emacs for a tab-width of 4. Local tab-stop-lists would be nice..."
  (interactive)
  (setq tab-stop-list
	'(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72
		76 80 84 88 92 96 100 104 108 112 116 120 124 128))
  (setq tab-width 2)
)
(defun tab4 () 
  "Setup Emacs for a tab-width of 4. Local tab-stop-lists would be nice..."
  (interactive)
  (setq tab-stop-list
	'(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72
		76 80 84 88 92 96 100 104 108 112 116 120 124 128))
  (setq tab-width 4)
)
(defun tab8 () 
  "Setup Emacs for a tab-width of 8. Local tab-stop-lists would be nice..."
  (interactive)
  (setq tab-stop-list
	'(8 16 24 32 40 48 56 64 72 80 88 96 104 112 120 128))
  (setq tab-width 8)
)

(defun save-tabs () "Insert the current tab-stop-list as a local variable"
  "Save the current tab-stops"
  (interactive)
  (save-excursion
	(goto-char (point-max))
	(insert "\f\n")
	(insert "Local Variables:\n")
	(insert "tab-stop-list: ")
	(insert "\nEnd:\n")))

(defun goto-matching-paren (&optional count)
  "Go to the matching parenthesis."
  (interactive "p")
  (cond ((looking-at "[\(\[{]")
		 (forward-sexp 1)
		 (backward-char))
		((looking-at "[])}]")
		 (forward-char)
		 (backward-sexp 1))
		((looking-at ">")
		 (forward-char)
		 (search-backward "<"))
		((looking-at "<")
		 (forward-char)
		 (search-forward ">"))
		(t (error "Not a paren"))))

(defun toggle-linewrap()
	"Toggle linewrap on a per-buffer basis."
	(interactive)
	(setq truncate-lines (not truncate-lines))
	(redraw-display))

(defun toggle-case-fold-search ()
  (interactive)
  (if case-fold-search
      (progn
        (setq case-fold-search nil)
        (message "Search is case sensitive."))
    (setq case-fold-search t)
    (message "Search is case insensitive.")))

(defun toggle-case-replace ()
  (interactive)
  (if case-replace
      (progn
        (setq case-replace nil)
        (message "Replace is case sensitive."))
    (setq case-replace t)
    (message "Replace is case insensitive.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Hang LISP on miscellaneous hooks
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq view-hook '(lambda () (tab4)))
(setq suspend-resume-hook '(lambda () (message "Welcome back...")))
;; (setq text-mode-hook  '(lambda () (auto-fill-mode 1) (tab4)))
(setq emacs-lisp-mode-hook '(tab4))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Autoload stuff from my toolbox
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'fill-comment-block      "cltools"  nil t)
(autoload 'replace-regexp-region   "cltools"  nil t)
(autoload 'replace-string-region   "cltools"  nil t)
(autoload 'sum-column			   "cltools"  nil t)
(autoload 'prefix-region		   "cltools"  nil t)
(autoload 'suffix-region	       "cltools"  nil t)
(autoload 'fill-paragraph-properly "cltools"  nil t)
(autoload 'toggle-screen-width	   "cltools"  nil t)
(autoload 'find-regexp-files       "cltools"  nil t)
(autoload 'latin1-to-swedish       "cltools"  nil t)
(autoload 'swedish-to-latin1       "cltools"  nil t)
(autoload 'resync-files		       "cltools"  nil t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	   Autoload miscellaneous stuff 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (autoload 'server-start			"gnuserv"	 ""		  t)
(autoload 'taglist				"taglist"	 ""		  t)
(autoload 'blackbox				"blackbox"	 "Blackbox game"		  t)
(autoload 'gomoku				"gomoku"	 "The GOMOKU game"		  t)
(autoload 'sokoban				"sokoban"	 "The SOKOBAN game"		  t)
(autoload 'unshar				"unshar"	 "Unshar stuff"			 t)
(autoload 'insert-patterned     "repeat"     "" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	ISO 8859 support
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'iso-insert)
;; (require 'iso-syntax)
;; (require 'iso-keys)

;; (setq 8bit-font "7x14")
;; (setq 7bit-font "7x14")

;; (if (string= (getenv "TERM") "ampex219")
;;  	(7bit-mode)
;;   (8bit-mode))
;; (easy-8bit-keys)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;				Things to do on startup
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Some more loadups
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'delsel)            ;; delete selection on insert

;; -- version control stuff --
;; (load "vc-hooks.elc")
;; (load "vc.elc")

;; (load "~/.environment" t t)

;; (require 'vc-status)
;; (require 'safe-vc)

;; (require 'keymap-help)
;;(require 'show-temp-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;	Miscellaneous key bondage
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-s"		'isearch-forward-regexp )
(global-set-key "\C-r"		'isearch-backward-regexp)
;;(global-set-key "\C-\\"	'help-command)
;;(global-set-key "\C-h"	'delete-backward-char)
(global-set-key "\C-z"		'scroll-up-1-line)
(global-set-key "\C-_"		'suspend-emacs)
;;(global-set-key "\M-s"   	'isearch-forward-regexp)
;;(global-set-key "\C-d"	'delete-backward-char)

(define-key esc-map "+"	'template-command	   )
;;(define-key esc-map "\C-s" 	'center-line)
(define-key esc-map " "	   	'set-mark-command)
(define-key esc-map "z"	   	'scroll-down-1-line)
;;(define-key esc-map "s"	   	'isearch-forward-regexp)
(define-key esc-map "%"	   	'query-replace-regexp)
(define-key esc-map "i"	   	'indent-region)

;;(define-key ctl-x-map "$"	 'selective-display)
;;(define-key ctl-x-map "s"	 'save-buffer)
(define-key ctl-x-map "g"	 'goto-line)
(define-key ctl-x-map "\C-g" 'what-page)
;;(define-key ctl-x-map "\C-b" 'buffer-menu)
;;(define-key ctl-x-map "\C-b" 'electric-buffer-list)
(define-key ctl-x-map "\C-e" 'compile)
(define-key ctl-x-map "\C-n" 'next-error)

(global-set-key "\C-ca" 'abbrev-mode) 
(global-set-key "\C-cj" 'fill-comment-block)
(global-set-key "\C-c\C-j" 'fill-paragraph-properly)
(global-set-key "\C-ct" 'toggle-linewrap)
(global-set-key "\C-cw" 'toggle-screen-width)  
(global-set-key "\C-cf" 'auto-fill-mode)
(global-set-key "\C-cy" 'yow)
(global-set-key "\C-cn" 'next-buffer)
(global-set-key "\C-co" 'overwrite-mode)
(global-set-key "\C-c%" 'goto-matching-paren)
(global-set-key "\C-c\C-b" 'bury-buffer)
;;(global-set-key "\C-cb" 'boss-has-come)
(global-set-key "\C-c\C-m" 'menu-bar-mode)
(global-set-key "\C-c\C-s" 'toggle-scroll-bar)
(global-set-key "\C-cs" 'toggle-case-fold-search)
;;(global-set-key "\C-c\C-c" 'exit-recursive-edit)
(global-set-key "\C-cr" 'toggle-case-replace)
(define-key help-map "p" 'describe-perl-symbol) 

(setq load-path (cons (expand-file-name "~/emacs/w3") load-path))
(autoload 'w3-preview-this-buffer "w3" "WWW Previewer" t)
(autoload 'w3-follow-url-at-point "w3" "Find document at pt" t)
(autoload 'w3 "w3" "WWW Browser" t)
(autoload 'w3-open-local "w3" "Open local file for WWW browsing" t)
(autoload 'w3-fetch "w3" "Open remote file for WWW browsing" t)
(autoload 'w3-use-hotlist "w3" "Use shortcuts to view WWW docs" t)
(autoload 'gopher-dispatch-object "gopher" "Fetch gopher dir" t)


;; (garbage-collect)

(setq backup-inhibited t)

(put 'downcase-region 'disabled nil)

;; (global-font-lock-mode 1)

(defun use-utf8 () (interactive) 
  (set-language-environment "UTF-8")
  (setq locale-coding-system 'utf-8)
;;  (set-keyboard-coding-system 'iso-latin-1)
;;  (set-terminal-coding-system 'iso-latin-1)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)
)

(defun use-latin1 () (interactive) 
  (set-language-environment "Latin-1")
  (setq locale-coding-system 'iso-latin-1)
  (set-keyboard-coding-system 'iso-latin-1)
  (set-terminal-coding-system 'iso-latin-1)
  (set-selection-coding-system 'iso-latin-1)
  (prefer-coding-system 'iso-latin-1)
  (set-buffer-file-coding-system 'iso-latin-1)
)

(defun use-latin1-in-utf8 () (interactive) 
  (set-keyboard-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)

  (set-language-environment "Latin-1")
  (setq locale-coding-system 'iso-latin-1)
  (set-buffer-file-coding-system 'iso-latin-1)
  (prefer-coding-system 'iso-latin-1)
)

(defun use-utf8-in-latin1 () (interactive) 
  (set-keyboard-coding-system 'iso-latin-1)
  (set-terminal-coding-system 'iso-latin-1)
  (set-selection-coding-system 'iso-latin-1)

  (set-language-environment "UTF-8")
  (setq locale-coding-system 'iso-latin-1)
  (prefer-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)
)

(defun use-utf8-in-utf8 () (interactive) 
  (set-keyboard-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)

  (set-language-environment "UTF-8")
  (setq locale-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-buffer-file-coding-system 'utf-8)
)

(defun use-latin1-in-latin1 () (interactive) 
  (set-keyboard-coding-system 'iso-latin-1)
  (set-terminal-coding-system 'iso-latin-1)
  (set-selection-coding-system 'iso-latin-1)

  (set-language-environment "Latin-1")
  (setq locale-coding-system 'iso-latin-1)
  (prefer-coding-system 'latin-1)
  (set-buffer-file-coding-system 'latin-1)
)

(use-utf8-in-utf8)

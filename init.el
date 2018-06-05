;;start package.el with emacs
(require 'package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "/usr/include/c++/5")))
 '(helm-source-names-using-follow (quote ("Search at ~/.emacs.d/")))
 '(make-backup-files nil)
 '(mouse-wheel-progressive-speed nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (ace-window anzu auctex avy cnfonts company company-c-headers company-irony company-irony-c-headers company-jedi company-quickhelp elpy flycheck flycheck-irony google-c-style helm helm-ag helm-core helm-projectile helm-swoop iedit imenu-list irony ivy magit move-text multiple-cursors projectile pyenv smartparens swiper switch-window undo-tree use-package virtualenvwrapper volatile-highlights which-key yasnippet yasnippet-snippets ztree zzz-to-char)))
 '(tool-bar-mode nil)
 '(transient-mark-mode (quote (only . t))))

;; about-emacs
(setq inhibit-startup-message t)

;; font
;; (set-default-font "deja vu sans mono 11")
(set-default-font "Monospace" 11)
;; cnfonts
(set-face-attribute
 'default nil
 :font (font-spec :name "-PfEd-DejaVu Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 11.0))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-MS  -Microsoft YaHei-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 11.5)))

(setq gc-cons-percentage 10000000)
(setq scroll-conservatively most-positive-fixnum) ;; scroll one line

;; chinese 
;; (setq default-input-method "quanpin")
;; C-\ to switch

;; show parentheses match
;; (show-paren-mode t)
(add-hook 'prog-mode-hook 'show-paren-mode)
;; M-( insert-parentheses

;; C-k kill whole line
(setq kill-whole-line t)

;; whitespace-mode

;; (setq debug-on-error t) toggle-debug-on-error
;; 
;; initialize package.el
(package-initialize)

;; display what changed
(volatile-highlights-mode t)

;; smart parentheses
;; (smartparens-global-mode t)

;; cedet
;; (load-file (concat user-emacs-directory "cedet/cedet-devel-load.el"))
;; (load-file (concat user-emacs-directory "cedet/contrib/cedet-contrib-load.el"))

(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode t)
(global-semantic-idle-scheduler-mode t)
;; (setq semantic-idle-scheduler-idle-time 5)
;; M-x semantic-idle-summary-mode
(semantic-mode t)
;; (semantic-add-system-include "/usr/local/include")
;; (semantic-add-system-include "/usr/include/x86_64-linux-gnu/")
(define-key c-mode-base-map (kbd "M-RET") 'semantic-ia-fast-jump)
;; (define-key c-mode-base-map (kbd "C-c C-s") 'semantic-ia-show-summary)

;; start company with emacs
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
;; (global-set-key (kbd "<C-return>") 'company-complete)
(setq company-idle-delay 0.01)
(setq company-minimum-prefix-length 1)
;; case sensitive in plain text mode
(setq company-dabbrev-downcase nil) 
(setq company-backends (delete 'company-semantic company-backends))
(setq company-backends (delete 'company-clang company-backends))
;; (add-to-list 'company-backends 'company-c-headers)
;; (define-key company-active-map (kbd "<return>") nil)
;; (define-key company-active-map (kbd "<SPC>") nil)
;; (setq company-auto-complete nil)
(add-hook 'gud-mode-hook (lambda() (company-mode -1)))

;; don't use it in init
;; (add-to-list 'company-c-headers-path-system "")

;; python company
(add-hook 'inferior-python-mode-hook (lambda() (company-mode -1)))
;; (defun my/python-mode-hook ()
;;  (setq jedi:complete-on-dot t)
;;   (setq jedi:environment-root "jedi")
;;   (setq jedi:environment-virtualenv
;; 	(append python-environment-virtualenv
;; 		'("--python" "python3")))
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)
;; (setq company-backends (delete 'elpy-company-backend company-backends))
;; (add-hook 'python-mode-hook 'my/python-mode-hook)
;; (add-hook 'python-mode-hook 'highlight-indentation-current-column-mode)

;; elpy
;; (require 'elpy)
(elpy-enable)
(setq elpy-rpc-python-command "python3")
(setq elpy-rpc-backend "jedi")
(setq eldoc-idle-delay 2)
;; C-c C-d to show doc
;; (company-quickhelp-mode)
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")
;; use ipython, 
;; (setq python-shell-interpreter "ipython3"
;;       python-shell-interpreter-args " -i --simple-prompt --pprint")
;; C-c C-c to eval current buffer, C-c C-z to switch shell, C-RET to eval current line
;; virtualenvwrapper (not pyvenv)
;; (setq venv-location '("~/workspace/lf" "~/workspace/venv"))
;; venv-workon, venv-deactivate, use gud or 'M-x pdb then python -m pdb' 


;; start yasnippet with emacs
(require 'yasnippet)
;; (yas-global-mode t)
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'prog-mode-hook 'linum-mode)

;; iedit
(require 'iedit)
;; see C-h f iedit-mode

;; anzu
(global-anzu-mode)
;; anzu-query-replace etc...

;; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; (setq c-default-style "linux"
;;       c-basic-offset 4)

;;ggtags
;; (require 'ggtags)
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
;; 	      (ggtags-mode t))))

;;helm
(require 'helm-config)
;; (helm-mode t)
;; helm-mini M-a to mark all, M-D (M-S-d) to kill marked buffer
;; pattern: *[!,exclude]mode buffername @search , C-s to list search result
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c C-f") 'helm-find) ;; C-u to change dir, suspend/resume update with C-!
;; prefix l helm-locate 
;; prefix i helm-semantic-or-imenu
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
;; helm-command-prefix b to helm-resume
;; make <tab> work normally, like C-j in helm.
;; (define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
;; add <tab> helm-execute-persistent-action in helm-map helm-core/helm.el
;; C-i to select actions
(with-eval-after-load "helm"
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))
(with-eval-after-load "helm-regexp"
  (define-key helm-command-map (kbd "o") 'helm-occur))
;; <tab> is a single key, TAB is C-i
(setq helm-split-window-in-side-p t
      helm-echo-input-in-header-line nil)

;;helm-ag
(global-set-key (kbd "C-c r") 'helm-do-ag) ;; C-u to specify file type
(global-set-key (kbd "C-c b") 'helm-do-ag-buffers)
;; (global-set-key (kbd "C-c f") 'helm-do-ag-this-file)
(global-set-key (kbd "C-c s") 'helm-swoop) ;; swiper is alternative
(setq helm-swoop-pre-input-function (lambda () ""))
;; helm-multi-swoop
;; M-i during isearch to invok swoop ;; M-i during swoop to swoop all buffer
;; C-u 'num' helm-swoop to search multiline
;; (global-set-key (kbd "C-c p") 'helm-do-ag-project-root)
;; (follow-mode t)
;; (setq-default helm-follow-mode-persistent t)
;; helm-follow-mode C-c C-f

;; projectile
(projectile-mode)
(helm-projectile-on)
;; C-c p p helm-projectile-switch-project, C-d open dired, M-D delete
;; C-c p f helm-projectile-find-file
;; C-c p F helm-projectile-find-file-in-known-projects
;; C-c p d helm-projectile-find-dir
;; C-c p e helm-projectile-recentf
;; C-c p a helm-projectile-find-other-file, same name different extensions
;; e.g. (add-to-list 'projectile-other-file-alist '("html", "js"))
;; C-c p l projectile-find-file-in-directory
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
;; C-c p i projectile-invalidate-cache, use it after add a new file
;; (add-to-list 'projectile-globally-ignored-files "*.pyc")
(add-to-list 'projectile-globally-ignored-file-suffixes "pyc")
;; (add-to-list 'projectile-globally-ignored-directories "app")
(with-eval-after-load "helm-projectile"
  (define-key projectile-mode-map (kbd "C-c p s") 'helm-projectile-ag))
;; C-c p s s helm-projectile-ag

;; avy
;; (global-set-key (kbd "C-;") 'avy-goto-char)
;;(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g") 'avy-goto-word-1)
;; (global-set-key (kbd "M-g e") 'avy-goto-word-0)
;; zzz-to-char substitute of zap-to-char
(global-set-key (kbd "M-z") #'zzz-up-to-char)

;; switch window
;; (setq switch-window-shortcut-style 'qwerty)
;; (global-set-key (kbd "C-x o") 'switch-window)
;; (setq switch-window--auto-resize-window t)
;; (switch-window-mouse-mode)

;; use ace-window now
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-scope 'frame)
;; C-u M-o or M-o m to swap window
;; C-u C-u M-o or M-o x to delete window

(winner-mode t)
;; follow-mode to read doc

;; undo tree
;; C-x u
(global-undo-tree-mode t)

;; complete file name
;; (fset 'my-complete-file-name
;;       (make-hippie-expand-function '(try-complete-file-name-partially
;; 				     try-complete-file-name)))
;; (global-set-key (kbd "M-/") 'my-complete-file-name)

;; fold code
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
;; (global-set-key (kbd "C-c C-f") 'hs-toggle-hiding)

;; sr-speedbar
;; (setq sr-speedbar-width 16)
;; (setq sr-speedbar-right-side nil)
;; (setq sr-speedbar-auto-refresh nil) ;; (sr-speedbar-refresh-turn-off)
;; (setq speedbar-use-images nil) ; use text for buttons
;; (setq speedbar-show-unknown-files t) ;; show all files


;; shell
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; M-x ansi-term
;; M-x become C-x M-x in ansi-term, C-x is the prefix
;; use C-c C-j to switch to term-char-mode, C-c C-k to switch to term-line-mode
;; or use ctrl/shift-insert to copy/paste

(setq explicit-shell-file-name "/bin/bash")  ;; no use
(setq term-ansi-default-program "/bin/bash") ;; no use too
;; (setq term-buffer-maximum-size 4096) ;; default 2048
;; (term-pager-enable)


;; multi-term
;; (defun term-send-f ()
;;   "Send ESC in term mode."
;;   (interactive)
;;   (term-send-raw-string "^[O1;2P"))
;; (setq term-bind-key-alist
;;       (list (cons "<f2>" 'term-send-f)
;; 	    (cons "<f3>" 'term-send-raw-meta)
;; 	    (cons "C-;" 'term-send-raw-meta)
;; 	    (cons "<escape>" 'term-send-raw-meta)
;; 	    (cons "M-p" 'term-send-raw-meta)
;; 	    (cons "M-n" 'term-send-raw-meta)))


;; tab bar
;; (global-set-key [M-left] 'tabbar-backward-tab)
;; (global-set-key [M-right] 'tabbar-forward-tab)

;; window size
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;; C-x 0 to combine window


;; M-x revert-buffer

;; Compilation
;; (global-set-key (kbd "<f5>") (lambda ()
;;                                (interactive)
;;                                (setq-local compilation-read-command nil)
;;                                (call-interactively 'compile)))
(add-hook 'c-mode-common-hook
          (lambda ()
	    (set (make-local-variable 'compile-command)
		 (concat "g++ -g -Wall -std=c++11 " buffer-file-name))))
(define-key c++-mode-map [f5] 'recompile)

;; gdb
(setq gdb-many-windows t
      gdb-show-main t)
;; gdb-display-gdb-buffer : other GDb buffers are also killed when kill this buffer
;; gdb-display-locals-buffer
;; gdb-display-io-buffer ;; use it to input and output
;; gdb-display-stack-buffer
;; gdb-display-breakpoints-buffer ...
;; replace display by frame to get frame

(setq compilation-finish-functions 'compile-autoclose)
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
	 (bury-buffer "*compilation*")
	 (winner-undo)
	 (message "Build successful."))
	(t                                                                    
	 (message "Compilation exited abnormally: %s" string))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; irony-mode
;; see C-h v company-backends
;; (add-to-list 'company-backends '(company-irony :with company-dabbrev-code))
(add-to-list 'company-backends 'company-irony)
(add-hook 'c-mode-common-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony-c-headers)
;; (add-hook 'after-save-hook (lambda (irony-get-type)))  ;; fix irony bug
(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq irony-additional-clang-options '("-std=c++11"))
	    (flycheck-mode t)))
	    ;; (setq flycheck-idle-change-delay 6
	    ;; 	  flycheck-check-syntax-automatically
	    ;; 	  '(idle-change))))

;; M-x irony-server-kill to kill irony-server
;; (with-eval-after-load "flycheck"
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;; change window orientation
(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))
(global-set-key (kbd "C-c t") 'window-toggle-split-direction)


;; move-text. M-up, M-down to move line or region
(move-text-default-bindings)

;; multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; C-' to hidden all lines without cursor, C-' again to unhidden
;; set-rectangular-region-anchor, mc/insert-numbers ...
;; C-x spc (rectangle-mark-mode)

(global-set-key (kbd "C-<tab>") 'mode-line-other-buffer)

;; tramp
;; (custom-set-variables
;;  '(tramp-default-method "ssh")
;;  '(tramp-default-user "root")
;;  '(tramp-default-host "lf.goldeneye.org.cn"))

;; imenu
;; (imenu-list-minor-mode)
;; (global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
;; (setq imenu-list-auto-resize t)

;; which-key
;; (which-key-mode)

;; ztree
;; ztree-dir ztree-diff

;; C-j eval-print-last-sexp, lisp-interaction-mode


;; M-x list-processes to see processes

;; C-x C-r to open read only
;; C-x C-q toggle read only
;; dired: C-c C-c to finish edit

;; C-x C-+/-/0... 


;; f3 start macro f4 to end or call, insert f3 after f3 to insert a counter 0 1 2 3 4...

;; M-x profiler-start RET RET
;; M-x profiler-report


;; ediff ?
;; a, b, ra, rb


;; narrow-to-region and widen
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; downcase-word (M-l) upcase-word (M-u)

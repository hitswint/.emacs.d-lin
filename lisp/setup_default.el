;;; Setup
;; ===================Setup=====================
(transient-mark-mode t)
(auto-image-file-mode t)
(global-hl-line-mode t)
(fringe-mode)
(menu-bar-mode -1)
(delete-selection-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(mouse-avoidance-mode 'animate)
(global-display-line-numbers-mode -1)
(setq use-short-answers t)
(setq fill-column 80)
(setq visible-bell t)
(setq mouse-yank-at-point t)
(setq kill-ring-max 200)
(setq next-line-add-newlines t)
(setq make-pointer-invisible t)
(setq diary-file "~/org/journal.org.gpg")
(setq disabled-command-function nil)
(setq undo-no-redo t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq-default indent-tabs-mode nil)
(setq auto-window-vscroll nil)          ;解决C-n卡顿
(setq save-interprogram-paste-before-kill t)
(setq require-final-newline t)
(setq load-prefer-newer t)
(setq shift-select-mode nil)
(setq select-active-regions 'only)
(setq epg-pinentry-mode 'loopback)      ;使用minibuffer输入密码
(setq history-delete-duplicates t)
(setq delete-by-moving-to-trash t)
(setq confirm-kill-processes nil)
(setq display-line-numbers-type t)
(setq trash-directory "~/.Trash")
(setq tramp-default-method "ssh")
(setq tramp-ssh-controlmaster-options   ;默认设置导致helm启动慢
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(setq remote-file-name-inhibit-locks t)
(setq remote-file-name-inhibit-cache nil)
(setq native-comp-jit-compilation nil)
(setq frame-title-format "emacs@%b")
(setq frame-inhibit-implied-resize t)
(setq idle-update-delay 1.0)
(setq fast-but-imprecise-scrolling t)
(setq redisplay-skip-fontification-on-input t)
(setq inhibit-compacting-font-caches t)
(setq highlight-nonselected-windows nil)
(setq read-process-output-max (* 64 1024))
(setq-default bidi-display-reordering nil)
(setq bidi-inhibit-bpa t
      long-line-threshold 1000
      large-hscroll-threshold 1000
      syntax-wholeline-max 1000)
(setq auto-mode-case-fold nil)
(setq command-line-x-option-alist nil)
(setq ffap-machine-p-known 'reject)
(setq find-file-visit-truename nil)
;; (setq debug-on-error t)
;; (setq-default cursor-in-non-selected-windows nil)
(unless noninteractive
  (advice-add #'display-startup-echo-area-message :override #'ignore)
  (setq inhibit-startup-screen t
        inhibit-startup-echo-area-message user-login-name
        inhibit-default-init t
        initial-major-mode 'fundamental-mode
        initial-scratch-message nil))
;; ===================Setup=====================
;;; Keybindings
;; ================Keybindings==================
(global-set-key (kbd "C-x C-M-j") 'speedbar-get-focus)
(global-set-key (kbd "M-,") 'delete-other-windows)
(global-set-key (kbd "M-.") 'delete-window)
(global-set-key (kbd "M-s M-,") 'split-window-vertically)
(global-set-key (kbd "M-s M-.") 'split-window-horizontally)
(global-set-key (kbd "M-o M-o") 'run-octave)
(global-set-key (kbd "M-o M-O") 'matlab-shell)
(global-set-key (kbd "M-o M-c") 'calendar)
(global-set-key (kbd "C-x C-l") 'reposition-window)
(global-set-key (kbd "C-;") 'set-mark-command)
(global-set-key (kbd "C-x r ;") 'rectangle-mark-mode)
(global-set-key [f9] 'menu-bar-mode)
(global-set-key (kbd "S-SPC") 'just-one-space)
(global-set-key (kbd "<S-return>") 'join-line)
(global-set-key (kbd "M-s SPC") 'delete-horizontal-space)
(global-set-key (kbd "C-SPC") nil)
(global-set-key (kbd "<C-M-backspace>") 'backward-kill-sexp)
(define-key lisp-interaction-mode-map (kbd "C-j") nil)
(global-set-key (kbd "<C-prior>") 'previous-user-buffer)
(global-set-key (kbd "<C-next>") 'next-user-buffer)
(global-set-key (kbd "C-x M-d") 'delete-current-buffer-file)
(global-set-key (kbd "C-x M-r") 'rename-current-buffer-file)
(global-set-key (kbd "C-q") 'swint-kill-buffer)
(global-set-key (kbd "M-c") 'toggle-letter-case)
(global-set-key (kbd "M-Q") 'compact-uncompact-block)
(global-set-key (kbd "C-w") 'kill-line-or-region)
(global-set-key (kbd "C-x C-i") 'cleanup-buffer)
(global-set-key (kbd "M-g g") 'display-line-numbers-mode)
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(global-set-key (kbd "M-s M-;") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-a") 'smart-beginning-of-line)
(global-set-key (kbd "M-s -") 'jcs-dashify)
(global-set-key (kbd "M-s _") 'jcs-dashify-underline)
(global-set-key (kbd "C-j") 'open-line-or-new-line-dep-pos)
(global-set-key (kbd "M-m") 'pop-to-mark-command)
(global-set-key (kbd "M-M") 'swint-unpop-to-mark-command)
(global-set-key (kbd "M-s =") #'(lambda () (interactive)
                                  (if swint-diff-region-tag
                                      (diff-region-compare-with-b)
                                    (diff-region-tag-selected-as-a))))
(global-set-key (kbd "C-x RET RET") #'(lambda () (interactive)
                                        (revert-buffer-with-coding-system 'utf-8)))
(global-set-key (kbd "C-x M-s") 'save-buffer-with-dos2unix)
(global-set-key (kbd "C-x e") 'replace-last-sexp)
(global-set-key (kbd "C-x C-y") 'xsel-paste-primary)
(global-set-key (kbd "C-+") 'swint-count-words-region)
(global-set-key (kbd "M-g o") 'swint-dired-converter)
(global-set-key (kbd "M-s M-e") 'show-some-last-messages)
(global-set-key (kbd "M-s e") 'switch-to-messages-buffer)
(global-set-key (kbd "M-s M-d") 'swint-sdcv-to-tip)
(global-set-key (kbd "M-s M-D") 'swint-sdcv-to-buffer)
(global-set-key (kbd "M-s D") 'swint-online-to-buffer)
(global-set-key (kbd "M-s O") 'occur)
(global-set-key (kbd "M-s M-m") 'eval-math-with-calc)
(global-set-key (kbd "M-s m") #'(lambda () (interactive) (eval-math-with-calc t)))
(global-set-key (kbd "M-o RET") 'urxvt-default-directory)
(global-set-key (kbd "M-o t") 'thunar-open-default-directory)
(global-set-key (kbd "C-S-s") 'swint-pinyin-search-forward)
(global-set-key (kbd "C-S-r") 'swint-pinyin-search-backward)
(global-set-key (kbd "C-x C-<tab>") #'(lambda () (interactive) (if (active-minibuffer-window) (switch-to-minibuffer)
                                                                 (call-interactively 'switch-to-buffer))))
(global-set-key (kbd "C-\\") 'toggle-window-split)
(global-set-key (kbd "C-x O") 'rotate-windows)
(global-set-key (kbd "M-g M-s") 'swint-screenshot)
(global-set-key (kbd "M-g M-S") #'(lambda () (interactive) (swint-screenshot t)))
(global-set-key (kbd "M-g s") 'swint-insert-screenshot)
(global-set-key (kbd "M-g S") #'(lambda () (interactive) (swint-insert-screenshot t)))
(global-set-key (kbd "M-g v") 'iimage-mode)
(global-set-key (kbd "M-g ,") #'(lambda (&optional arg) (interactive "P") (swint-dired-rsync/unison "pull")))
(global-set-key (kbd "M-g .") #'(lambda (&optional arg) (interactive "P") (swint-dired-rsync/unison "push")))
(global-set-key (kbd "M-g /") #'(lambda (&optional arg) (interactive "P") (swint-dired-rsync/unison "sync")))
(global-set-key (kbd "M-g M-,") #'(lambda () (interactive) (swint-webdav-sync "down")))
(global-set-key (kbd "M-g M-.") #'(lambda () (interactive) (swint-webdav-sync "up")))
(global-set-key (kbd "M-g M-/") #'(lambda () (interactive) (swint-webdav-sync "bi")))
(global-set-key (kbd "M-g C-,") #'(lambda () (interactive) (swint-onedrive-sync "down")))
(global-set-key (kbd "M-g C-.") #'(lambda () (interactive) (swint-onedrive-sync "up")))
(global-set-key (kbd "M-g C-/") #'(lambda () (interactive) (swint-onedrive-sync "bi")))
(global-set-key (kbd "M-g <") #'(lambda () (interactive) (swint-bypy-sync)))
(global-set-key (kbd "M-g >") #'(lambda () (interactive) (swint-bypy-sync t)))
(global-set-key (kbd "M-g M-?") 'swint-unison-sync-backups)
(global-set-key (kbd "M-g i") nil)
(global-set-key (kbd "M-g i d") 'insert-date)
(global-set-key (kbd "M-g i t") 'insert-time)
(global-set-key (kbd "C-M-q") 'swint-undo-kill-buffer)
(global-set-key (kbd "C-/") 'undo)
(global-set-key (kbd "C-M-/") 'undo-redo)
(define-key emacs-lisp-mode-map "\e\C-q" nil)
(define-key lisp-interaction-mode-map "\e\C-q" nil)
(define-key prog-mode-map "\e\C-q" nil)
(global-set-key [f11] 'my-fullscreen)
(global-set-key (kbd "C-z") #'(lambda () (interactive) (unless (display-graphic-p) (suspend-frame))))
;; ================Keybindings==================
(provide 'setup_default)

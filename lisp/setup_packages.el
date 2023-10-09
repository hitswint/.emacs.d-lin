;;; abbrev
;; ====================abbrev======================
(use-package abbrev
  :diminish abbrev-mode
  :config
  (setq-default abbrev-mode t)
  (setq save-abbrevs t)
  ;; 编辑abbrev-table：
  ;; C-x a g 将当前位置之前词语，全局加入abbrev
  ;; C-x a + 将当前位置之前词语，当前mode下加入abbrev
  ;; define-global-abbrev/define-mode-abbrev自定义abbrev
  (setq abbrev-file-name "~/.emacs.d/abbrev_defs")
  (when (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file)))
;; ====================abbrev======================
;;; server
;; ====================server======================
(use-package server
  :config
  (unless (or (and (fboundp 'daemonp) (daemonp))
              (server-running-p))
    (server-start)))
;; ====================server======================
;;; recentf
;; ====================recentf=====================
(use-package recentf
  :commands recentf-mode
  :config
  (use-package recentf-ext)
  (recentf-mode 1)
  (setq recentf-max-saved-items 100)
  (setq recentf-exclude
        (list "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$" "^/var/folders/.+$" "^/mnt.+")))
;; ====================recentf=====================
;;; multiple-cursors
;; ================multiple-cursors================
(use-package multiple-cursors
  :defer 2
  :config
  (setq mc/always-run-for-all t
        mc/insert-numbers-default 1)
  (add-to-list 'mc/unsupported-minor-modes 'auto-mark-mode)
  (add-to-list 'mc/unsupported-minor-modes 'highlight-indentation-current-column-mode)
  (bind-key "C-M-," 'mc/mark-previous-like-this)
  (bind-key "C-M-." 'mc/mark-next-like-this)
  (bind-key "<C-M-mouse-1>" 'mc/add-cursor-on-click)
  (bind-key "C-x C-M-;" 'mc/mark-all-like-this)
  (bind-key "C-x C-M-," 'mc/mark-all-like-this-beg)
  (bind-key "C-x C-M-." 'mc/mark-all-like-this-end)
  (bind-key "C-x C-M-/" 'mc/edit-lines)
  (bind-key "C-x C-M-'" 'mc/mark-more-like-this-extended)
  (smartrep-define-key global-map "C-x" '(("M-m" . mc/mark-pop)))
  (add-to-list 'mc--default-cmds-to-run-once 'mc/mark-all-like-this-beg)
  (add-to-list 'mc--default-cmds-to-run-once 'mc/mark-all-like-this-end)
  (defun mc/mark-all-like-this-beg ()
    (interactive)
    (if (region-active-p)
        (save-restriction
          (widen)
          (narrow-to-region (point-min) (region-end))
          (mc/mark-all-like-this))
      (save-excursion
        (set-mark (point-min)))
      (mc/edit-lines)))
  (defun mc/mark-all-like-this-end ()
    (interactive)
    (if (region-active-p)
        (save-restriction
          (widen)
          (narrow-to-region (region-beginning) (point-max))
          (mc/mark-all-like-this))
      (save-excursion
        (set-mark (point-max)))
      (mc/edit-lines)))
  (advice-add 'mc/edit-lines :before #'(lambda (&optional arg) (unless (region-active-p)
                                                                 (set-mark (point-max))
                                                                 (goto-char (point-min)))))
  (define-key mc/keymap (kbd "C-`") 'mc-hide-unmatched-lines-mode)
  (define-key mc/keymap (kbd "C-'") 'mc/repeat-command)
  (define-key mc/keymap (kbd "C-M-<") 'mc/unmark-previous-like-this)
  (define-key mc/keymap (kbd "C-M->") 'mc/unmark-next-like-this)
  (define-key mc/keymap (kbd "M-<") 'mc/skip-to-previous-like-this)
  (define-key mc/keymap (kbd "M->") 'mc/skip-to-next-like-this)
  (define-key mc/keymap (kbd "M-'") 'mc/insert-numbers)
  (define-key mc/keymap (kbd "M-\"") 'mc/insert-letters)
  (define-key mc/keymap (kbd "M-/") 'mc/sort-regions)
  (define-key mc/keymap (kbd "M-?") 'mc/reverse-regions))
;; ================multiple-cursors================
;;; expand-region
;; =================expand-region==================
(use-package expand-region
  :bind (("C-M-;" . er/expand-region)
         ("C-M-:" . er/contract-region))
  :config
  ;; 在octave中使用会导致emacs假死，原因是octave的function中必须带有end
  (setq expand-region-contract-fast-key "C-:")
  (setq expand-region-reset-fast-key "C-;")
  ;; 默认把er/save-mode-excursion设置为er/save-org-mode-excursion，导致org-mode中使用卡顿
  (er/enable-mode-expansions 'org-mode #'(lambda ()
                                           (setq-local er/save-mode-excursion nil))))
;; =================expand-region==================
;;; auto-mark
;; ==================auto-mark=====================
(use-package auto-mark
  :load-path "site-lisp/auto-mark/"
  :config
  (setq auto-mark-command-class-alist
        '((goto-line . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)
          (goto-last-change . jump)
          (goto-last-change-reverse . jump)))
  ;; 会导致(void-variable last-command-char)错误
  ;; (setq auto-mark-command-classifiers
  ;;       (list (lambda (command)
  ;;               (if (and (eq command 'self-insert-command)
  ;;                        (eq last-command-char ? ))
  ;;                   'ignore))))
  (defun auto-mark-mode-maybe/after ()
    (when (> (buffer-size) (* 1024 1024))
      (auto-mark-mode -1)))
  (advice-add 'auto-mark-mode-maybe :after #'auto-mark-mode-maybe/after)
  (global-auto-mark-mode 1))
;; ==================auto-mark=====================
;;; visible-mark
;; ================visible-mark====================
(use-package visible-mark
  :config
  (global-visible-mark-mode 1)
  (setq visible-mark-max 2)
  (defface swint-visible-mark-face-1
    '((t (:background "#666666" :foreground "white")))
    "Face for the mark."
    :group 'visible-mark)
  (setq visible-mark-faces '(visible-mark-active swint-visible-mark-face-1))
  (setq visible-mark-forward-max 2)
  (defface swint-visible-mark-forward-face-1
    '((t (:background "dark red" :foreground "white")))
    "Face for the mark."
    :group 'visible-mark)
  (defface swint-visible-mark-forward-face-2
    '((t (:background "dark green" :foreground "white")))
    "Face for the mark."
    :group 'visible-mark)
  (setq visible-mark-forward-faces '(swint-visible-mark-forward-face-1 swint-visible-mark-forward-face-2))
  (set-face-attribute 'visible-mark-active nil :background "maroon" :foreground "white"))
;; ================visible-mark====================
;;; God-mode
;; ====================God-mode====================
(use-package god-mode
  :diminish god-local-mode
  :bind ("<S-escape>" . god-local-mode)
  :config
  ;; (global-set-key (kbd "<escape>") 'god-mode-all)
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
                          'bar
                        'box)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)
  (add-to-list 'god-exempt-major-modes 'dired-mode))
;; ====================God-mode====================
;;; elisp-slime-nav
;; =================elisp-slime-nav================
(use-package help
  :commands help-command
  :config
  (define-key 'help-command (kbd "C-l") 'find-library)
  (define-key 'help-command (kbd "C-f") 'find-function)
  (define-key 'help-command (kbd "C-k") 'find-function-on-key)
  (define-key 'help-command (kbd "C-v") 'find-variable)
  (define-key 'help-command (char-to-string help-char) nil))
(use-package elisp-slime-nav
  :diminish elisp-slime-nav-mode
  :commands elisp-slime-nav-mode
  :init
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'elisp-slime-nav-mode))
  :config
  (setq eval-expression-debug-on-error nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-,") 'elisp-slime-nav-find-elisp-thing-at-point)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-.") 'pop-tag-mark)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-/") 'elisp-slime-nav-describe-elisp-thing-at-point)
  (define-key elisp-slime-nav-mode-map (kbd "M-.") nil)
  (define-key elisp-slime-nav-mode-map (kbd "M-,") nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d d") nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d C-d") nil))
;; =================elisp-slime-nav================
;;; drag stuff
;; ===================drag stuff===================
(use-package drag-stuff
  :diminish drag-stuff-mode
  :bind (("M-P" . drag-stuff-up)
         ("M-N" . drag-stuff-down)
         ("M-B" . drag-stuff-left)
         ("M-F" . drag-stuff-right))
  :config
  (drag-stuff-global-mode t)
  ;; 重新定义drag-stuff-define-keys函数，取消"M+方向键"的快捷键
  (defun drag-stuff-define-keys/override ()
    "Defines keys for `drag-stuff-mode'."
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'up) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'down) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'left) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'right) nil))
  (advice-add 'drag-stuff-define-keys :override #'drag-stuff-define-keys/override))
;; ===================drag stuff===================
;;; popup-kill-ring
;; ================popup-kill-ring=================
(use-package popup-kill-ring
  :bind ("M-Y" . popup-kill-ring)
  :config
  (setq popup-kill-ring-interactive-insert nil)
  (setq popup-kill-ring-popup-width 30)
  (setq popup-kill-ring-popup-margin-left 0)
  (setq popup-kill-ring-popup-margin-right 0)
  (setq popup-kill-ring-timeout 0.5))
;; ================popup-kill-ring=================
;;; pos-tip
;; ===================pos-tip======================
(use-package pos-tip
  :commands pos-tip-show
  :config
  ;; 使用Gtk+ tooltip需配置x-gtk-use-system-tooltips，修改~/.emacs.d/gtkrc配置字体
  (setq x-gtk-use-system-tooltips t))
;; ===================pos-tip======================
;;; elmacro
;; ===================elmacro======================
(use-package elmacro
  ;; F3开始录制宏，再次F3插入计数，F4停止录制
  ;; elmacro-show-last-macro将宏转换为elisp
  :commands elmacro-mode)
;; ===================elmacro======================
;;; hungry-delete
;; ===================hungry-delete================
(use-package hungry-delete
  :diminish hungry-delete-mode
  :config
  (add-to-list 'hungry-delete-except-modes 'dired-mode)
  (add-to-list 'hungry-delete-except-modes 'ein:notebook-mode)
  (global-hungry-delete-mode))
;; ===================hungry-delete================
;;; fcitx
;; ======================fcitx=====================
(use-package fcitx
  :commands swint-fcitx-setup
  :init
  (if (and (fboundp 'daemonp) (daemonp))
      (add-hook 'after-make-frame-functions 'swint-fcitx-setup)
    (add-hook 'after-init-hook 'swint-fcitx-setup))
  :config
  ;; 需设置XMODIFIERS=@im=fcitx才能使用fcitx
  (defvar swint-fcitx-setup-done nil)
  (defun swint-fcitx-setup (&optional frame)
    (when (and (display-graphic-p frame) (not swint-fcitx-setup-done))
      (fcitx-prefix-keys-add "M-s" "M-g" "M-o" "M-O")
      (fcitx-aggressive-setup)
      (fcitx-isearch-turn-on)
      (fcitx--defun-maybe "sdcv")
      (setq swint-fcitx-setup-done t))))
;; ======================fcitx=====================
;;; aggressive-indent
;; ================aggressive-indent===============
(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :commands aggressive-indent-mode
  :init
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'aggressive-indent-mode))
  ;; :config
  ;; (add-to-list 'aggressive-indent-excluded-modes 'asm-mode)
  ;; (global-aggressive-indent-mode 1)
  )
;; ================aggressive-indent===============
;;; clean-aindent-mode
;; ===============clean-aindent-mode===============
(use-package clean-aindent-mode
  :config
  (clean-aindent-mode t)
  (setq clean-aindent-is-simple-indent t)
  (define-key global-map (kbd "RET") 'newline-and-indent)
  (define-key clean-aindent-mode--keymap (kbd "M-DEL") #'(lambda ()
                                                           (interactive)
                                                           (if (or paredit-mode
                                                                   paredit-everywhere-mode)
                                                               (call-interactively 'swint-backward-kill-word)
                                                             (call-interactively 'clean-aindent--bsunindent)))))
;; RET：自动清除white space，光标停留在前一行indentation处
;; M-DEL：unindent，回到前一行indentation处
;; ===============clean-aindent-mode===============
;;; multifiles
;; ===================multifiles===================
(use-package multifiles
  :bind ("M-g m" . mf/mirror-region-in-multifile))
;; ===================multifiles===================
;;; ztree
;; =====================ztree======================
(use-package ztree-diff
  :bind ("M-g =" . ztree-diff))
;; =====================ztree======================
;;; which-key
;; ====================which-key===================
(use-package which-key
  :diminish which-key-mode
  :defer 2
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-description-order)
  (bind-key "M-s x" 'which-key-show-major-mode)
  (bind-key "M-s X" 'which-key-show-minor-mode-keymap)
  ;; 默认C-h启用describe-prefix-bindings
  (defun which-key-show-standard-help/override (&optional _)
    (interactive)
    (let ((which-key-inhibit t))
      (which-key--hide-popup-ignore-command)
      (helm-descbinds (kbd (which-key--current-key-string)))))
  (advice-add 'which-key-show-standard-help :override
              #'which-key-show-standard-help/override))
;; ====================which-key===================
;;; backup
;; ======================backup====================
(use-package git-timemachine
  :bind ("M-s M-b" . git-timemachine))
(use-package backup-walker
  :bind ("M-s M-B" . backup-walker-start))
;; ======================backup====================
;;; visual-regexp
;; ===================visual-regexp================
(use-package visual-regexp
  :bind (("M-s r" . vr/query-replace)
         ("M-s R" . vr/replace)
         ("M-s C-;" . vr/mc-mark)))
;; ===================visual-regexp================
;;; vlf
;; =======================vlf======================
(use-package vlf
  :bind (:map dired-mode-map
              ("C-c v" . dired-vlf))
  :init
  ;; Enable vlf when opening files bigger than 100MB.
  (setq large-file-warning-threshold 100000000)
  :config
  (use-package vlf-setup)
  (smartrep-define-key vlf-mode-map ""
    '(("n" . vlf-next-batch)
      ("p" . vlf-prev-batch)))
  (setq vlf-application 'dont-ask)
  (add-to-list 'vlf-forbidden-modes-list 'pdf-view-mode))
;; =======================vlf======================
;;; easy-kill
;; =====================easy-kill==================
(use-package easy-kill
  :commands gui-select-text-with-copyq
  :bind ("M-w" . kill-ring-save)
  :init
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark)
  (global-set-key (kbd "M-W") #'(lambda () (interactive)
                                  (let ((interprogram-cut-function 'gui-select-text-with-copyq))
                                    (call-interactively 'easy-kill))))
  (global-set-key (kbd "C-S-w") #'(lambda () (interactive)
                                    (let ((interprogram-cut-function 'gui-select-text-with-copyq))
                                      (call-interactively 'kill-line-or-region))))
  :config
  (defun gui-select-text-with-copyq (text)
    (if (string-empty-p (shell-command-to-string "pgrep -x copyq"))
        (gui-select-text text)
      (let ((inhibit-message t)
            (message-log-max nil))
        (write-region text nil "/tmp/eaclipboard")
        (shell-command (format "copyq copy - < /tmp/eaclipboard && copyq add - < /tmp/eaclipboard")))))
  ;; M-w ?: help 查看M-w prefix快捷键
  (define-key easy-kill-base-map (kbd "C-w") 'easy-kill-region)
  (define-key easy-kill-base-map (kbd ",") 'easy-kill-shrink)
  (define-key easy-kill-base-map (kbd ".") 'easy-kill-expand))
;; =====================easy-kill==================
;;; bm
;; =======================bm=======================
(use-package bm
  :commands (bm-toggle
             bm-previous
             bm-next)
  :init
  (smartrep-define-key global-map "C-x"
    '(("C-'" . bm-toggle)
      ("'" . bm-previous)
      ("\"" . bm-next)))
  (setq bm-restore-repository-on-load t)
  :config
  (setq-default bm-buffer-persistence t)
  (add-hook 'find-file-hook 'bm-buffer-restore)
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'kill-emacs-hook #'(lambda ()
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (setq bm-cycle-all-buffers nil)
  (setq bm-highlight-style 'bm-highlight-only-fringe)
  (bm-buffer-restore-all))
;; =======================bm=======================
;;; helm-bm
;; ====================helm-bm=====================
(use-package helm-bm
  :bind ("C-M-'" . helm-bm)
  :config
  (defun helm-bm-action-switch-to-buffer/override (candidate)
    "Switch to buffer of CANDIDATE."
    (helm-bm-with-candidate candidates (helm-switch-persp/buffer bufname)
                            (goto-char (point-min))
                            (forward-line (1- lineno))))
  (advice-add 'helm-bm-action-switch-to-buffer :override
              #'helm-bm-action-switch-to-buffer/override))
;; ====================helm-bm=====================
;;; operate-on-number
;; ================operate-on-number===============
;; 两种操作方式：C-= 计算符号，支持C-u前缀数字；C-= = 依次确定计算符号和数字
(use-package operate-on-number
  :commands (apply-operation-to-number-at-point
             operate-on-number-at-point)
  :init
  (smartrep-define-key global-map "C-="
    '(("+" . apply-operation-to-number-at-point)
      ("-" . apply-operation-to-number-at-point)
      ("*" . apply-operation-to-number-at-point)
      ("/" . apply-operation-to-number-at-point)
      ("\\" . apply-operation-to-number-at-point)
      ("^" . apply-operation-to-number-at-point)
      ("<" . apply-operation-to-number-at-point)
      (">" . apply-operation-to-number-at-point)
      ("#" . apply-operation-to-number-at-point)
      ("%" . apply-operation-to-number-at-point)
      ("=" . operate-on-number-at-point))))
;; ================operate-on-number===============
;;; goto-last-change
;; =================goto-last-change===============
(use-package goto-chg
  :bind ("M-?" . swint-goto-last-change)
  :config
  (defun swint-goto-last-change ()
    (interactive)
    (condition-case nil
        (progn (call-interactively 'goto-last-change)
               (setq last-command 'goto-last-change))
      (error
       (message "Buffer has not been changed")))
    ;; (invoke-prefix-command)
    ;; (initialize-event-loop)
    ;; The form (condition-case ERR FORM (quit QUIT-HANDLER))
    ;; is there to catch C-g key presses and make sure that
    ;; finalization code is run.
    (condition-case e
        (smartrep-read-event-loop
         '(("M-?" . goto-last-change)
           ("M-/" . goto-last-change-reverse)))
      (quit nil))
    ;; (finalize-event-loop)
    ))
;; =================goto-last-change===============
;;; Proced
;; =====================Proced=====================
(use-package proced
  :commands proced-process-attributes
  :bind ("M-o M-r" . proced)
  :config
  (define-key proced-mode-map (kbd "q") 'kill-buffer-and-window)
  ;; Proced自动更新，10秒
  (defun proced-settings ()
    (proced-toggle-auto-update 1))
  (add-hook 'proced-mode-hook 'proced-settings))
;; =====================Proced=====================
;;; vimish-fold
;; ==================vimish-fold===================
(use-package vimish-fold
  :bind (("C-x C-`" . vimish-fold)
         ("C-x C-~" . vimish-fold-delete)))
;; ==================vimish-fold===================
;;; clipmon
;; ====================clipmon=====================
(use-package clipmon
  :bind (("M-g M-w" . clipmon-mode)
         ("M-g M-W" . clipmon-autoinsert-toggle))
  :config
  ;; (clipmon-mode 1)
  (advice-add 'clipmon-mode-start :after #'(lambda () (xclipmon-mode 0)))
  (advice-add 'clipmon-mode-stop :after #'(lambda () (xclipmon-mode 1)))
  ;; 原clipmon--get-selection中文乱码，另有时yank内容不更新。修改后clipmon-autoinsert失效
  (advice-add 'clipmon--get-selection :override #'(lambda () (current-kill 0)))
  (defvar xclipmon-process nil)
  (define-minor-mode xclipmon-mode
    "Toggle xclipmon.sh - watch system clipboard, add changes to kill ring."
    :global t
    :lighter ""
    (if (not xclipmon-mode)
        (ignore-errors (kill-process xclipmon-process))
      (setq xclipmon-process (start-process-shell-command
                              "xclipmon" "*xclipmon*" "xclipmon.sh"))
      (set-process-query-on-exit-flag xclipmon-process nil))))
;; ====================clipmon=====================
;;; volatile-highlights
;; ==============volatile-highlights===============
(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))
;; ==============volatile-highlights===============
;;; quickrun
;; ===================quickrun=====================
(use-package quickrun
  :bind (("M-s q" . swint-quickrun)
         ("M-s Q" . quickrun-shell))
  :config
  (defun swint-quickrun ()
    (interactive)
    (if mark-active
        (call-interactively 'quickrun-region)
      (call-interactively 'quickrun))))
;; ===================quickrun=====================
;;; highlight-symbol
;; ================highlight-symbol================
(use-package highlight-symbol
  :commands (highlight-symbol-prev
             highlight-symbol-next
             highlight-symbol-at-point
             highlight-symbol-get-symbol)
  :init
  (smartrep-define-key global-map "M-s"
    '(("," . highlight-symbol-prev)
      ("." . highlight-symbol-next)
      (";" . highlight-symbol-at-point)))
  :config
  (setq highlight-symbol-foreground-color "gray30"))
;; ================highlight-symbol================
;;; auto-highlight-symbol
;; =============auto-highlight-symbol==============
(use-package auto-highlight-symbol
  :diminish auto-highlight-symbol-mode
  :defer 2
  :config
  (global-auto-highlight-symbol-mode t)
  (setq ahs-overlay-priority 0)
  (set-face-attribute 'ahs-face nil
                      :foreground "white"
                      :background "DarkMagenta")
  (set-face-attribute 'ahs-plugin-whole-buffer-face nil
                      :foreground "white"
                      :background "DarkBlue")
  (add-to-list 'ahs-modes 'octave-mode)
  (add-to-list 'ahs-modes 'gnuplot-mode)
  (add-to-list 'ahs-modes 'graphviz-dot-mode)
  (add-to-list 'ahs-modes 'arduino-mode)
  ;; C-u for whole buffer.
  (define-key auto-highlight-symbol-mode-map (kbd "M-s /") 'ahs-edit-mode)
  (define-key auto-highlight-symbol-mode-map (kbd "M-<left>") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "M-<right>") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "M-S-<left>") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "M-S-<right>") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "M--") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "C-x C-'") nil)
  (define-key auto-highlight-symbol-mode-map (kbd "C-x C-a") nil))
;; =============auto-highlight-symbol==============
;;; dumb-jump
;; ==================dumb-jump=====================
(use-package dumb-jump
  :commands (dumb-jump-go
             dumb-jump-back
             dumb-jump-quick-look)
  :init
  (smartrep-define-key global-map "C-x"
    '(("," . dumb-jump-go)
      ("." . dumb-jump-back)
      ("/" . dumb-jump-quick-look))))
;; ==================dumb-jump=====================
;;; diff-hl
;; ===================diff-hl======================
(use-package diff-hl
  :defer 2
  :config
  ;; 默认快捷键以C-x v为前缀
  (smartrep-define-key global-map "C-x v"
    '((";" . diff-hl-mark-hunk)
      ("," . diff-hl-previous-hunk)
      ("." . diff-hl-next-hunk)
      ("/" . diff-hl-revert-hunk)))
  (global-diff-hl-mode)
  ;; 无需保存即显示diff，造成大文件卡顿
  ;; (diff-hl-flydiff-mode)
  ;; 只有当前diff-hl-dired-update进程结束后才启动新进程
  (defun diff-hl-dired-update/around (orig-fn &rest args)
    (unless (and (buffer-live-p diff-hl-dired-process-buffer)
                 (get-buffer-process diff-hl-dired-process-buffer))
      (apply orig-fn args)))
  (advice-add 'diff-hl-dired-update :around #'diff-hl-dired-update/around)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  ;; 在已有dired-mode中开启diff-hl-dired-mode
  (dolist (buf (cl-remove-if-not (lambda (x)
                                   (equal (buffer-mode x) 'dired-mode))
                                 (buffer-list)))
    (with-current-buffer buf
      (diff-hl-dired-mode)
      (diff-hl-dired-update)))
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (set-face-attribute 'diff-hl-insert nil
                      :foreground "gray"
                      :background "dark green")
  (set-face-attribute 'diff-hl-delete nil
                      :foreground "gray"
                      :background "dark red")
  (set-face-attribute 'diff-hl-change nil
                      :foreground "gray"
                      :background "dark blue"))
;; ===================diff-hl======================
;;; evil-nerd-commenter
;; =============evil-nerd-commenter================
(use-package evil-nerd-commenter
  :bind ("M-:" . evilnc-comment-or-uncomment-lines))
;; =============evil-nerd-commenter================
;;; markdown-mode
;; =================markdown-mode==================
(use-package markdown-mode
  :delight "Md"
  :commands (markdown-mode
             gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (add-hook 'markdown-mode-hook 'markdown-display-inline-images)
  :config
  (setq markdown-open-image-command "feh.sh"
        markdown-max-image-size '(640 . 480))
  (smartrep-define-key markdown-mode-map "M-s"
    '(("p" . markdown-outline-previous)
      ("n" . markdown-outline-next)
      ("u" . markdown-outline-up)
      ("b" . markdown-outline-previous-same-level)
      ("f" . markdown-outline-next-same-level)))
  (define-key markdown-mode-map (kbd "C-c C-x C-M-v") 'markdown-display-inline-images)
  (define-key markdown-mode-map (kbd "C-c C-x C-v") 'markdown-toggle-inline-images)
  (define-key markdown-mode-map (kbd "C-c j") 'markdown-follow-thing-at-point))
;; =================markdown-mode==================
;;; highlight-indentation
;; =============highlight-indentation==============
(use-package highlight-indentation
  :diminish (highlight-indentation-mode
             highlight-indentation-current-column-mode))
;; =============highlight-indentation==============
;;; rainbow-mode
;; =================rainbow-mode===================
(use-package rainbow-mode
  :diminish rainbow-mode
  :commands rainbow-mode
  :init
  (dolist (hook '(web-mode-hook
                  css-mode-hook
                  html-mode-hook
                  emacs-lisp-mode-hook))
    (add-hook hook 'rainbow-mode)))
;; =================rainbow-mode===================
;;; pass
;; =====================pass=======================
(use-package pass
  :bind ("C-x P" . pass)
  :config
  (setq pass-show-keybindings nil))
(use-package helm-pass
  :bind ("C-x p" . helm-pass))
;; =====================pass=======================
;;; sudo
;; =====================sudo=======================
(use-package sudo-edit
  ;; 需新建~/.ssh/sockets文件夹
  :commands (sudo-edit sudo-dired)
  :config
  ;; M(dired-do-chmod)改变权限；O(dired-do-chown)改变owner；G(dired-do-chgrp)改变group
  (defun sudo-dired ()
    (interactive)
    (require 'tramp)
    (let ((dir (expand-file-name default-directory)))
      (if (string-match "^/sudo:" dir)
          (user-error "Already in sudo")
        (dired (concat "/sudo::" dir))))))
;; =====================sudo=======================
;;; gnuplot
;; ====================gnuplot=====================
(use-package gnuplot-mode
  :delight "Gp"
  :mode ("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)
  :config
  (define-key gnuplot-mode-map (kbd "C-c C-v") 'swint-open-output-file))
;; ====================gnuplot=====================
;;; graphviz-dot-mode
;; ================graphviz-dot-mode===============
(use-package graphviz-dot-mode
  :delight "Gv"
  :mode ("\\.dot\\'" . graphviz-dot-mode)
  :config
  (define-key graphviz-dot-mode-map (kbd "C-c C-c") 'compile)
  (define-key graphviz-dot-mode-map (kbd "C-c C-v") 'swint-open-output-file))
;; ================graphviz-dot-mode===============
;;; ido
;; ======================ido=======================
(use-package ido
  :defer t
  :config
  (setq ido-auto-merge-delay-time 0.7
        ido-default-buffer-method 'raise-frame
        ido-default-file-method 'raise-frame
        ido-enable-flex-matching t
        ido-file-extensions-order nil
        ido-use-virtual-buffers nil)
  (custom-set-faces '(ido-first-match ((t (:foreground "yellow" :weight bold))))
                    '(ido-only-match ((((class color)) (:foreground "DeepSkyBlue1" :weight bold))))
                    '(ido-subdir ((t (:foreground "green")))))
  (setq ido-ignore-buffers '("\\`Enjoy\\ Music\\'" "\\`\\*Inferior\\ Octave\\*\\'" "\\`\\*Ibuffer\\*\\'" "\\`\\*MATLAB\\*\\'" "\\`\\*shell\\*\\'" "\\`\\*calculator\\*\\'" "\\`\\*Calendar\\*\\'" "\\`\\*Compile\\=Log\\*\\'" "\\`\\*Completions\\*\\'" "\\`\\*sdcv\\*\\'" "\\`\\*scratch\\*\\'" "\\`\\*Process\\ List\\*\\'" "\\`\\*toc\\*\\'" "\\`\\*helm.*\\*\\'" "\\`\\*Helm.*\\*\\'" "\\`\\*buffer-selection\\*\\'" "\\`\\*Disabled\\ Command\\*\\'" "\\`\\*Mingus\\*\\'" "\\`\\*compilation\\*\\'" "\\`\\*Ido\\ Completions\\*\\'" "\\` " "\\`.english-words\\'")))
;; ======================ido=======================
;;; term-keys
;; ===================term-keys====================
(use-package term-keys
  :config
  (term-keys-mode t))
;; ===================term-keys====================
;; ===================yaml-mode====================
(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode))
;; ===================yaml-mode====================
;;; Auto-revert-mode
;; =================Auto-revert-mode===============
(use-package autorevert
  :diminish auto-revert-mode
  :defer 2
  :config
  (setq auto-revert-verbose nil)
  (setq auto-revert-interval 5)
  ;; 开启后导致修改文件后dired-mode中光标回到开始处
  (setq global-auto-revert-non-file-buffers t)
  ;; (setq global-auto-revert-ignore-modes '(dired-mode))
  (global-auto-revert-mode 1))
;; =================Auto-revert-mode===============
;;; academic-phrases
;; =================academic-phrases===============
(use-package academic-phrases
  :bind (("M-s a" . academic-phrases-by-section)
         ("M-s A" . academic-phrases)))
;; =================academic-phrases===============
;;; reftex
;; =====================reftex=====================
(use-package reftex
  :diminish reftex-mode
  :commands (reftex-mode reftex-label)
  :init
  (dolist (hook '(LaTeX-mode-hook org-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "C-c C-x r") 'reftex-mode))))
  :config
  ;; 交叉引用(reference)：C-c ( 添加label，C-c ) 引用label
  ;; 文献引用(citation)：C-c [ reftex-citation，C-c C-x [ org-reftex-citation
  (define-key reftex-mode-map (kbd "C-c C-x r") 'reftex-parse-all)
  (setq reftex-plug-into-AUCTeX t
        reftex-toc-split-windows-horizontally t
        reftex-toc-split-windows-fraction 0.2))
;; =====================reftex=====================
;;; annot
;; =====================annot======================
(use-package annot
  :load-path "repos/annot/src/"
  :bind (("M-g a a" . annot-edit/add)
         ("M-g a r" . annot-remove)
         ("M-g a i" . annot-add-image))
  :config
  (setq annot-directory "~/org/.annot")
  ;; 与volatile-highlights-mode有冲突
  (vhl/unload-extension 'kill)
  (vhl/unload-extension 'delete)
  (dolist (buf (cl-remove-if-not (lambda (x)
                                   (buffer-file-name x))
                                 (buffer-list)))
    (with-current-buffer buf (annot-load-annotations)))
  (define-key ctl-x-map "\C-a" nil)
  (define-key ctl-x-map "\C-r" 'swint-counsel-history)
  (define-key ctl-x-map "\C-i" 'cleanup-buffer))
;; =====================annot======================
;;; insert-translated-name
;; ============insert-translated-name==============
(use-package insert-translated-name
  :load-path "repos/insert-translated-name/"
  :bind (("M-g d" . insert-translated-name-replace)
         ("M-g D" . insert-translated-name-insert))
  :config
  (setq insert-translated-name-default-style "origin"))
;; ============insert-translated-name==============
;;; idf-mode
;; ==================idf-mode======================
(use-package idf-mode
  :load-path "site-lisp/idf-mode/"
  :delight "Idf"
  :mode ("\\.[iI][dD][fF]\\'" . idf-mode)
  :config
  (smartrep-define-key idf-mode-map "C-c"
    '(("p" . idf-prev-object)
      ("n" . idf-next-object)
      ("f" . idf-next-type)
      ("b" . idf-prev-type)))
  (define-key idf-mode-map (kbd "C-c C-,") 'idf-find-object-at-point)
  (define-key idf-mode-map (kbd "C-c C-.") 'pop-tag-mark)
  (define-key idf-mode-map (kbd "C-c C-/") 'idf-reference-object-at-point)
  (define-key idf-mode-map (kbd "C-c '") 'idf-show-ctable))
;; ==================idf-mode======================
;;; gnu-elpa-keyring-update
;; ==========gnu-elpa-keyring-update===============
(use-package gnu-elpa-keyring-update
  ;; 解决GPG公钥过期的问题
  ;; (setq package-check-signature nil) ;临时关闭验证，package-install安装
  :commands gnu-elpa-keyring-update)
;; ==========gnu-elpa-keyring-update===============
;;; rg
;; ===================rg===========================
(use-package rg
  :commands rg-run
  :bind ("M-s g" . rg-menu)
  :config
  (rg-enable-default-bindings (kbd "M-s g"))
  (setq rg-executable (executable-find "rga"))
  (setq rg-default-alias-fallback "everything")
  (define-key rg-mode-map (kbd "C-p") 'compilation-previous-error)
  (define-key rg-mode-map (kbd "C-n") 'compilation-next-error)
  (define-key rg-mode-map (kbd "M-p") 'rg-prev-file)
  (define-key rg-mode-map (kbd "M-n") 'rg-next-file)
  (define-key rg-mode-map (kbd "C-j") 'rg-result-open-externally)
  (defun rg-result-open-externally ()
    (interactive)
    (let ((file-name (or (save-excursion
                           (goto-char (line-beginning-position))
                           (when (re-search-forward "File:\\ \\(.*\\)" (line-end-position) t)
                             (match-string-no-properties 1)))
                         (save-excursion (when (re-search-backward "File:\\ \\(.*\\)" nil t)
                                           (match-string-no-properties 1))))))
      (if (string= (ignore-errors (downcase (file-name-extension file-name))) "pdf")
          (start-process "Shell" nil shell-file-name shell-command-switch
                         (concat "qpdfview --unique --search \"" (rg-search-pattern rg-cur-search)
                                 "\" \""
                                 file-name "#" (save-excursion
                                                 (goto-char (line-beginning-position))
                                                 (re-search-forward "Page\\ \\([[:digit:]]+\\):" nil t)
                                                 (match-string-no-properties 1))
                                 "\""))
        (dired-async-shell-command
         (expand-file-name file-name))))))
;; ===================rg===========================
;;; awesome-tab
;; ===============awesome-tab======================
(use-package awesome-tab
  :load-path "repos/awesome-tab/"
  :bind (("C-M-`" . awesome-tab-backward-tab)
         ("C-M-<tab>" . awesome-tab-forward-tab)
         ("C-M-S-<iso-lefttab>" . awesome-tab-move-current-tab-to-right)
         ("C-M-~" . awesome-tab-move-current-tab-to-left))
  :config
  (require 'helm)
  (require 'perspective)
  (bind-key "C-M-1" 'my-select-window)
  (bind-key "C-M-2" 'my-select-window)
  (bind-key "C-M-3" 'my-select-window)
  (bind-key "C-M-4" 'my-select-window)
  (bind-key "C-M-5" 'my-select-window)
  (bind-key "C-M-6" 'my-select-window)
  (bind-key "C-M-7" 'my-select-window)
  (define-key key-translation-map (kbd "C-M-^") (kbd "C-M-6"))
  (setq awesome-tab-display-line 'header-line
        awesome-tab-display-icon (display-graphic-p)
        awesome-tab-height 120
        awesome-tab-active-bar-height 20
        awesome-tab-dark-selected-foreground-color "white"
        awesome-tab-dark-active-bar-color "white"
        awesome-tab-cycle-scope 'tabs
        awesome-tab-auto-scroll-flag t
        awesome-tab-label-max-length 30)
  (defun awesome-tab-buffer-groups ()
    (list
     (cond
      ((memq major-mode '(magit-process-mode
                          magit-status-mode
                          magit-diff-mode
                          magit-log-mode
                          magit-file-mode
                          magit-blob-mode
                          magit-blame-mode
                          ))
       "Magit")
      (t
       (let ((proj-name (awesome-tab-get-group-name (current-buffer))))
         (if (equal proj-name awesome-tab-common-group-name)
             (if (member (current-buffer) (persp-buffers (persp-curr)))
                 (persp-name (persp-curr))
               awesome-tab-common-group-name)
           proj-name))))))
  (defun awesome-tab-hide-tab/around (fn x)
    (or (funcall fn x)
        (let ((name (format "%s" x)))
          (or (string-match-p (helm--concat-regexps helm-boring-buffer-regexp-list) name)
              (string-prefix-p "*scratch*" name)
              (string-prefix-p "*Messages*" name)))))
  (advice-add 'awesome-tab-hide-tab :around #'awesome-tab-hide-tab/around)
  (defun my-select-window ()
    (interactive)
    (interactive)
    (let* ((event last-command-event)
           (key (make-vector 1 event))
           (key-desc (key-description key))
           (tab-index (string-to-number
                       ;; Fix issue #81 that `last-command-event' is not keystroke.
                       (cond ((equal (length key-desc) 1)
                              key-desc)
                             (t
                              (car (nreverse (split-string key-desc "-"))))))))
      (awesome-tab-select-visible-nth-tab tab-index)))
  (awesome-tab-mode t))
;; ===============awesome-tab======================
;;; modelica-mode
;; ==============modelica-mode=====================
(use-package modelica-mode
  :delight "Mo"
  :mode ("\\.mo\\'" . modelica-mode)
  :config
  (define-key modelica-mode-map (kbd "C-M-{") 'modelica-backward-block)
  (define-key modelica-mode-map (kbd "C-M-}") 'modelica-forward-block)
  (define-key modelica-mode-map (kbd "M-n") nil)
  (define-key modelica-mode-map (kbd "M-p") nil))
;; ==============modelica-mode=====================
;;; vundo
;; ===================vundo========================
(use-package vundo
  :bind ("C-x u" . vundo))
;; ===================vundo========================
;;; auth-source
;; =================auth-source====================
(use-package auth-source
  :commands (get-auth-user get-auth-port get-auth-pass)
  :config
  (setq auth-sources '("~/.authinfo" "~/.authinfo.gpg" "~/.netrc"))
  (defun get-auth-user (host)
    (let ((hostentry (auth-source-search :host host)))
      (when hostentry
        (plist-get (car hostentry) :user))))
  (defun get-auth-port (host)
    (let ((hostentry (auth-source-search :host host)))
      (when hostentry
        (plist-get (car hostentry) :port))))
  (defun get-auth-pass (host)
    (let ((hostentry (auth-source-search :host host)))
      (when hostentry
        (funcall (plist-get (car hostentry) :secret))))))
;; =================auth-source====================
;;; pixel-scroll
;; ================pixel-scroll====================
(use-package pixel-scroll
  :config
  (pixel-scroll-precision-mode 1)
  (setq pixel-scroll-precision-interpolate-page t)
  ;; (defalias 'scroll-up-command 'pixel-scroll-interpolate-down)
  ;; (defalias 'scroll-down-command 'pixel-scroll-interpolate-up)
  (bind-key "M-v" 'pixel-scroll-interpolate-up)
  (bind-key "C-v" 'pixel-scroll-interpolate-down)
  (defun pixel-scroll-window-move-up (&optional arg)
    (interactive "p")
    (if (display-graphic-p)
        (pixel-scroll-precision-scroll-down (* 30 (or arg 1)))
      (call-interactively 'window-move-up)))
  (defun pixel-scroll-window-move-down (&optional arg)
    (interactive "p")
    (if (display-graphic-p)
        (pixel-scroll-precision-scroll-up (* 30 (or arg 1)))
      (call-interactively 'window-move-down)))
  (bind-key "M-p" 'pixel-scroll-window-move-down)
  (bind-key "M-n" 'pixel-scroll-window-move-up))
;; ================pixel-scroll====================
;;; font-lock
;; ==================font-lock=====================
(use-package font-core
  :config
  (global-font-lock-mode t))
(use-package font-lock
  :config
  (setq font-lock-maximum-decoration t))
(use-package jit-lock
  :custom
  (jit-lock-chunk-size 4096)
  (jit-lock-stealth-time 2)
  (jit-lock-defer-time 0.1))
;; ==================font-lock=====================
(provide 'setup_packages)

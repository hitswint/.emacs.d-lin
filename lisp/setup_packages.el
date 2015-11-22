;; =======================SERVER========================
(use-package server
  ;; Enabled at idle.
  :defer 2
  :config
  (unless (server-running-p)
    (server-start)))
;; =======================SERVER========================
;; ======================文件加密===================================
(use-package epa-file
  ;; Enabled at idle.
  :defer 2
  :config
  ;;(epa-file-enable)
  (setenv "GPG_AGENT_INFO" nil)
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  (setq epa-file-inhibit-auto-save nil))
;; ======================文件加密===================================
;; ====================multiple-cursors============================
(use-package multiple-cursors
  ;; Enabled at commands.
  :defer t
  :bind (("C-M-," . mc/mark-previous-like-this)
         ("C-M-." . mc/mark-next-like-this)
         ("M-s ," . mc/edit-lines)
         ("M-s ." . mc/mark-all-like-this)
         ("M-s /" . mc/insert-numbers)))
;; (global-set-key (kbd "C-M-;") 'set-rectangular-region-anchor)
;; mc/i:mc/insert-numbers: Insert increasing numbers for each cursor, top to bottom.
;; mc/sort-regions: Sort the marked regions alphabetically.
;; mc/reverse-regions: Reverse the order of the marked regions.
;; messages中会出现Error during redisplay: (error Lisp nesting exceeds `max-lisp-eval-depth')的错误。
;; ====================multiple-cursors============================
;; ====================expand-region=========================
(use-package expand-region
  ;; Enabled at commands.
  :defer t
  :bind ("C-M-;" . er/expand-region))
;; 在octave中使用会导致emacs假死，原因是octave的function中必须带有end。
;; emacs不是真正的假死，C-g会恢复。
;; ====================expand-region=========================
;; ==================回收站=======================
(use-package trashcan
  ;; Enabled automatically.
  :load-path "site-lisp/trashcan/")
;; ==================回收站=======================
;; ==================undo-tree===================
(use-package undo-tree
  ;; Enabled at commands.
  :defer t
  :bind (("C-/" . undo-tree-undo)
         ("C-M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  (define-key undo-tree-map (kbd "M-_") nil))
;; ==================undo-tree===================
;; ==================breadcrumb==================
(use-package breadcrumb
  ;; Enabled at commands.
  :load-path "site-lisp/breadcrumb/"
  :defer t
  :bind (("C-c C-/" . bc-set)
         ("C-c C-," . bc-previous)
         ("C-c C-." . bc-next)))
;; 删除breadcrumb.el源文件中(message "breadcrumb bookmark is set for the current position.")，使bc-set不出现提示。
;; (global-set-key (kbd "C-c /") 'bc-list) ;; C-x M-j for the bookmark menu list
;; (global-set-key (kbd "C-c /") 'bc-local-previous) ;; M-up-arrow for local previous
;; (global-set-key (kbd "C-c /") 'bc-local-next)     ;; M-down-arrow for local next
;; (global-set-key (kbd "C-c /") 'bc-goto-current) ;; C-c j for jump to current bookmark
;; ==================breadcrumb==================
;; ==================auto-mark===================
(use-package auto-mark
  ;; Enabled at commands.
  :load-path "site-lisp/auto-mark/"
  :defer 2
  :config
  ;; 会导致(void-variable last-command-char)错误。
  (setq auto-mark-command-class-alist
        '((goto-line . jump)
          (goto-last-change . jump)
          (indent-for-tab-command . ignore)
          (undo . ignore)))
  (setq auto-mark-command-classifiers
        (list (lambda (command)
                (if (and (eq command 'self-insert-command)
                         (eq last-command-char ? ))
                    'ignore))))
  (global-auto-mark-mode 1))
;; ==================auto-mark===================
;; ================visible-mark==================
(use-package visible-mark
  ;; Enabled automatically.
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
  (setq visible-mark-forward-faces '(swint-visible-mark-forward-face-1 swint-visible-mark-forward-face-2)))
;; ================visible-mark==================
;; =====================unicad=====================
;; lin中不会出现乱码，不需要，这个包会拖慢启动速度。
(use-package unicad
  ;; Enabled automatically.
  :load-path "site-lisp/unicad/"
  :if is-win
  :config
  ;; 解决关emacs时保存.session的编码问题
  (setq session-save-file-coding-system 'utf-8)
  ;; set default encoding to utf-8
  (setq-default buffer-file-coding-system 'utf-8)
  ;; set writing buffer default to utf-8, or emacs always show encoding problem when saving files.
  (setq save-buffer-coding-system 'utf-8)
  (setq coding-system-for-write 'utf-8))
;; =====================unicad=====================
;; =====================everything======================
(use-package everything
  ;; Enabled at commands.
  :load-path "site-lisp/everything/"
  :if is-win
  :bind ("C-c C-S-f" . everything)
  :init
  (global-set-key (kbd "C-c C-M-f") '(lambda () (interactive)
                                       (w32-shell-execute
                                        "open" "c:/Program Files/Everything/Everything.exe")))
  (global-set-key (kbd "C-c M-f") '(lambda () (interactive)
                                     (w32-shell-execute
                                      "open" "c:/Program Files/Everything/Everything.exe"
                                      (concat "-p " (expand-file-name default-directory)))))
  :config
  (setq everything-ffap-integration nil) ;; to disable ffap integration
  (setq everything-matchpath t)
  (setq everything-cmd "c:/Program Files/Everything/es.exe"))
;; =====================everything======================
;; =====================popwin======================
(use-package popwin
  ;; Enabled at idle.
  :defer 2
  :config
  (popwin-mode 1))
;; =====================popwin======================
;; =====================anchored-transpose======================
(use-package anchored-transpose
  ;; Enabled at commands.
  :defer t
  :bind ("C-x t" . anchored-transpose)
  :config
  (autoload 'anchored-transpose "anchored-transpose" nil t))
;; First select the entire phrase and type C-x t. Then select the anchor phrase and type C-x t again. You’re done!
;; 首先选择整个区域，然后选择锚点，锚点两侧的内容交换
;; You can select the anchor phrase first followed by the phrase to be transposed if more convenient. Or select the 2 phrases independently. If you select 2 overlapping sections it ignores the overlap and swaps the non-overlapping sections. It even supports SecondarySelection. Somehow it can always tell what you want ;-)
;; 另外，可以分别选择两部分交换的内容
;; =====================anchored-transpose======================
;; =====================God-mode======================
(use-package god-mode
  ;; Enabled at commands.
  :defer t
  :bind ("<escape>" . god-local-mode)
  :config
  ;; (global-set-key (kbd "<escape>") 'god-mode-all)
  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
                          'bar
                        'box)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)
  (add-to-list 'god-exempt-major-modes 'dired-mode))
;; =====================God-mode======================
;; =====================elisp-slime-nav======================
(use-package help
  ;; Enabled at commands.
  ;; Enabled automatically actually.
  :defer t
  :bind ("C-M-'" . help-for-help)
  :config
  (define-key 'help-command (kbd "C-l") 'find-library)
  (define-key 'help-command (kbd "C-f") 'find-function)
  (define-key 'help-command (kbd "C-k") 'find-function-on-key)
  (define-key 'help-command (kbd "C-v") 'find-variable))
(use-package help-mode
  ;; Enabled with defer.
  :defer t
  :config
  (define-key help-mode-map (kbd "q") 'kill-buffer-and-window))
(use-package elisp-slime-nav
  ;; Enabled in emacs-lisp-mode.
  :defer t
  :init
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'elisp-slime-nav-mode))
  :config
  (define-key elisp-slime-nav-mode-map (kbd "C-x C-,") 'elisp-slime-nav-find-elisp-thing-at-point)
  (define-key elisp-slime-nav-mode-map (kbd "C-x C-.") 'pop-tag-mark)
  (define-key elisp-slime-nav-mode-map (kbd "C-x C-/") 'elisp-slime-nav-describe-elisp-thing-at-point)
  (define-key elisp-slime-nav-mode-map (kbd "M-.") nil)
  (define-key elisp-slime-nav-mode-map (kbd "M-,") nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d d") nil)
  (define-key elisp-slime-nav-mode-map (kbd "C-c C-d C-d") nil))
;; =====================elisp-slime-nav======================
;; ===================drag stuff====================
(use-package drag-stuff
  ;; Enabled in several modes.
  :defer t
  :init
  (add-hook 'dired-mode-hook 'drag-stuff-mode)
  (add-hook 'octave-mode-hook 'drag-stuff-mode)
  (add-hook 'org-mode-hook 'drag-stuff-mode)
  (add-hook 'gnuplot-mode-hook 'drag-stuff-mode)
  (add-hook 'emacs-lisp-mode-hook 'drag-stuff-mode)
  (add-hook 'c-mode-hook 'drag-stuff-mode)
  (add-hook 'graphviz-dot-mode-hook 'drag-stuff-mode)
  (add-hook 'LaTeX-mode-hook 'drag-stuff-mode)
  :config
  ;; 重新定义drag-stuff.el文件中的 drag-stuff-define-keys 函数，取消关于 M+方向键 的快捷键定义。
  (defun drag-stuff-define-keys ()
    "Defines keys for `drag-stuff-mode'."
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'up) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'down) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'right) nil)
    (define-key drag-stuff-mode-map (drag-stuff--kbd 'left) nil))
  (define-key drag-stuff-mode-map (kbd "M-P") 'drag-stuff-up)
  (define-key drag-stuff-mode-map (kbd "M-N") 'drag-stuff-down)
  (define-key drag-stuff-mode-map (kbd "M-B") 'drag-stuff-left)
  (define-key drag-stuff-mode-map (kbd "M-F") 'drag-stuff-right))
;; ===================drag stuff====================
;; ===================popup-kill-ring====================
(use-package popup-kill-ring
  ;; Enabled at commands.
  :defer t
  :bind ("C-M-y" . popup-kill-ring)
  :config
  (use-package popup)
  (use-package pos-tip)
  ;; (pos-tip-w32-max-width-height)   ; Maximize frame temporarily
  ;; (pos-tip-w32-max-width-height t) ; Keep frame maximized
  (setq popup-kill-ring-interactive-insert t))
;; ===================popup-kill-ring====================
;; ===================highlight-symbol====================
(use-package highlight-symbol
  ;; Enabled at commands.
  :defer t
  :init
  (smartrep-define-key global-map "C-x"
    '(("/" . highlight-symbol-at-point)
      ("," . highlight-symbol-prev)
      ("." . highlight-symbol-next)))
  :config
  (setq highlight-symbol-foreground-color "gray30"))
;; (global-set-key (kbd "C-c ") 'highlight-symbol-query-replace)
;; ===================highlight-symbol====================
;; ===================elmacro====================
;; 需要先打开elmacro-mode，然后F3/F4录制宏
;; 然后使用elmacro-show-last-macro来将操作转换为elisp
;; ===================elmacro====================
;; ===================hungry-delete====================
(use-package hungry-delete
  ;; Enabled at idle.
  :defer 2
  :config
  (global-hungry-delete-mode)
  (add-hook 'wdired-mode-hook
            (lambda ()
              (setq hungry-delete-mode nil))))
;; ===================hungry-delete====================
;; ===================imenu-anywhere====================
;; elpa安装imenu-anywhere
;; imenu-anywhere与imenu额区别在于，前者包括所有打开的相同mode的buffer，而后者只限于当前buffer。
;; 但是imenu-anywhere在初次使用时经常失效，没有结果。
(global-set-key (kbd "M-s i") 'helm-semantic-or-imenu)
(use-package imenu-anywhere
  ;; Enabled at commands.
  :defer t
  :bind ("M-s I" . helm-imenu-anywhere))
;; ===================imenu-anywhere====================
;; ================fcitx.el=================
;; https://github.com/cute-jumper/fcitx.el
(use-package fcitx
  ;; Enabled automatically.
  :if is-lin
  :config
  (fcitx-prefix-keys-add "M-s")
  (fcitx-default-setup)
  (fcitx-M-x-turn-on)
  (fcitx-shell-command-turn-on)
  (fcitx-eval-expression-turn-on)
  ;; (fcitx-aggressive-minibuffer-turn-on)
  ;; 会导致tramp问题，使需要在minibuffer输入密码时hang
  )
;; ================fcitx.el=================
;; ============aggressive-indent=============
(use-package aggressive-indent
  ;; Enabled at idle.
  :defer 2
  :config
  (global-aggressive-indent-mode 1))
;; ============aggressive-indent=============
;; ============clean-aindent-mode=============
(use-package clean-aindent-mode
  ;; Enabled in several modes.
  :defer t
  :init
  (add-hook 'prog-mode-hook 'clean-aindent-mode)
  :config
  (clean-aindent-mode t)
  (setq clean-aindent-is-simple-indent t)
  (define-key global-map (kbd "RET") 'newline-and-indent))
;; RET：自动清除white space，光标停留在前一行indentation处。
;; M-DEL：unindent，回到前一行indentation处。
;; ============clean-aindent-mode=============
;; ============multifiles=============
(use-package multifiles
  ;; Enabled at commands.
  :defer t
  :bind ("C-c t" . mf/mirror-region-in-multifile))
;; ============multifiles=============
;; ============ztree=============
(use-package ztree-diff
  ;; Enabled at commands.
  :defer t
  :bind ("C-c z" . ztree-diff))
;; ============ztree=============
;; ============which-key=============
;; 原用guide-key，改用which-key，显示更好。
;; (require 'guide-key)
;; (setq guide-key/guide-key-sequence
;;       '("C-c" (org-mode "C-c C-x")))
(use-package which-key
  ;; Enabled at idle.
  :defer 2
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-sort-order 'which-key-description-order)
  ;; 使用C-h或?切换页面。
  (setq which-key-use-C-h-for-paging t
        which-key-prevent-C-h-from-cycling nil))
;; ============which-key=============
;; ===================pdf-tools=================
;; 添加的注释跟okular类似，将注释的内容另存为一份文件，只有在emacs中才能看到
;; 上述注释为旧版本，新版本的pdf-tools已经可以将注释放在pdf文件本身之中了。
(use-package pdf-tools
  ;; Enabled in pdf-view-mode.
  :if is-lin
  :defer t
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook 'pdf-annot-minor-mode)
  (add-hook 'pdf-view-mode-hook 'pdf-outline-minor-mode)
  ;; pdf-view-auto-slice-minor-mode 翻页自动切边。
  ;; (add-hook 'pdf-view-mode-hook 'pdf-view-auto-slice-minor-mode)
  ;; 打开pdf时手动切边一次。手动切边(s b)，重设(s r)。取消。
  ;; (add-hook 'pdf-view-mode-hook 'pdf-view-set-slice-from-bounding-box)
  (define-key pdf-view-mode-map (kbd "C-c C-i") nil)
  (define-key pdf-view-mode-map (kbd "M-s i") 'helm-imenu)
  (define-key pdf-view-mode-map (kbd "M-v") 'pdf-view-scroll-down-or-previous-page)
  (define-key pdf-view-mode-map (kbd "C-v") 'pdf-view-scroll-up-or-next-page)
  (define-key pdf-view-mode-map (kbd "C-p") '(lambda () (interactive) (pdf-view-previous-line-or-previous-page 3)))
  (define-key pdf-view-mode-map (kbd "C-n") '(lambda () (interactive) (pdf-view-next-line-or-next-page 3)))
  (define-key pdf-view-mode-map (kbd "M-w") 'pdf-view-kill-ring-save)
  (define-key pdf-view-mode-map (kbd "C-x C-l") '(lambda () (interactive)
                                                   (dired-jump-other-window)
                                                   (org-annotate-file (abbreviate-file-name (dired-get-filename)))))
  (define-key pdf-view-mode-map (kbd "C-c C-l") '(lambda () (interactive)
                                                   (dired-jump-other-window)
                                                   (swint-org-annotate-file (abbreviate-file-name (dired-get-filename))))))
;; Failed to fix the bug of pdf-view-mode.
;; (defun swint-pdf-history-goto-beginning ()
;;   "Fix the bug of reverting to beginning of pdf after persp-switch."
;;   (interactive)
;;   (let ((pdf-buffers (remove-if-not (lambda (x) (eq (buffer-mode x) 'pdf-view-mode)) (persp-buffers persp-curr))))
;;     (loop for pdf-buffer in pdf-buffers
;;           do (with-current-buffer pdf-buffer
;;                (pdf-history-goto 0)))))
;; (add-hook 'persp-activated-hook 'swint-pdf-history-goto-beginning)
;; ===================pdf-tools=================
;; ==================doc-view-mode================
;; lin上使用soffice转换；win上使用unoconv转换。
;; pdf文件使用gs转换成png。
;; win下使用doc-view查看office和pdf文件时，文件名都不可以包含中文字符。
;; 默认的缓存文件夹分别为/tmp和c:/Users/swint/AppData/Local/Temp，使用doc-view-clear-cache清理。
(use-package doc-view
  ;; Enabled in doc-view-mode.
  :defer t
  :config
  (setq doc-view-continuous t)
  (define-key doc-view-mode-map (kbd "M-v") 'doc-view-scroll-down-or-previous-page)
  (define-key doc-view-mode-map (kbd "C-v") 'doc-view-scroll-up-or-next-page)
  (define-key doc-view-mode-map (kbd "C-p") '(lambda () (interactive) (doc-view-previous-line-or-previous-page 3)))
  (define-key doc-view-mode-map (kbd "C-n") '(lambda () (interactive) (doc-view-next-line-or-next-page 3)))
  (when is-win
    ;; 使用libreoffice自带python.exe运行unoconv脚本。
    (setq doc-view-odf->pdf-converter-program "c:/Program Files (x86)/LibreOffice 5/program/python.exe")
    ;; 指定使用unoconv方法转换。
    (setq doc-view-odf->pdf-converter-function 'doc-view-odf->pdf-converter-unoconv)
    (defun doc-view-odf->pdf-converter-unoconv (odf callback)
      "Convert ODF to PDF asynchronously and call CALLBACK when finished.
The converted PDF is put into the current cache directory, and it
is named like ODF with the extension turned to pdf."
      (doc-view-start-process "odf->pdf" doc-view-odf->pdf-converter-program
                              (list "c:/Program Files (x86)/unoconv/unoconv" "-f" "pdf" "-o"
                                    ;; 修改下句，原函数会生成无base name文件。
                                    (concat (doc-view--current-cache-dir) (file-name-base odf) ".pdf") odf)
                              callback))))
;; ==================doc-view-mode================
;; ================backup-walker================
(use-package backup-walker
  ;; Enabled at commands.
  :defer t
  :bind ("C-x b" . backup-walker-start))
(use-package git-timemachine
  ;; Enabled at commands.
  :defer t
  :bind ("C-c b" . git-timemachine))
;; ================backup-walker================
;; ===============visual-regexp===============
(use-package visual-regexp
  ;; Enabled at commands.
  :defer t
  :bind (("M-s r" . vr/replace)
         ("M-s C-r" . vr/query-replace)
         ("M-s C-;" . vr/mc-mark)))
;; ===============visual-regexp===============
;; ===============vlf===============
;; vlf把大文件分成多个batch，以改善性能。
;; Enable vlf when opening files bigger than 100MB.
(use-package vlf
  ;; Enabled at idle.
  :defer 2
  :init
  (setq large-file-warning-threshold 100000000)
  :config
  (use-package vlf-setup)
  (custom-set-variables '(vlf-application 'dont-ask))
  (add-to-list 'vlf-forbidden-modes-list 'pdf-view-mode)
  (define-key vlf-prefix-map "\C-cv" vlf-mode-map))
;; C-c C-v n and C-c C-v p move batch by batch.
;; C-c C-v SPC displays batch starting from current point.
;; C-c C-v [ and C-c C-v ] take you to the beginning and end of file respectively.
;; C-c C-v j jumps to particular batch number.
;; C-c C-v + and C-c C-v - control current batch size by factors of 2.
;; C-c C-v s and C-c C-v r search forward and backward respectively over the whole file, batch by batch.
;; C-c C-v % does search and query replace saving intermediate changes.
;; C-c C-v l jumps to given line in file.
;; M-x vlf-ediff-files and M-x vlf-ediff-buffers to compare files/buffers batch by batch.
;; C-c C-v o builds index over whole file for given regular expression just like M-x occur.
;; ===============vlf===============
;; ==============easy-kill===============
(use-package easy-kill
  ;; Enabled at commands.
  :defer t
  :bind ("M-w" . kill-ring-save)
  :init
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark)
  :config
  (define-key easy-kill-base-map (kbd "C-w") 'easy-kill-region))
;; M-w ?: help 查看M-w prefix快捷键
;; ==============easy-kill===============
;; ================smex==================
(use-package smex
  ;; Enabled at commands.
  :defer t
  :bind (("M-X" . smex)
         ("C-x M-X" . smex-major-mode-commands)))
;; ================smex==================
;; =================bm===================
(use-package bm
  ;; Enabled at commands.
  :defer t
  :init
  (smartrep-define-key global-map "C-c"
    '(("/" . bm-toggle)
      ("," . bm-previous)
      ("." . bm-next))))
;; (setq temporary-bookmark-p t)
;; =================bm===================
;; ============operate-on-number============
;; 两种操作方式：C-= 计算符号，支持C-u前缀数字；C-= = 依次确定计算符号和数字。
(use-package operate-on-number
  ;; Enabled at commands.
  :defer t
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
;; ============operate-on-number============
;; ============goto-last-change============
(use-package goto-chg
  ;; Enabled at commands.
  :defer t
  :init
  (smartrep-define-key global-map "M-s"
    '(("M-p" . goto-last-change)
      ("M-n" . goto-last-change-reverse))))
;; ============goto-last-change============
;; =================Proced=================
(use-package proced
  ;; Enabled at commands.
  :defer t
  :bind ("C-M-4" . proced)
  :config
  (define-key proced-mode-map (kbd "q") 'kill-buffer-and-window)
  ;; Proced自动更新，10秒
  (defun proced-settings ()
    (proced-toggle-auto-update 1))
  (add-hook 'proced-mode-hook 'proced-settings))
;; =================Proced=================
(provide 'setup_packages)

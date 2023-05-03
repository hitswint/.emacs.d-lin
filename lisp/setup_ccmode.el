;;; ccmode
;; ===================ccmode====================
(def-package! cc-mode
  :mode (("\\.\\(cc\\|hh\\)\\'" . c++-mode)
         ("\\.[ch]\\(pp\\|xx\\|\\+\\+\\)\\'" . c++-mode)
         ("\\.\\(CC?\\|HH?\\)\\'" . c++-mode)
         ("\\.[ch]\\'" . c-mode)
         ("\\.y\\(acc\\)?\\'" . c-mode)
         ("\\.lex\\'" . c-mode)
         ("\\.i\\'" . c-mode)
         ("\\.ii\\'" . c++-mode))
  :config
  (setq c-default-style "linux")
  (defun c-compile-current-file ()
    (interactive)
    (unless (file-exists-p "Makefile")
      (let ((file (file-name-nondirectory buffer-file-name)))
        (compile (format "%s -o %s.out %s %s %s"
                         (or (getenv "CC") "gcc")
                         (file-name-sans-extension file)
                         (or (getenv "CPPFLAGS") "")
                         (or (getenv "CFLAGS") "-Wall -g")
                         file)))))
  (dolist (hook '(c-mode-hook c++-mode-hook asm-mode-hook))
    (add-hook hook (lambda ()
                     (define-key c-mode-base-map (kbd "C-c C-c") 'c-compile-current-file)
                     (define-key c-mode-base-map (kbd "C-c C-S-c") (lambda () (interactive)
                                                                     (setq-local compilation-read-command nil)
                                                                     (call-interactively 'compile)))
                     (define-key c-mode-base-map (kbd "C-M-q") nil)
                     (define-key c-mode-base-map (kbd "(") nil)
                     (define-key c-mode-base-map (kbd "{") nil)))))
;; ===================ccmode====================
;;; gdb
;; =====================gdb=====================
(def-package! gdb-mi
  :commands gdb-or-gud-go
  :init
  (dolist (hook '(c-mode-hook c++-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "C-c g") 'gdb-or-gud-go))))
  :config
  (define-key gud-mode-map (kbd "C-c G") 'gud-quit)
  ;; 直接使用gdb-or-gud-go弹出gud-comint-buffer未定义，先gdb，然后gdb-or-gud-go
  (defun gdb-or-gud-go (&optional arg)
    "If gdb isn't running; run gdb, else call gud-go."
    (interactive "P")
    (if arg
        (gdb-many-windows 1)
      (gdb-many-windows 0))
    (if (and gud-comint-buffer
             (buffer-name gud-comint-buffer)
             (get-buffer-process gud-comint-buffer)
             (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdb)))
        (gud-call (if gdb-active-process "continue" "run") "")
      (gdb (gud-query-cmdline 'gdb))))
  (defun gud-quit ()
    "Kill gdb process."
    (interactive)
    (when gdb-many-windows
      (kill-buffer (gdb-locals-buffer-name))
      (kill-buffer (gdb-stack-buffer-name))
      (kill-buffer (gdb-breakpoints-buffer-name))
      (kill-buffer (gdb-inferior-io-name))
      (kill-buffer "*Buffer List*"))
    (with-current-buffer gud-comint-buffer
      (comint-skip-input)
      (kill-process (get-buffer-process gud-comint-buffer))
      (delete-other-windows)))
  (add-hook 'gdb-mode-hook 'kill-shell-buffer-after-exit t))
;; =====================gdb=====================
;;; function-args
;; ==================function-args==============
(def-package! function-args
  :diminish function-args-mode
  :commands (moo-complete moo-jump-local moo-jump-directory fa-jump-maybe swint-fa-show)
  :init
  (dolist (hook '(c-mode-hook c++-mode-hook asm-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "C-c u") 'moo-complete)
                     (local-set-key (kbd "C-c i") 'moo-jump-local)
                     (local-set-key (kbd "C-c I") 'moo-jump-directory)
                     (local-set-key (kbd "C-c j") 'fa-jump-maybe)
                     (local-set-key (kbd "C-c o") 'swint-fa-show))))
  :config
  (function-args-mode 1) ;function-args-mode only trigger semantic-mode
  (assq-delete-all 'function-args-mode minor-mode-map-alist) ;解除默认按键绑定
  (defun swint-fa-show ()
    (interactive)
    (if (overlayp fa-overlay)
        (fa-abort)
      (fa-show))))
;; ==================function-args==============
;;; semantic
;; ===================semantic==================
(def-package! semantic
  :after (:any function-args helm)
  :config
  (semantic-mode 1)
  (setq semantic-idle-scheduler-idle-time 5)
  ;; 弹出警告：Selecting deleted buffer
  ;; (semanticdb-enable-gnu-global-databases 'c-mode)
  ;; (semanticdb-enable-gnu-global-databases 'c++-mode)
  (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
  ;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
  ;; 默认semantic快捷键以C-c ,为前缀
  (define-key semantic-mode-map (kbd "C-c ,") nil))
;; ===================semantic==================
;;; hs-minor-mode
;; ==================hs-minor-mode==============
(def-package! hideshow
  :diminish hs-minor-mode
  :commands hs-toggle-hiding
  :init
  (dolist (hook '(c-mode-common-hook asm-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "C-c C-`") 'hs-toggle-hiding))))
  :config
  (define-key hs-minor-mode-map (kbd "C-c C-`") 'hs-toggle-hiding))
;; ==================hs-minor-mode==============
;;; helm-gtags
;; ==================helm-gtags=================
(def-package! helm-gtags
  :diminish helm-gtags-mode
  :commands (helm-gtags-mode
             helm-gtags-dwim
             helm-gtags-pop-stack
             helm-gtags-select)
  :init
  (dolist (hook '(c-mode-hook c++-mode-hook asm-mode-hook))
    (add-hook hook (lambda ()
                     (local-set-key (kbd "C-c C-,") 'helm-gtags-dwim)
                     (local-set-key (kbd "C-c C-.") 'helm-gtags-pop-stack)
                     (local-set-key (kbd "C-c C-/") 'helm-gtags-select))))
  :config
  (dolist (hook '(c-mode-hook c++-mode-hook asm-mode-hook))
    (add-hook hook 'helm-gtags-mode))
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
        (helm-gtags-mode))))
  (defun helm-gtags--find-tag-simple/around (fn &rest args)
    (let ((helm-execute-action-at-once-if-one nil))
      (apply fn args)))
  (advice-add 'helm-gtags--find-tag-simple :around #'helm-gtags--find-tag-simple/around)
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-suggested-key-mapping nil)
  (smartrep-define-key helm-gtags-mode-map "C-c"
    '(("C-," . helm-gtags-dwim)
      ("C-." . helm-gtags-pop-stack)
      ("C-/" . helm-gtags-select)
      ("," . helm-gtags-previous-history)
      ("." . helm-gtags-next-history)
      ("/" . helm-gtags-show-stack))))
;; ==================helm-gtags=================
;;; arduino
;; ===================arduino===================
(def-package! arduino-mode
  :mode (("\\.pde\\'" . arduino-mode)
         ("\\.ino\\'" . arduino-mode)))
;; ===================arduino===================
;;; disaster
;; ==================disaster===================
(def-package! disaster
  :commands disaster)
;; ==================disaster===================
;;; meghanada
;; =================meghanada===================
(def-package! meghanada
  :diminish meghanada-mode
  :commands (meghanada-jump-declaration
             meghanada-back-jump
             meghanada-reference)
  :init
  (add-hook 'java-mode-hook (lambda ()
                              (bind-key "C-c C-," 'meghanada-jump-declaration java-mode-map)
                              (bind-key "C-c C-." 'meghanada-back-jump java-mode-map)
                              (bind-key "C-c C-/" 'meghanada-reference java-mode-map)))
  :config
  (add-hook 'java-mode-hook 'meghanada-mode)
  (dolist (buf (cl-remove-if-not (lambda (x)
                                   (equal (buffer-mode x) 'java-mode))
                                 (buffer-list)))
    (with-current-buffer buf
      (meghanada-mode)))
  ;; 默认快捷键以C-c C-r和C-c C-c开头
  (define-key meghanada-mode-map (kbd "C-c C-,") 'meghanada-jump-declaration)
  (define-key meghanada-mode-map (kbd "C-c C-.") 'meghanada-back-jump)
  (define-key meghanada-mode-map (kbd "C-c C-/") 'meghanada-reference)
  (define-key meghanada-mode-map (kbd "C-c C-f") 'meghanada-code-beautify)
  (define-key meghanada-mode-map (kbd "C-c c") 'meghanada-exec-main)
  (define-key meghanada-mode-map (kbd "C-M-,") nil)
  (define-key meghanada-mode-map (kbd "C-c C-<tab>") 'meghanada-switch-testcase))
;; =================meghanada===================
(provide 'setup_ccmode)

;;; lsp-bridge
;; =====================lsp-bridge=====================
(def-package! posframe
  :commands posframe-show)
(def-package! lsp-bridge
  :load-path "repos/lsp-bridge/"
  :bind ("M-g l" . swint-toggle-lsp-bridge)
  :init
  (bind-key "C-x C-," 'xref-find-definitions)
  (bind-key "C-x C-." 'xref-pop-marker-stack)
  (bind-key "C-x C-/" 'xref-find-references)
  (bind-key "C-x C-?" 'xref-find-apropos)
  :config
  (require 'yasnippet)
  (yas-global-mode 1)
  (setq lsp-bridge-c-lsp-server "clangd")
  (setq lsp-bridge-python-lsp-server "pyright")
  (setq lsp-bridge-complete-manually nil) ;lsp-bridge-popup-complete-menu
  (setq acm-enable-quick-access nil)
  (setq acm-quick-access-modifier 'control) ;acm-complete-quick-access
  (acm-keymap--bind-quick-access acm-mode-map)
  (defun swint-toggle-lsp-bridge ()
    (interactive)
    (unless (equal (bound-and-true-p pyvenv-virtual-env-name) "py3")
      (pyvenv-activate (format "%s/%s" (pyvenv-workon-home) "py3")))
    (dolist (buf (cl-remove-if-not (lambda (x)
                                     (equal (buffer-mode x) major-mode))
                                   (buffer-list)))
      (with-current-buffer buf
        (call-interactively 'lsp-bridge-mode)))
    (if lsp-bridge-mode
        (add-hook (intern (concat (symbol-name major-mode) "-hook")) 'lsp-bridge-mode)
      (remove-hook (intern (concat (symbol-name major-mode) "-hook")) 'lsp-bridge-mode)))
  (add-hook 'lsp-bridge-mode-hook #'(lambda ()
                                      (set (make-local-variable 'company-idle-delay) nil)))
  (transient-define-prefix trainsient-scroll-popup-lsp-document ()
    ["scoll popup document"
     ("M-p" "scrool down" lsp-bridge-popup-documentation-scroll-down :transient t)
     ("M-n" "scroll up" lsp-bridge-popup-documentation-scroll-up :transient t)
     ("q" "quit" transient-quit-all)])
  (define-key acm-mode-map (kbd "M-RET") #'acm-insert-common)
  (define-key acm-mode-map (kbd "M-<") #'acm-select-first)
  (define-key acm-mode-map (kbd "M->") #'acm-select-last)
  (define-key acm-mode-map (kbd "C-o") #'acm-doc-toggle)
  (define-key acm-mode-map (kbd "M-p") #'acm-doc-scroll-down)
  (define-key acm-mode-map (kbd "M-n") #'acm-doc-scroll-up)
  (define-key lsp-bridge-mode-map (kbd "C-c C-,") #'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-c C-M-,") #'lsp-bridge-find-def-other-window)
  (define-key lsp-bridge-mode-map (kbd "C-c C-.") #'lsp-bridge-find-def-return)
  (define-key lsp-bridge-mode-map (kbd "C-c ,") #'lsp-bridge-find-impl)
  (define-key lsp-bridge-mode-map (kbd "C-c M-,") #'lsp-bridge-find-impl-other-window)
  (define-key lsp-bridge-mode-map (kbd "C-c C-/") #'lsp-bridge-find-references)
  (define-key lsp-bridge-mode-map (kbd "C-c C-M-/") #'lsp-bridge-workspace-list-symbols)
  (define-key lsp-bridge-mode-map (kbd "C-c /") #'(lambda () (interactive)
                                                    (lsp-bridge-popup-documentation)
                                                    (trainsient-scroll-popup-lsp-document)))
  ;; (define-key lsp-bridge-mode-map (kbd "M-p") #'lsp-bridge-popup-documentation-scroll-down)
  ;; (define-key lsp-bridge-mode-map (kbd "M-n") #'lsp-bridge-popup-documentation-scroll-up)
  (define-key lsp-bridge-mode-map (kbd "C-c M-r") #'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c M-p") #'lsp-bridge-diagnostic-jump-prev)
  (define-key lsp-bridge-mode-map (kbd "C-c M-n") #'lsp-bridge-diagnostic-jump-next)
  (define-key lsp-bridge-mode-map (kbd "C-c M-d") #'lsp-bridge-diagnostic-list)
  (define-key lsp-bridge-mode-map (kbd "C-c M-w") #'lsp-bridge-diagnostic-copy)
  (define-key lsp-bridge-mode-map (kbd "C-c M-i") #'lsp-bridge-diagnostic-ignore)
  (define-key lsp-bridge-mode-map (kbd "C-c d") #'lsp-bridge-toggle-sdcv-helper))
;; =====================lsp-bridge=====================
(provide 'setup_lsp)

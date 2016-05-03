(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(completion-cycle-threshold nil)
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(dirtree-windata (quote (frame left 0.3 delete)))
 '(helm-buffer-details-flag nil)
 '(helm-completing-read-handlers-alist
   (quote
    ((describe-function . helm-completing-read-symbols)
     (describe-variable . helm-completing-read-symbols)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (find-tag . helm-completing-read-with-cands-in-buffer)
     (ffap-alternate-file)
     (tmm-menubar)
     (iswitchb-buffer . ido)
     (find-file . ido)
     (org-annotate-file . ido)
     (swint-org-annotate-file . ido)
     (dired-do-copy . ido)
     (dired-create-directory . ido)
     (dirtree . ido))))
 '(helm-ff-newfile-prompt-p nil)
 '(helm-projectile-sources-list
   (quote
    (helm-source-projectile-projects helm-source-projectile-files-list helm-source-projectile-buffers-list)))
 '(helm-split-window-default-side (quote same))
 '(ibuffer-default-sorting-mode (quote major-mode))
 '(ido-auto-merge-delay-time 0.7)
 '(ido-enable-flex-matching t)
 '(ido-ignore-buffers
   (quote
    ("\\`Enjoy\\ Music\\'" "\\`\\*Inferior\\ Octave\\*\\'" "\\`\\*Ibuffer\\*\\'" "\\`\\*shell\\*\\'" "\\`\\*calculator\\*\\'" "\\`\\*Calendar\\*\\'" "\\`\\*Compile\\=Log\\*\\'" "\\`\\*Completions\\*\\'" "\\`\\*sdcv\\*\\'" "\\`\\*buffer-selection\\*\\'" "\\`\\*toc\\*\\'" "\\`\\*compilation\\*\\'" "\\`\\*Ido\\ Completions\\*\\'" "\\`\\*Mingus\\*\\'" "\\`\\*helm.*\\*\\'" "\\`\\*Helm.*\\*\\'" "\\`.english-words\\'" my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer)))
 '(ido-make-dir-list-hook nil)
 '(ido-separator "   ")
 '(iswitchb-case t)
 '(iswitchb-delim "   ")
 '(iswitchb-use-frame-buffer-list nil)
 '(magit-emacsclient-executable nil)
 '(matlab-comment-region-s "%% ")
 '(matlab-fill-code nil)
 '(mingus-mode-always-modeline nil)
 '(mingus-mode-line-show-consume-and-single-status nil)
 '(mingus-mode-line-show-elapsed-percentage nil)
 '(mingus-mode-line-show-elapsed-time nil)
 '(mingus-mode-line-show-random-and-repeat-status nil)
 '(mingus-mode-line-show-status nil)
 '(mingus-mode-line-show-volume nil)
 '(octave-auto-indent t)
 '(org-export-latex-image-default-option "width=1\\linewidth")
 '(org-export-pdf-remove-logfiles nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(persp-initial-frame-name "i")
 '(persp-modestring-dividers (quote ("" "" "")))
 '(persp-show-modestring t)
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(read-buffer-function (quote iswitchb-read-buffer))
 '(recentf-max-saved-items 50)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(sml/col-number-format "%3c")
 '(sml/directory-truncation-string "")
 '(sml/line-number-format "%4l")
 '(sml/mode-width 0)
 '(sml/name-width 40)
 '(sml/new-mail-background-color "black")
 '(sml/position-percentage-format "")
 '(sml/projectile-replacement-format "[%s]")
 '(sml/shorten-mode-string "")
 '(sml/use-projectile-p (quote before-prefixes))
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(w3m-command "c:/Program Files (x86)/w3m/w3m.exe")
 '(zotelo-translator-charsets (quote ((BibTeX . "Unicode") (Default . "Unicode")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-foreground ((((class color)) (:foreground "yellow" :weight bold))))
 '(completions-common-part ((t (:inherit default :foreground "red"))))
 '(diredp-compressed-file-suffix ((t (:foreground "#7b68ee"))) t)
 '(diredp-ignored-file-name ((t (:foreground "#aaaaaa"))) t)
 '(helm-buffer-directory ((t (:foreground "yellow" :weight bold))))
 '(helm-buffer-file ((t (:inherit font-lock-type-face))))
 '(helm-ff-directory ((t (:foreground "yellow" :weight bold))))
 '(helm-ff-dotted-directory ((t (:foreground "yellow" :weight bold))))
 '(helm-ff-file ((t (:foreground "white"))))
 '(helm-grep-file ((t (:foreground "cyan"))))
 '(helm-selection ((t (:background "black" :underline t))))
 '(helm-visible-mark ((t (:foreground "DeepSkyBlue1"))))
 '(highlight ((t (:background "black"))))
 '(ido-first-match ((t (:foreground "yellow" :weight bold))))
 '(ido-only-match ((((class color)) (:foreground "DeepSkyBlue1" :weight bold))))
 '(ido-subdir ((t (:foreground "green"))))
 '(iswitchb-current-match ((t (:foreground "yellow" :weight bold))))
 '(iswitchb-single-match ((t (:foreground "DeepSkyBlue1" :weight bold))))
 '(persp-selected-face ((t (:inherit sml/filename :foreground "green" :weight bold))))
 '(preview-face ((((background dark)) (:background "dark slate gray"))) t)
 '(preview-reference-face ((t (:background "white"))) t)
 '(rainbow-delimiters-depth-1-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "DeepSkyBlue1"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#8b7500"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "red"))))
 '(show-paren-match ((((class color) (background light)) (:background "azure2"))))
 '(sml/col-number ((t (:foreground "lawn green"))))
 '(sml/filename ((t (:inherit sml/global :foreground "yellow" :weight bold))))
 '(sml/line-number ((t (:foreground "gold"))))
 '(sml/modes ((t (:inherit sml/global :foreground "gray50"))))
 '(sml/numbers-separator ((t (:inherit sml/global))))
 '(sml/position-percentage ((t (:foreground "yellow"))))
 '(sml/prefix ((t (:inherit sml/global :foreground "deep sky blue" :weight bold))))
 '(sml/projectile ((t (:foreground "deep sky blue" :weight bold))))
 '(sml/read-only ((t (:inherit sml/not-modified :foreground "gray50"))))
 '(visible-mark-active ((t (:background "maroon" :foreground "white"))))
 '(w3m-bold ((t (:foreground "red" :weight bold))))
 '(window-numbering-face ((t (:background "dark red" :foreground "white"))) t))

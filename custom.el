(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(bs-default-configuration "files")
 '(cfs--current-profile-name "profile1" t)
 '(custom-safe-themes
   (quote
    ("6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(dirtree-windata (quote (frame left 0.3 delete)))
 '(display-time-mode nil)
 '(emms-lyrics-display-on-modeline nil)
 '(helm-bibtex-format-citation-functions
   (quote
    ((org-mode . helm-bibtex-format-citation-ebib)
     (latex-mode . swint-helm-bibtex-format-citation-cite)
     (markdown-mode . helm-bibtex-format-citation-pandoc-citeproc)
     (default . helm-bibtex-format-citation-default))))
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
     (find-file)
     (org-annotate-file)
     (swint-org-annotate-file)
     (dired-do-copy)
     (iswitchb-buffer)
     (dirtree)
     (dired-create-directory))))
 '(helm-external-programs-associations
   (quote
    (("rmvb" . "mplayer")
     ("mp4" . "mplayer")
     ("pptx" . "wpp")
     ("ppt" . "wpp")
     ("xlsx" . "et")
     ("xls" . "et")
     ("docx" . "wps")
     ("doc" . "wps")
     ("pdf" . "llpp"))))
 '(helm-ff-newfile-prompt-p nil)
 '(helm-projectile-sources-list
   (quote
    (helm-source-projectile-projects helm-source-projectile-files-list helm-source-projectile-buffers-list)))
 '(helm-split-window-default-side (quote same))
 '(helm-truncate-lines nil)
 '(ido-auto-merge-delay-time 0.7)
 '(ido-default-buffer-method (quote raise-frame))
 '(ido-default-file-method (quote raise-frame))
 '(ido-enable-flex-matching t)
 '(ido-file-extensions-order nil)
 '(ido-ignore-buffers
   (quote
    ("\\`Enjoy\\ Music\\'" "\\`\\*Inferior\\ Octave\\*\\'" "\\`\\*Ibuffer\\*\\'" "\\`\\*MATLAB\\*\\'" "\\`\\*shell\\*\\'" "\\`\\*calculator\\*\\'" "\\`\\*Calendar\\*\\'" "\\`\\*Compile\\=Log\\*\\'" "\\`\\*Completions\\*\\'" "\\`\\*sdcv\\*\\'" "\\`\\*scratch\\*\\'" "\\`\\*Process\\ List\\*\\'" "\\`\\*toc\\*\\'" "\\`\\*helm.*\\*\\'" "\\`\\*Helm.*\\*\\'" "\\`\\*buffer-selection\\*\\'" "\\`\\*Disabled\\ Command\\*\\'" "\\`\\*Mingus\\*\\'" "\\`\\*compilation\\*\\'" "\\`\\*Ido\\ Completions\\*\\'" "\\` " "\\`.english-words\\'" my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer my-ignore-buffer)))
 '(ido-separator "   ")
 '(ido-use-virtual-buffers nil)
 '(iswitchb-case t)
 '(iswitchb-delim "   ")
 '(iswitchb-use-frame-buffer-list nil)
 '(magit-emacsclient-executable nil)
 '(matlab-comment-region-s "%% ")
 '(matlab-fill-code nil)
 '(octave-auto-indent t)
 '(org-capture-bookmark nil)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-latex-default-figure-position "htbp")
 '(org-latex-image-default-width "1\\linewidth")
 '(org-latex-pdf-process
   (quote
    ("xelatex -interaction nonstopmode -output-directory %o %f")) t)
 '(org-latex-remove-logfiles nil)
 '(persp-initial-frame-name "i")
 '(persp-modestring-dividers (quote ("" "" "")))
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(preview-transparent-color (quote (highlight :background)))
 '(read-buffer-function (quote persp-read-buffer))
 '(recentf-max-saved-items 50)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(sml/mode-width 0)
 '(sml/name-width 50)
 '(sml/new-mail-background-color "black")
 '(sml/projectile-replacement-format "[%s]")
 '(sml/shorten-mode-string "")
 '(sml/theme (quote dark))
 '(sml/use-projectile-p (quote before-prefixes))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(zotelo-translator-charsets (quote ((BibTeX . "Unicode") (Default . "Unicode")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-background ((t (:foreground "#666666"))))
 '(ace-jump-face-foreground ((t (:foreground "yellow" :weight bold))))
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
 '(ido-first-match ((t (:foreground "yellow" :weight bold))))
 '(ido-only-match ((((class color)) (:foreground "DeepSkyBlue1" :weight bold))))
 '(ido-subdir ((t (:foreground "green"))))
 '(iswitchb-current-match ((t (:foreground "yellow" :weight bold))))
 '(iswitchb-single-match ((t (:foreground "DeepSkyBlue1" :weight bold))))
 '(persp-selected-face ((t (:inherit sml/filename :foreground "cyan" :weight bold))))
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
 '(sml/line-number ((t (:foreground "yellow"))))
 '(sml/modes ((t (:inherit sml/global :foreground "gray50"))))
 '(sml/position-percentage ((t (:foreground "yellow"))))
 '(sml/prefix ((t (:inherit sml/global :foreground "green"))))
 '(sml/projectile ((t (:foreground "green" :weight bold))))
 '(sml/read-only ((t (:inherit sml/not-modified :foreground "gray50"))))
 '(visible-mark-active ((((class color) (background dark)) (:background "maroon" :foreground "white"))))
 '(w3m-bold ((t (:foreground "red" :weight bold))))
 '(window-numbering-face ((t (:background "dark magenta" :foreground "white"))) t))

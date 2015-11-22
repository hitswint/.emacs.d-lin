;; ====================elpa=========================
(require 'package)
(unless package--initialized
  (setq package-archives '(("melpa" . "http://melpa.org/packages/")
                           ("gnu" . "http://elpa.gnu.org/packages/")
                           ("org" . "http://orgmode.org/elpa/")
                           ;; ("elpa" . "http://tromey.com/elpa/")
                           ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                           ))
  ;; optimization, no need to activate all the packages so early
  (setq package-enable-at-startup nil)
  ;; 激活所有packages，也可以使用package-activate单独激活。
  (package-initialize))
;; 借自prelude。
(defvar prelude-packages
  (append '(ace-jump-mode
            ac-ispell
            ac-math
            aggressive-indent
            anchored-transpose
            anzu
            async
            auctex
            auctex-latexmk
            auto-complete
            auto-complete-auctex
            auto-complete-c-headers
            auto-complete-clang
            backup-walker
            bind-key
            bing-dict
            bm
            cdlatex
            clean-aindent-mode
            company
            company-c-headers
            company-quickhelp
            dash
            diminish
            dired-details
            diredful
            dirtree
            drag-stuff
            function-args
            easy-kill
            elisp-slime-nav
            elmacro
            emms
            epl
            expand-region
            f
            flx
            flx-ido
            flycheck
            git-commit
            git-timemachine
            gnuplot-mode
            god-mode
            google-translate
            goto-chg
            graphviz-dot-mode
            helm
            helm-ag
            helm-bibtex
            helm-core
            helm-firefox
            helm-flycheck
            helm-flyspell
            helm-gtags
            helm-projectile
            helm-swoop
            helm-unicode
            highlight-symbol
            hungry-delete
            ido-at-point
            ido-hacks
            ido-vertical-mode
            imenu-anywhere
            lacarte
            latex-preview-pane
            let-alist
            magic-latex-buffer
            magit
            magit-popup
            math-symbol-lists
            matlab-mode
            multifiles
            multiple-cursors
            names
            nyan-mode
            operate-on-number
            outline-magic
            paredit
            paredit-everywhere
            parsebib
            peep-dired
            pinyin-search
            pkg-info
            popup
            popup-kill-ring
            popwin
            pos-tip
            projectile
            rainbow-delimiters
            readline-complete
            recentf-ext
            rich-minority
            s
            session
            smart-mode-line
            smartrep
            smex
            switch-window
            tangotango-theme
            tree-mode
            undo-tree
            use-package
            visible-mark
            visual-regexp
            vlf
            w3m
            which-key
            windata
            window-numbering
            with-editor
            wrap-region
            yasnippet
            zotelo
            ztree)
          (cond
           (is-lin '(fcitx
                     pdf-tools
                     tablist))
           (is-win '(w32-browser
                     mingus))))
  "A list of packages to ensure are installed at launch.")
(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (cl-every #'package-installed-p prelude-packages))
(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))
(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))
(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-packages)))
;; run package installation
(prelude-install-packages)
;; ====================elpa=========================
;; =================USE-PACKAGE=====================
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;; =================USE-PACKAGE=====================
(provide 'setup_elpa)

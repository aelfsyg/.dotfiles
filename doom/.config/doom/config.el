;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq settings
      '(("phobos" . ((mono-font-size . 20)
                     (var-font-size . 28)))
        ("luna" . ((mono-font-size . 20)
                     (var-font-size . 28)))
        ("mars" . ((mono-font-size . 18)
                     (var-font-size . 20)))
        ("europa" . ((mono-font-size . 18)
                     (var-font-size . 24)))
        ("ceres" . ((mono-font-size . 16)
                     (var-font-size . 18)))))

(defun fetch-setting (setting)
  (cdr (assoc setting
              (cdr (assoc (system-name) settings)))))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Aelfsyg"
      user-mail-address "aelfsyg@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font
      (font-spec :family "Fira code"
                 :size (fetch-setting 'mono-font-size)
                 ;; :weight 'semi-light
                 )
      doom-variable-pitch-font
      (font-spec :family "CMU Serif"
                 :size (fetch-setting 'var-font-size)
                 ;; :weight 'semi-light
                 ))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-tomorrow-night)
(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ;; Backups
;; (setq backup-directory-alist '(("." . "~/.emacs-saves")))
;; (setq backup-by-copying nil)

;; Bang.el
(setq bang-roam-support t)
(after! org
  (require 'bang))

;; Bicep
(require 'bicep-mode)

;; Browser
(setq browse-url-browser-function 'browse-url-firefox
      browse-url-generic-program "firefox")

;; C/C++
(setq c-default-style "k&r"
      c-basic-offset 4)

;; Centered mode
(global-centered-cursor-mode t)

;; Copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         ("<right>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; Dired
(setq dired-listing-switches "-aBGh --group-directories-first")
(setq ranger-show-hidden t)

;; Elfeed
(setq rmh-elfeed-org-files '("~/org/rss/elfeed.org"))
(setq elfeed-db-directory "~/org/rss/db/")
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(setq elfeed-goodies/feed-source-column-width 24)

;; Helm
(setq helm-case-fold-search t)

;; Input mode
(add-hook 'text-mode-hook (lambda () (set-input-method 'TeX)))

;; Java
(setq meghanada-auto-start nil)

;; Latex
(after! org
  (setq org-startup-with-latex-preview t)
  (setq org-latex-create-formula-image-program 'dvisvgm)
  (setq org-format-latex-options
        '(:foreground default
          :background default
          :scale 0.5
          :html-foreground "Black"
          :html-background "Transparent"
          :html-scale 1.0
          :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))

;; Lispyville
(map! :map clojure-mode-map
      "C-h" #'lispyville-backward-sexp
      "C-l" #'lispyville-forward-sexp)

;; LSP
(setq lsp-ui-doc-enable nil)

;; Mixed-pitch
(add-hook 'org-mode-hook 'mixed-pitch-mode)
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; ;; Nov.el
(after! org
  (require 'nov)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (defun my-nov-font-setup ()
    (face-remap-add-relative
     'variable-pitch
     :family "CMU Serif"
     :height 1.2))
  (add-hook 'nov-mode-hook 'my-nov-font-setup)
  (add-hook 'nov-mode-hook 'visual-line-mode))

;; Org
(after! org
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/refile.org")
  (setq org-roam-directory "~/org/roam")

  (setq org-startup-indented t)

  ;; Org > Agenda
  (setq org-agenda-files
        (append (list org-directory)
                `("~/org/private" "~/org/blog" "~/org/missing")
                (directory-files org-directory 'full (rx "client-"))))
  (setq org-agenda-start-day "-1d")
  (setq org-agenda-span 7)
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("c" . "My Custom Agenda")
          ("cu" "Unscheduled TODO"
           ((todo ""
                  ((org-agenda-overriding-header "\nUnscheduled TODO")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
           nil
           nil)))

  ;; Org > Archiving
  (setq org-archive-location ".archive/%s_archive::")

  ;; Archive subtree, preserving structure
  ;; https://github.com/daviderestivo/galactic-emacs/blob/master/lisp/org-archive-subtree.el
  (require 'dash)
  (defadvice org-archive-subtree (around fix-hierarchy activate)
    (let* ((fix-archive-p (and (not current-prefix-arg)
                               (not (use-region-p))))
           (afile  (car (org-archive--compute-location
                         (or (org-entry-get nil "ARCHIVE" 'inherit) org-archive-location))))
           (buffer (or (find-buffer-visiting afile) (find-file-noselect afile))))
      ad-do-it
      (when fix-archive-p
        (with-current-buffer buffer
          (goto-char (point-max))
          (while (org-up-heading-safe))
          (let* ((olpath (org-entry-get (point) "ARCHIVE_OLPATH"))
                 (path (and olpath (split-string olpath "/")))
                 (level 1)
                 tree-text)
            (when olpath
              (org-mark-subtree)
              (setq tree-text (buffer-substring (region-beginning) (region-end)))
              (let (this-command) (org-cut-subtree))
              (goto-char (point-min))
              (save-restriction
                (widen)
                (-each path
                  (lambda (heading)
                    (if (re-search-forward
                         (rx-to-string
                          `(: bol (repeat ,level "*") (1+ " ") ,heading)) nil t)
                        (org-narrow-to-subtree)
                      (goto-char (point-max))
                      (unless (looking-at "^")
                        (insert "\n"))
                      (insert (make-string level ?*)
                              " "
                              heading
                              "\n"))
                    (cl-incf level)))
                (widen)
                (org-end-of-subtree t t)
                (org-paste-subtree level tree-text))))))))

  ;; Org > Babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t)
     (dot . t)
     (ditaa . t)
     (plantuml . t)))

  ;; Org > Bullets
  ;; ⟶ → ⇉ ⇶ ⇾ ⇢ ↠ ↦ ⟼ ⟾ ↣ ⟹ ⇒ ⇛ ⇨ ⇴ ⇻ '("⁖" "◉" "○" "✸" "✿")
  (setq org-superstar-headline-bullets-list '("→"))

  ;; Org > Capture
  (setq org-capture-templates
        `(("c" "Capture" entry
           (file ,org-default-notes-file)
           "* MOVE %?")
          ("p" "Private" entry
           (file "~/org/private/refile.org")
           "* MOVE %?")
          ("s" "Standup" entry
           (file+olp "~/org/client-x/tickets.org" "Diary")
           "** %u\n*** Tasks\n*** Standup\n**** Yesterday\n%?\n**** Today")
          ("k" "Call" entry
           (file+headline "~/org/client-n/calls.org" "Calls")
           "* CALL %U\n%?")))
  ;; (add-hook 'org-capture-mode-hook 'evil-insert-state)

  ;; ;; Org > Cycle
  ;; (setq org-tab-first-hook
  ;;       (delete '+org-cycle-only-current-subtree-h org-tab-first-hook))

  ;; Org > Fragtog
  (add-hook 'org-mode-hook 'org-fragtog-mode)

  ;; Org > Goto
  (setq org-goto-interface 'outline-path-completion)

  ;; Org > Headings
  (setq org-blank-before-new-entry
        '((heading . nil)
          (plain-list-item . nil)))

  ;; Org > Log
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; Org > Roam > Capture
  (setq org-roam-capture-templates
        '(("r" "Roam" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)))
  (setq org-roam-capture-ref-templates
        '(("r" "Roam" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)))

  ;; Org > Tags
  (setq org-tags-column 0)

  ;; Org > Todo
  (setq org-todo-keywords
        '((sequence
           "TODO(t)" "INIT(i)" "MOVE(m)" "WAIT(w)"
           "|"
           "DONE(d)" "KILL(k)" "CALL(c)")))

  (setq org-todo-keyword-faces
        '(("TODO" . "SlateGray")
          ("MOVE" . "DarkOrchid")
          ("WAIT" . "Firebrick")
          "|"
          ("DONE" . "ForestGreen")
          ("KILL" . "gray")
          ("CALL" . "OrangeRed3")))
  )

;; Org > Cycle
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; PlantUML
(after! org
  (require 'plantuml-mode)
  (setq org-plantuml-jar-path "/home/dare/bin/plantuml-1.2021.13.jar")
  (setq org-plantuml-executable-path "plantuml")
  (setq org-plantuml-exec-mode 'executable)
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

;; Projectile
(setq projectile-enable-caching nil)
(setq projectile-find-dir-includes-top-level t)
(setq projectile-project-search-path '("~/src/" "~/ext/" "~/org/"))

;; Read-time
(require 'read-time)
(setq read-time-words-per-sec 10)

;; Spelling
(setq ispell-dictionary "british-ise-w_accents")

;; Svelte
(require 'svelte-mode)

;; Uniquify
(toggle-uniquify-buffer-names t)

;; Yasnippet
(map! "M-'" #'yas/expand)

;; Vimrc
(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; Visual-line-mode
;; Make movement keys work like they should
;; (map! :map visual-line-mode-map
;;       "j" #'evil-next-visual-line
;;       "k" #'evil-previous-visual-line)
;; Make horizontal movement cross lines
;; (setq-default evil-cross-lines t)

;; Word wrap
;; (+global-word-wrap-mode +1)

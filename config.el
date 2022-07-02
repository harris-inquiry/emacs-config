;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Harrison Quarry"
      user-mail-address "harrisonqleddy@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Menlo" :size 16 :weight 'normal)
     doom-variable-pitch-font (font-spec :family "Menlo" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-one-brighter-comments t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/") ;; default
(setq org-directory "~/BRAIN/Dashboard/today/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq scroll-conservatively 0)
(setq scroll-step 5)
(setq scroll-margin 0)
(setq scroll-down-aggressively 0.1)


;; Remapping normal vim-emacs bindings
(map! :iv "C-c" #'evil-normal-state
      :m "-" #'evil-end-of-visual-line
      ;; faster scrolling
      :m "C-e" (cmd! (evil-scroll-line-down 5))
      :m "C-y" (cmd! (evil-scroll-line-up 5))

      ;; Remove 'evil-mode' vim rebindings
      :n "C-n" nil
      :n "C-p" nil
      :m "C-b" nil
      :m "C-f" nil

      ;; jump back with 'Ctrl+-'
      :n "C--" nil
      :m "C--" #'better-jumper-jump-backward

      ;; remove 'company' rebinding
      :i "C-x C-s" nil)




(map! :after (evil-org evil-easymotion)
      :map evil-org-mode-map
      :i "C-k" #'org-kill-line)


(add-hook! org-mode
  (defun my-disable-company-mode ()
    (company-mode -1)) ;; no auto-correct in org-mode
  )


;; TODO -- question capture
(defun quarry/set-org-capture-templates ()
    (setq org-capture-templates
          '(("t" "Personal todo" entry
             (file+headline +org-capture-todo-file "Inbox")
             "* [ ] %?\n%i\n%a" :prepend t)
            ("n" "Personal notes" entry
             (file+headline +org-capture-notes-file "Inbox")
             "* %u %?\n%i\n%a" :prepend t)
            ("j" "Journal" entry
             (file+olp+datetree +org-capture-journal-file)
             "* %U %?\n%i\n%a" :prepend t)

            ("p" "Templates for projects")
            ("pt" "Project-local todo" entry
             (file+headline +org-capture-project-todo-file "Inbox")
             "* TODO %?\n%i\n%a" :prepend t)
            ("pn" "Project-local notes" entry
             (file+headline +org-capture-project-notes-file "Inbox")
             "* %U %?\n%i\n%a" :prepend t)
            ("pc" "Project-local changelog" entry
             (file+headline +org-capture-project-changelog-file "Unreleased")
             "* %U %?\n%i\n%a" :prepend t)

            ("o" "Centralized templates for projects")
            ("ot" "Project todo" entry
             #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
            ("on" "Project notes" entry
             #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
            ("oc" "Project changelog" entry
             #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))))


;; TODO -- bigger startup window


;; TODO -- yas-snippet for '+qdd' blocks -> tracking important questions in org-files


;; DONE -- setting js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js[mx]?\\'" . js2-mode))
       auto-mode-alist))


;; Additional settings
(load! "+open-file-in-journal")

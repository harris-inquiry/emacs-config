;;; explore/evil-org-mode.el -*- lexical-binding: t; -*-

;; es. Trying to make "C-k" work in org-mode
;; (which was overshadowed by 'org-up-element' somehow)
;;
;; Only solution I found was to completely deactivate evil-org-mode


;; DONE -- This works!
(map! :after (evil-org evil-easymotion)
      :map evil-org-mode-map
      :i "C-k" #'org-kill-line)



;; Start Solution --
(defun quarry-solution-deactivate ()
  (add-hook! evil-org-mode
    (defun quarry-deactivate-evil-org-mode ()
      (if evil-org-mode
          (evil-org-mode -1)))))
;; End


;; nope
(after! (org-mode evil-org-mode evil evil-org)
  (evil-org-mode -1))

;; nope
(after! (org-mode evil-org-mode evil evil-org evilorg)
  (lambda () (evil-org-mode -1)))

;; nope
(add-hook! (org-mode evil-org-mode evil evil-org)
  (lambda () (evil-org-mode -1)))


;; testing??
(use-package! evil-org-mode
  :commands (evil-org-mode)
  :defer t
  :config
  (evil-org-mode -1)
  )


;; nope
(map! :map evil-org-mode-map
      :n "C-k" #'org-up-element
      :i "C-k" #'org-kill-line)


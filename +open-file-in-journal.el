;;; explore/open-file-in-journal.el -*- lexical-binding: t; -*-

;; es. Want a function for quickly opening files in my 'org-directory'

(defun quarry/find-file-in-org-directory ()
  "Search for a file in personal 'org-directory'"
  (interactive)
  (doom-project-find-file org-directory)
  )

;; then probably map this to some keyboard short cut
(map! :leader "f ." #'quarry/find-file-in-org-directory)


;; Similar function: 'doom/find-file-in-private-config'

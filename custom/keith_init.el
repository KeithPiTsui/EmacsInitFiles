
;;; Setup pdf-tools package
(load "keith_packages_pdf-tools.el")

;;; Display line number on the left
(global-display-line-numbers-mode)

;;; Show column and row number in mode line)
(setq column-number-mode t)
(setq global-linum-mode t)

;;; Setup frame size.
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 120))
          (add-to-list 'default-frame-alist (cons 'width 80)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 200)
                                      (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; Setup http proxy
(setq url-proxy-services
     '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
       ("http" . "192.168.1.31:1087")
       ("https" . "192.168.1.31:1087")))

(defun sudo ()
  "Use TRAMP to 'sudo' the current buffer"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

;; Set global keys for some commands for org-mode.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; Look up a word on wikipedia.
(autoload 'ispell-get-word "ispell")

(defun lookup-word (word)
  (interactive (list (save-excursion (car (ispell-get-word nil)))))
  (browse-url (format "http://en.wiktionary.org/wiki/%s" word)))

(global-set-key (kbd "M-#") 'lookup-word)


;; load llvm-mode
(load "llvm-mode.el")

;; load llvm tablegen-mode
(load "tablegen-mode.el")


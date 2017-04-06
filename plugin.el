;; Package-Requires:

(require 'web-mode)
(require 's)

(defvar narrow-mode-map
  (make-keymap))

(define-key
  narrow-mode-map
  (kbd "C-c C-k")
  (lambda () (interactive) (kill-buffer (current-buffer))))


(define-minor-mode
  narrow-mode
  "in narrow-mode can quickly quit"
  :lighter " narrow"
  :keymap narrow-mode-map)


;; from end to begin
(defun --mark-block
    ()
  (interactive)
  (backward-up-list)
  (set-mark-command nil)
  (forward-list))

(defun web-narrow-to-element
    ()
  (interactive)
    (let (
          (buf (clone-indirect-buffer nil nil))
          (begin (save-excursion
                   (goto-char (web-mode-element-beginning-position))
                   (line-beginning-position)))
          (end (+ 1 (web-mode-element-end-position))))
      (web-narrow-to-region-raw begin end)))

(defun web-narrow-to-block
    ()
  (interactive)
  (save-excursion
    (let ((begin (progn
                   (backward-up-list)
                   (line-beginning-position)))
          (end (progn
                 (forward-list)
                 (point))))
      (web-narrow-to-region-raw begin end))))



(defun web-narrow-to-region-raw
    (start end)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end)
      (switch-to-buffer buf)
      (narrow-mode))))

(defun web-narrow-to-region
    (begin end)
  (interactive "r")
  (web-narrow-to-region-raw begin end))

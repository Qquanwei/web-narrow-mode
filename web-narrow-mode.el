;;; web-narrow-mode.el --- quick narrow code block in web-mode
;;; web-narrow-mode.el narrow your code with new buffer

;; Copyright (C) 2017 Quanwei

;; Author: Qquanwei <quanwei9958@126.com>
;; Maintainer: Johan Andersson <quanwei9958@126.com>
;; Version: 0.1.0
;; Keywirds: web-mode,react,narrow,web
;; URL: https://github.com/Qquanwei/web-narrow-mode
;; Package-Requires: ((web-mode "14.0.27"))

;; This file is NOT part of GNUN Emacs

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Code:

(require 'web-mode)

(defvar narrow-mode-map
  (make-keymap))

(defvar web-narrow-mode-map (make-sparse-keymap))

(define-key web-narrow-mode-map (kbd "C-c C-u u") 'web-narrow-to-element)
(define-key web-narrow-mode-map (kbd "C-c C-u j") 'web-narrow-to-block)
(define-key web-narrow-mode-map (kbd "C-c C-u l") 'web-narrow-to-region)

(define-key
  narrow-mode-map
  (kbd "C-c C-k")
  (lambda () (interactive) (kill-buffer (current-buffer))))


(define-minor-mode
  narrow-mode
  "in narrow-mode can quickly quit"
  :lighter " narrow"
  :keymap narrow-mode-map)

(define-minor-mode
  web-narrow-mode
  "web-narrow split your code"
  :lighter " wnarrow"
  :keymap web-narrow-mode-map)

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



(defsubst web-narrow-to-region-raw
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

(provide 'web-narrow-mode)

;;; web-narrow-mode.el ends here

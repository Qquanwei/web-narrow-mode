[![MELPA](https://melpa.org/packages/web-narrow-mode-badge.svg)](https://melpa.org/#/web-narrow-mode)

# web-narrow-mode

web-narrow is a minor mode for emacs . it will help edit hybrd format file. sach as `jsx` or `vue`

[![asciicast](https://asciinema.org/a/96m0wv5iplqp3u1kft0ge73rp.png)](https://asciinema.org/a/96m0wv5iplqp3u1kft0ge73rp)


inspire from http://demonastery.org/2013/04/emacs-narrow-to-region-indirect/

## install & setup

(add-hook 'web-mode-hook 'web-narrow-mode)

## keymap

some default keymap for web-narrow-mode

* `C-c C-u u` web-narrow-to-element : narrow a html element to buffer
* `C-c C-u j` web-narrow-to-block : narrow content with in `{...}`
* `C-c C-u l` web-narrow-to-region : narrow region

when you narrowed your code. will set `narrow-mode` in that buffer.

## narrow-mode

keymap

* `C-c C-k` quit current edit(narrowed), same as `kill-buffer`

(require 'package)
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)

; (load-file "~/.emacs.d/rtags/src/rtags.el")
; (setq rtags-rdm-binary-name "~/.emacs.d/rtags/bin/rdm")
; (setq rtags-rc-binary-name "~/.emacs.d/rtags/bin/rc")

(require 'auto-complete-config)
(ac-config-default)
(setq-default ac-ignore-case nil)

(load-file "~/.emacs.d/termbin.el")

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'jedi)
(add-to-list 'ac-sources 'ac-source-jedi-direct)

(require 'ac-php)
(add-to-list 'ac-sources 'ac-sources-php)

; (require 'ac-rtags)
; (add-to-list 'ac-sources 'ac-sources-rtags)

(require 'ido)
(ido-mode t)

(yas-global-mode)
(menu-bar-mode -1)

;; что это?
;; https://youtu.be/6BlTGPsjGJk?t=21m19s
(setq ac-show-menu-immediately-on-auto-complete t)

(setq csv-separators '(","))  ;; csv-align-fields, если че


(defun xah-user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
Typically, if buffer name starts with *, it's not considered a user buffer.
This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
You can override this function to get your idea of “user buffer”.
version 2016-06-18"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t
      )))

(defun xah-next-user-buffer ()
  "Switch to the next user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-previous-user-buffer ()
  "Switch to the previous user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))


;; Спасибо этому ресурсу: https://emacsredux.com/blog/2013/04/02/move-current-line-up-or-down/
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode)
  )

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode)
  )

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )

(defun list-definitions-python ()
  (interactive)
  (occur "class\\|def")
  )

(defun kill-this-buffer-delete-window ()
  (interactive)
  (kill-this-buffer)
  (delete-window)
  )

(defun set-nano-like-config (map)
  (interactive)
  (define-key isearch-mode-map "\C-w" 'isearch-repeat-forward)
  (setq whitespace-style '(space-mark tab-mark))
  (define-key map (kbd "M-p") 'whitespace-mode)
  (define-key map (kbd "C-k") 'kill-whole-line)
  (define-key map (kbd "C-u") 'yank)
  (define-key map (kbd "C-o") 'save-buffer)
  (define-key map (kbd "M-,") 'xah-previous-user-buffer)
  (define-key map (kbd "M-.") 'xah-next-user-buffer)
  (define-key map (kbd "C-w") 'isearch-forward)
  (define-key map (kbd "C-r") 'find-file)
  (define-key map (kbd "C-_") 'goto-line)
  (define-key map (kbd "C-\\") 'query-replace)
  (define-key map (kbd "M-i") 'electric-indent-mode)
  )

(defun set-my-binds (map)
  (interactive)
  (set-nano-like-config map)
  (define-key map (kbd "C-d") 'duplicate-line)
  (define-key map (kbd "<M-left>") 'ido-switch-buffer)
  (define-key map (kbd "<M-right>") 'ace-window)
  (define-key map (kbd "M-k") 'kill-this-buffer)
  (define-key map (kbd "M-l") 'list-buffers)
  (define-key map (kbd "C-M-k") 'kill-line)
  (define-key map (kbd "C-x d") 'kill-this-buffer-delete-window)
  (define-key map (kbd "<M-f9>") 'eshell)
  (define-key map (kbd "<C-M-down>") 'move-line-down)
  (define-key map (kbd "<C-M-up>") 'move-line-up)
  (define-key map (kbd "<M-f6>") 'yf/termbin-region)
  )

(set-my-binds global-map)

;; https://www.emacswiki.org/emacs/CuaMode
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(setq-default indent-tabs-mode nil)
(setq nxml-child-indent 4 nxml-attribute-indent 4)


;; не надо сохранять все в рабочей директории
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(add-hook
 'before-save-hook
 'delete-trailing-whitespace
 )

(add-hook
 'js-mode-hook
 (lambda ()
   (set-my-binds js-mode-map)
   (define-key js-mode-map (kbd "C-p") 'js2-jump-to-definition)
   (setq js-indent-level 4)
   (flycheck-mode)
   ))

(add-hook
 'python-mode-hook
 (lambda()
   (jedi:setup)
   (set-my-binds python-mode-map)
   (flycheck-mode)
   (define-key python-mode-map (kbd "C-p") 'jedi:goto-definition)
   (define-key python-mode-map (kbd "C-j") 'jedi:show-doc)
   (define-key python-mode-map (kbd "C-M-p") 'jedi:goto-definition-pop-marker)
   (define-key python-mode-map (kbd "<f9>") 'list-definitions-python)
   ))

(add-hook
 'php-mode-hook
 (lambda()
   (auto-complete-mode 1)
   (set-my-binds php-mode-map)
   (define-key php-mode-map (kbd "C-p") 'ac-php-find-symbol-at-point)
   (define-key php-mode-map (kbd "C-M-p") 'ac-php-location-stack-back)
   (define-key php-mode-map (kbd "C-j") 'ac-php-show-tip)
   (define-key php-mode-map (kbd "<f12> 1") 'ac-php-remake-tags-all)
   ))

(add-hook
 'web-mode-hook
 (lambda()
   ))

(add-hook
 'c-mode-hook
 (lambda ()
   (rtags-start-process-unless-running)
   (set-my-binds c-mode-map)
   (define-key c-mode-map (kbd "C-p") 'rtags-find-symbol-at-point)
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ac-rtags magit js2-mode dockerfile-mode flycheck web-mode rust-mode ac-php yaml-mode yasnippet-classic-snippets virtualenvwrapper php-mode jedi csv-mode ace-window)))
 '(safe-local-variable-values
   (quote
    ((backward-delete-char-untabify-method quote hungry)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

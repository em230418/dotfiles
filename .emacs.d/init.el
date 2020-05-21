(require 'package)
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(require 'auto-complete-config)
(ac-config-default)

(require 'jedi)
(add-to-list 'ac-sources 'ac-source-jedi-direct)

(require 'ac-php)
(add-to-list 'ac-sources 'ac-sources-php)

(require 'ido)
(ido-mode t)

(yas-global-mode)
(menu-bar-mode -1)

;; что это?
;; https://youtu.be/6BlTGPsjGJk?t=21m19s
(setq ac-show-menu-immediately-on-auto-complete t)

(setq csv-separators '(","))  ;; csv-align-fields, если че


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
  (define-key map (kbd "M-,") 'previous-buffer)
  (define-key map (kbd "M-.") 'next-buffer)
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
  (define-key map (kbd "<C-M-down>") 'move-line-down)
  (define-key map (kbd "<C-M-up>") 'move-line-up)
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
   ))

(add-hook
 'python-mode-hook
 (lambda()
   (jedi:setup)
   (set-my-binds python-mode-map)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode flycheck web-mode rust-mode ac-php yaml-mode yasnippet-classic-snippets virtualenvwrapper php-mode jedi csv-mode ace-window)))
 '(safe-local-variable-values
   (quote
    ((backward-delete-char-untabify-method quote hungry)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

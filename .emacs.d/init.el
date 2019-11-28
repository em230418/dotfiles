(require 'package)
(add-to-list 'package-archives '("elpa" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(require 'auto-complete-config)
(ac-config-default)

(require 'jedi)
(add-to-list 'ac-sources 'ac-source-jedi-direct)

;; что это?
;; https://youtu.be/6BlTGPsjGJk?t=21m19s
(setq ac-show-menu-immediately-on-auto-complete t)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
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
  (define-key map (kbd "C-M-k") 'kill-line))

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
   (define-key python-mode-map (kbd "C-i") 'jedi:show-doc)
   (define-key python-mode-map (kbd "C-M-p") 'jedi:goto-definition-pop-marker)
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((backward-delete-char-untabify-method quote hungry)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

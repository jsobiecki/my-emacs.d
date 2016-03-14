(require-package 'php-mode)
(require-package 'auto-complete)
(require-package 'flycheck)
(require-package 'ac-php)
(require-package 'ggtags)
(require-package 'php-auto-yasnippets)
(require-package 'php-refactor-mode)
(require-package 'drupal-mode)
(require-package 'geben)
(require-package 'php-extras)


(require 'php-auto-yasnippets)
(require 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)


(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)

;; Debug a simple PHP script.
;; Change the session key my-php-54 to any session key text you like
(defun my-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
    (concat "XDEBUG_CONFIG='idekey=my-php-54'"
    (buffer-file-name) " &"))
  )

(global-set-key [f5] 'my-php-debug)


(setq drupal-get-function-args t)
(setq json-encoding-pretty-print t)
(add-hook 'drupal-mode-hook
          '(lambda ()
             (when (apply 'derived-mode-p drupal-php-modes)
               (flycheck-mode t)
               )))
(add-hook 'find-file-hook 'auto-insert)

(add-hook 'php-mode-hook '(lambda ()
                           (auto-complete-mode t)
                           (require 'ac-php)
                           (setq ac-sources  '(ac-source-php ) )
                           (yas-global-mode 1)

                           (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
                           (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
                           (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)

			   (ggtags-mode 1)
                           (payas/ac-setup)
                           ))



(provide 'init-php)

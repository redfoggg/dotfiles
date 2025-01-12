;; -------------------------------------------------- configurações de packages --------------------------------------------------
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'exec-path "/home/linuxbrew/.linuxbrew/bin")
;(print (getenv "JAVA_HOME"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Configurar lsp-mode
(use-package lsp-mode
  :ensure t
  :hook
  ((clojure-ts-mode . lsp)
   (clojurec-ts-mode . lsp)
   (python-ts-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands lsp
  :custom
  (lsp-enable-snippet nil) ; Desativar snippets (opcional)
  (lsp-enable-on-type-formatting nil)) ; Desativar formatação em tempo real (opcional))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Configurar lsp-ui para funcionalidades adicionais
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t) ; Habilitar documentação flutuante
  (lsp-ui-sideline-enable t) ; Habilitar informações na sideline
  (lsp-ui-peek-enable t)) ; Habilitar navegação de código

;; Configurar company-mode para autocompletar
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.5) ; Tempo de espera para autocompletar
  (company-minimum-prefix-length 1)) ; Número mínimo de caracteres para autocompletar

;; Configurar flycheck para verificação de erros
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; --------------------------------------------- configurações pessoais -------------------------------------------------------------------------

(global-set-key (kbd "C-:") 'avy-goto-char-2)

(setq backup-directory-alist `(("." . "~/.saves")))

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; ativa ido o fuzzy search do emacs
(require 'ido)
(ido-mode t)

(load-theme 'doom-xcode t)

(add-to-list 'default-frame-alist
             '(font . "CaskaydiaCove NF-13"))
;; Enable the www ligature in every possible major mode
(ligature-set-ligatures 't '("www"))

(ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

(global-ligature-mode 't)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "7758a8b8912ef92e8950a4df461a4d510484b11df0d7195a8a3d003965127abc"
     "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69"
     default))
 '(major-mode-remap-alist
   '((python-mode . python-ts-mode) (clojure-mode . clojure-ts-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


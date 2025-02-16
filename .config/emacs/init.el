;; -------------------------------------------------- configurações de packages --------------------------------------------------
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'exec-path "/home/linuxbrew/.linuxbrew/bin")

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq cider-eldoc-display-for-symbol-at-point nil) ; disable cider showing eldoc during symbol at point

;; Configurar lsp-mode
(use-package lsp-mode
  :ensure t
  :hook
  ((clojure-ts-mode . lsp)
   (clojurec-ts-mode . lsp)
   (python-ts-mode . lsp)
   (dockerfile-ts-mode . lsp)
   (elixir-ts-mode . lsp)
   )
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
  (lsp-ui-doc-focus-frame t)
  (lsp-ui-doc-position 'at-point)
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

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

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
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(load-theme 'gruber-darker t)

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

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(setq custom-file "~/.config/emacs/custom.el")
(load-file custom-file)


;;; init.el --- My init.el

;;; Commentary:

;; hoge

;;; Code

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)

  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    ;; (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    ;; (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

;; https://emacs-jp.github.io/tips/emacs-in-2020

(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))
  (set-frame-font "Inconsolata-24" nil t)
  (when (eq system-type 'darwin)
    (setq ns-command-modifier (quote meta)))
  (defun other-window-or-split ()
    (interactive)
    (when (one-window-p)
      (split-window-horizontally))
    (other-window 1))
  :bind '(
          ("C-h" . delete-backward-char)
          ("M-ESC ESC" . c/redraw-frame)
          ("C-t" . other-window-or-split))
  :custom '(
            ;; (user-full-name . "")
            ;; (user-mail-address . "")
            ;; (user-login-name . "")
            (debug-on-error . t)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)
            (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            ;; (use-dialog-box . nil)
            ;; (use-file-dialog . nil)
            (menu-bar-mode . t)
            (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (inhibit-startup-screen . t)
            (indent-tabs-mode . nil)
            (auto-save-default . nil)
            (make-backup-files . nil)
            (create-lockfiles . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  :global-minor-mode global-auto-revert-mode global-linum-mode global-visual-line-mode
)

(leaf modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi :no-confirm)
)

(leaf recentf
  :ensure t
  :custom
  (recentf-save-file . "~/.emacs.d/recentf")
  (recentf-max-saved-items . 1000)
  (recentf-exclude . '("recentf"))
  :config
  (recentf-mode 1)
  :bind
  ("C-;" . recentf-open-files)
)

(leaf magit
  :ensure t
  :bind '(
          ("C-c s" . magit-status)))

(leaf yaml-mode
  :ensure t
)

(leaf super-save
  :ensure t
  :config
  (super-save-mode +1)
  :custom
  (super-save-auto-save-when-idle . t)
  (super-save-idle-duration . 2)
)

(leaf undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  :custom
  (undo-tree-history-directory-alist . '(("." . "~/.emacs.d/undo/")))
)

(leaf sequential-command
  :ensure t
  :require sequential-command-config
  :bind '(
          ("C-a" . 'seq-home)
          ("C-e" . 'seq-end))
)

(leaf auto-async-byte-compile
  :ensure t
  :custom
  (auto-async-byte-compile-exclude-files-regexp . "/junk/")
  :hook emacs-lisp-mode-hook
)

(leaf open-junk-file
  :ensure t
  :custom
  (open-junk-file-format . "~/.emacs.d/junk/%Y/%m/%Y-%m-%d-%H%M%S."))

;; (leaf adaptive-wrap
;;   :ensure t)


(provide 'init)
;;; init.el ends here

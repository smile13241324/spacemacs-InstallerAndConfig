;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     nim
     scheme
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.0
                      auto-completion-private-snippets-directory nil
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t)
     better-defaults
     (clojure :variables
              clojure-enable-fancify-symbols t)
     gpu
     graphviz
     (plantuml :variables
               plantuml-jar-path "~/.plantuml/plantUml.jar"
               org-plantuml-jar-path "~/.plantuml/plantUml.jar")
     salt
     ibuffer
     emacs-lisp
     pdf-tools
     cscope
     gtags
     (org :variables
          org-want-todo-bindings t
          org-enable-github-support t
          org-enable-bootstrap-support t
          org-enable-reveal-js-support t)
     (shell :variables
            shell-enable-smart-eshell t
            shell-default-shell 'ansi-term
            shell-default-height 60
            shell-default-position 'bottom
            shell-default-full-span nil
            shell-default-term-shell "/usr/bin/fish")
     syntax-checking
     version-control
     semantic
     ;; semweb
     themes-megapack
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-enable-clang-support t
            c-c++-enable-clang-format-on-save t)
     git
     github
     sml
     pass
     common-lisp
     (python :variables
             python-test-runner 'pytest
             python-enable-yapf-format-on-save t
             python-sort-imports-on-save t)

     windows-scripts
     agda
     jr
     shell-scripts
     emoji
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     bibtex
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-magic t
            latex-enable-folding t)
     lua
     html
     (javascript :variables
                 javascript-disable-tern-port-files nil)
     react
     yaml
     nginx
     docker
     csv
     search-engine
     restclient
     restructuredtext
     selectric
     octave
     systemd
     imenu-list
     (java :variables
           java-backend 'meghanada)
     groovy
     (go :variables
         go-use-gometalinter t
         gofmt-command "goimports"
         go-tab-width 4
         go-use-gocheck-for-testing t
         go-use-test-args "-race -timeout 10s")
     major-modes
     coq
     django
     (elm :variables
          elm-sort-imports-on-save t
          elm-format-on-save t)
     ;; (ess :variables
     ;;      ess-enable-smart-equals t)
     idris
     (haskell :variables
              haskell-enable-hindent-style "fundamental"
              haskell-completion-backend 'dante)
     pandoc
     sphinx
     parinfer
     asciidoc
     ansible
     cfengine
     puppet
     rebox
     rust
     xkcd
     typography
     vimscript
     (terraform :variables
                terraform-auto-format-on-save t)
     (ruby :variables
           ruby-enable-enh-ruby-mode t
           ruby-version-manager 'rvm)
     ruby-on-rails
     asm
     (sql :variables
          sql-capitalize-keywords t)
     perl6
     autohotkey
     (elixir :variables
             flycheck-elixir-credo-strict t)
     faust
     vagrant
     erlang
     protobuf
     php
     racket
	 (colors :variables 
			  colors-colorize-identifiers 'all)
     (typescript :variables
                 typescript-fmt-tool 'typescript-formatter
                 typescript-fmt-on-save t))

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 60
   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default nil)
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 50)
                                (projects . 15)
                                (agenda . 10)
                                (todos . 20))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(leuven)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 17
                               :weight normal
                               :width normal
                               :powerline-scale 1.5)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, `J' and `K' move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text t
   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 50
   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non-nil, the paste transient-state is enabled. While enabled, pressing
   ;; `p' several times cycles through the elements in the `kill-ring'.
   ;; (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.0
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 100
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 100
   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis t
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"
   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all
   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil
   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))


(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first.")


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;; Setup robot mode
  ;; (load-file "~/Documents/robot-mode/robot-mode.el")
  ;; (add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))

  (global-company-mode 1)
  (global-flycheck-mode 1)
  (purpose-mode -1)
  (define-key evil-insert-state-map (kbd "TAB") 'company-complete)
  (define-key evil-insert-state-map (kbd "C-y") 'company-yasnippet)
  (spacemacs/toggle-mode-line-minor-modes-off)

  ;; Add pretty fonts for company
  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

  ;; Set variables for search-engine layer
  (spacemacs/set-leader-keys "s w s" 'engine/search-stack-overflow)
  (spacemacs/set-leader-keys "s w d" 'engine/search-duck-duck-go)
  (spacemacs/set-leader-keys "s w g" 'engine/search-github)
  (spacemacs/set-leader-keys "s w i" 'engine/search-spacemacs-issues)
  (spacemacs/set-leader-keys "s w m" 'engine/search-google-maps)
  (spacemacs/set-leader-keys "s w b" 'engine/search-project-gutenberg)
  (spacemacs/set-leader-keys "s w a" 'engine/search-wolfram-alpha)
  (spacemacs/set-leader-keys "s w w" 'engine/search-wikipedia)

  ;; Activate latex document preview
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; Configure indentation for web mode and react mode to work together
  (setq-default
   ;; js2-mode
   js2-basic-offset 2
   ;; web-mode
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2)
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  ;; Set variable for fish to work as ansi term terminal
  (add-hook 'term-mode-hook 'toggle-truncate-lines)

  ;; Configure org mode
  (with-eval-after-load 'org
    (setq org-agenda-files (quote ("~/Documents/GTD/CalendarActionList.org" "~/Documents/GTD/NextActionList.org" "~/Documents/GTD/ProjectList.org" "~/Documents/GTD/WaitingFor.org")))
    (setq org-refile-targets (quote (("~/Documents/GTD/CalendarActionList.org" :maxlevel . 1)
                                     ("~/Documents/GTD/NextActionList.org" :maxlevel . 1)
                                     ("~/Documents/GTD/ProjectList.org" :maxlevel . 1)
                                     ("~/Documents/GTD/Reference.org" :maxlevel . 1)
                                     ("~/Documents/GTD/SomedayMaybe.org" :maxlevel . 1)
                                     ("~/Documents/GTD/WaitingFor.org" :maxlevel . 1))))
    (setq org-enforce-todo-dependencies t)
    (setq org-enforce-todo-checkbox-dependencies t)
    (setq org-brain-path "~/Documents/GTD")
    (setq org-default-notes-file "~/Documents/GTD/Inbox.org")
    (setq org-archive-location "~/Documents/GTD/Reference.org::* Archived from %s")
    (setq spaceline-org-clock-p t)
    (setq org-capture-templates
          '(("i" "Input" entry (file "")
             "* %? %i")
            ("r" "General reference" entry (file+headline "~/Documents/GTD/Reference.org" "General")
             "* %? %i")))
    (setq org-agenda-skip-scheduled-if-done t)
    (setq org-agenda-skip-deadline-if-done t)
    (setq org-agenda-skip-timestamp-if-done t)
    (setq org-agenda-todo-list-sublevels t)
    (setq org-agenda-todo-ignore-with-date t)
    (setq org-agenda-todo-ignore-deadlines 'all)
    (setq org-agenda-todo-ignore-scheduled 'all)
    (setq org-agenda-todo-ignore-timestamp 'all)
    (setq org-hierarchical-todo-statistics nil)
    (setq org-startup-align-all-tables t)
    (setq org-agenda-restore-windows-after-quit nil)
    (setq org-use-property-inheritance nil)

    ;; Workaround for evil-org missing additional keybindings in insert mode
    (evil-define-key '(normal visual insert) evil-org-mode-map
      (kbd "M-h") 'org-metaleft
      (kbd "M-l") 'org-metaright
      (kbd "M-j") 'org-metaup
      (kbd "M-k") 'org-metadown
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-J") 'org-shiftmetaup
      (kbd "M-K") 'org-shiftmetadown
      (kbd "C-S-h") 'org-shiftcontrolleft
      (kbd "C-S-l") 'org-shiftcontrolright
      (kbd "C-S-j") 'org-shiftcontrolup
      (kbd "C-S-k") 'org-shiftcontroldown))

  ;; org mode sexp to schedule only on work days
  (defun diary-on-working-days ()
    (let ((dayname (calendar-day-of-week date))
          (day (cadr date)))
      (memq dayname '(1 2 3 4 5))))

  ;; Format file on save
  (defun format-for-filetype ()
    "Run clang-format if the current file has a file extensions
   in the filetypes list."
    (let ((filetypes '("c" "cpp" "h" "hpp" "py" "pyc" "robot" "tf")))
      (if (not (member (file-name-extension (buffer-file-name)) filetypes))
          (save-excursion
            (evil-indent (point-min) (point-max))))))
  (add-hook 'before-save-hook 'format-for-filetype)

  ;; Activate line wrap for all text modes
  (add-hook 'text-mode-hook 'spacemacs/toggle-truncate-lines-off)
  (add-hook 'text-mode-hook 'spacemacs/toggle-visual-line-navigation-off))

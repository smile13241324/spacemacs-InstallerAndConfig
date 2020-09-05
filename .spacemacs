;; -*- mode: emacs-lisp; lexical-binding: t -*-
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

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; Configuration layers
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (lsp :variables
          lsp-navigation 'peek)
     dap
     ;; (dart :variables
     ;;       dart-backend 'lsp
     ;;       lsp-dart-sdk-dir "~/Downloads/dart-sdk/")
     helm
     ;; (spell-checking :variables
     ;;                 spell-checking-enable-auto-dictionary t
     ;;                 enable-flyspell-auto-completion t)
     (scala :variables
            scala-backend 'scala-metals)
     (nim :variables
          nim-backend 'company-nim)
     spacemacs-purpose
     elasticsearch
     (yang :variables yang-pyang-rules "ietf")
     ietf
     ;; ocaml
     ;; gtags
     scheme
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-minimum-prefix-length 1
                      auto-completion-idle-delay 0.0
                      auto-completion-private-snippets-directory nil
                      auto-completion-enable-snippets-in-popup nil
                      auto-completion-enable-help-tooltip t
                      auto-completion-use-company-box nil
                      auto-completion-enable-sort-by-usage t)
     syntax-checking
     better-defaults
     (clojure :variables
              clojure-enable-fancify-symbols t
              clojure-enable-sayid t
              clojure-enable-clj-refactor t
              clojure-enable-linters '(clj-kondo joker))
     gpu
     graphviz
     (plantuml :variables
               plantuml-jar-path "~/.plantuml/plantUml.jar"
               org-plantuml-jar-path "~/.plantuml/plantUml.jar")
     salt
     ipython-notebook
     ibuffer
     emacs-lisp
     pdf
     (org :variables
          org-enable-org-journal-support t
          org-want-todo-bindings t
          org-enable-github-support t
          org-enable-bootstrap-support t
          org-enable-reveal-js-support t
          org-enable-hugo-support t
          org-enable-trello-support t
          org-enable-epub-support t
          org-enable-sticky-header nil)
     (shell :variables
            shell-enable-smart-eshell nil
            shell-default-shell 'vterm
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-full-span nil
            shell-default-term-shell "/usr/bin/fish")
     version-control
     import-js
     (cmake :variables
            cmake-enable-cmake-ide-support t
            cmake-backend 'company-cmake)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-backend 'lsp-clangd
            c-c++-lsp-enable-semantic-highlight 'rainbow
            c++-enable-organize-includes-on-save t
            c-c++-lsp-semantic-highlight-method 'overlay
            c-c++-enable-clang-format-on-save t
            c-c++-adopt-subprojects t
            c-c++-enable-auto-newline t)
     web-beautify
     semantic
     templates
     epub
     themes-megapack
     git
     github
     sml
     bm
     (copy-as-format :variables
                     copy-as-format-default "markdown"
                     copy-as-format-asciidoc-include-file-name t)
     pass
     common-lisp
     (python :variables
             python-backend 'lsp
             python-lsp-server 'pyls
             python-test-runner 'pytest
             python-formatter 'lsp
             python-format-on-save t
             python-save-before-test t
             python-sort-imports-on-save t)
     windows-scripts
     jr
     (shell-scripts :variables
                    shell-scripts-backend 'lsp)
     prodigy
     emoji
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     bibtex
     (json :variables
           json-fmt-tool 'web-beautify
           ;; json-backend 'lsp
           json-fmt-on-save t)
     debug
     (latex :variables
            latex-enable-auto-fill t
            latex-enable-magic nil
            latex-enable-folding t)
     lua
     (html :variables
           web-fmt-tool 'web-beautify
           css-enable-lsp t
           less-enable-lsp t
           scss-enable-lsp t
           html-enable-lsp t)
     (javascript :variables
                 javascript-import-tool 'import-js
                 javascript-backend 'lsp
                 javascript-fmt-tool 'web-beautify
                 javascript-repl 'nodejs
                 js2-basic-offset 2
                 js-indent-level 2)
     react
     (yaml :variables
           yaml-enable-lsp t)
     prettier
     (multiple-cursors :variables
                       multiple-cursors-backend 'evil-mc)
     nginx
     (docker :variables
             docker-dockerfile-backend 'lsp)
     csv
     search-engine
     (restclient :variables
                 restclient-use-org t)
     restructuredtext
     selectric
     octave
     purescript
     (kotlin :variables
             kotlin-backend 'lsp
             kotlin-lsp-jar-path "~/.kotlin-lsp/install/server/bin/kotlin-language-server")
     speed-reading
     systemd
     imenu-list
     (java :variables
           java-backend 'lsp)
     (groovy :variables
             groovy-backend 'lsp
             groovy-lsp-jar-path "~/.groovy-lsp/groovy-lsp-all.jar")
     (go :variables
         go-backend 'lsp
         go-use-golangci-lint t
         gofmt-command "goimports"
         go-tab-width 4
         go-format-before-save t
         go-use-gocheck-for-testing t
         go-use-test-args "-race -timeout 10s"
         godoc-at-point-function 'godoc-gogetdoc)
     coq
     django
     (elm :variables
          elm-backend 'lsp
          elm-sort-imports-on-save t
          elm-format-on-save t)
     kubernetes
     idris
     (haskell :variables
              haskell-completion-backend 'lsp
              haskell-enable-hindent t
              haskell-process-type 'stack-ghci)
     pandoc
     sphinx
     parinfer
     asciidoc
     (treemacs :variables
               treemacs-use-follow-mode t
               treemacs-use-filewatch-mode t
               treemacs-collapse-dirs 3
               treemacs-use-icons-dired t
               treemacs-use-all-the-icons-theme nil
               treemacs-use-git-mode 'deferred)
     ansible
     puppet
     rust
     xkcd
     typography
     (vimscript :variables
                vimscript-backend 'lsp)
     (terraform :variables
                terraform-auto-format-on-save t
                terraform-backend 'lsp)
     (ruby :variables
           ruby-enable-enh-ruby-mode t
           ruby-backend 'lsp)
     ruby-on-rails
     asm
     (sql :variables
          sql-capitalize-keywords t)
     ;; perl6
     autohotkey
     ;; (elixir :variables
     ;;         flycheck-elixir-credo-strict t
     ;;         elixir-backend 'lsp)
     faust
     vagrant
     erlang
     ;; (dash :variables
     ;;       helm-dash-docset-newpath "~/.local/share/Zeal/Zeal/docsets")
     games
     meson
     php
     helpful
     nginx
     racket
     (colors :variables
             colors-colorize-identifiers 'all)
     d
     unicode-fonts
     (typescript :variables
                 typescript-backend 'lsp
                 typescript-fmt-tool 'tide
                 typescript-lsp-linter t
                 typescript-linter 'tslint
                 typescript-fmt-on-save t))

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
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
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default spacemacs-27.1.pdmp)
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 60

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

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
   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'org-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(modus-vivendi spacemacs-dark modus-operandi spacemacs-light dracula)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 7.5
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
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
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab t

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t

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
   dotspacemacs-max-rollback-slots 30

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

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

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

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

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

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

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert mode). Currently the keyboard layouts
   ;; (qwerty-us qwertz-de) are supported.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.))
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first.")


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump.")


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (define-key evil-insert-state-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key evil-insert-state-map (kbd "M-j") 'company-yasnippet)
  (define-key evil-normal-state-map (kbd "M-j") 'company-yasnippet)
  (spacemacs/toggle-mode-line-minor-modes-off)

  ;; Set special fonts for company completion window
  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

  ;; Set variables for search-engine layer
  (spacemacs/set-leader-keys "s w s" 'engine/search-stack-overflow)
  (spacemacs/set-leader-keys "s w e" 'engine/search-ecosia)
  (spacemacs/set-leader-keys "s w d" 'engine/search-duck-duck-go)
  (spacemacs/set-leader-keys "s w g" 'engine/search-github)
  (spacemacs/set-leader-keys "s w i" 'engine/search-spacemacs-issues)
  (spacemacs/set-leader-keys "s w m" 'engine/search-google-maps)
  (spacemacs/set-leader-keys "s w b" 'engine/search-project-gutenberg)
  (spacemacs/set-leader-keys "s w a" 'engine/search-wolfram-alpha)
  (spacemacs/set-leader-keys "s w w" 'engine/search-wikipedia)

  ;; Activate latex auto document preview
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

  ;; Configure org mode
  (with-eval-after-load 'org
    (setq org-agenda-files (quote ("~/Documents/GTD/CalendarActionList.org" "~/Documents/GTD/NextActionList.org" "~/Documents/GTD/ProjectList.org")))
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
    ;; (setq org-agenda-todo-ignore-with-date t)
    ;; (setq org-agenda-todo-ignore-deadlines 'all)
    (setq org-agenda-todo-ignore-scheduled 'all)
    (setq org-agenda-todo-ignore-timestamp 'all)
    (setq org-hierarchical-todo-statistics nil)
    (setq org-startup-align-all-tables t)
    (setq org-agenda-restore-windows-after-quit nil)
    (setq org-use-property-inheritance nil)
    (setq org-agenda-sorting-strategy (quote ((agenda habit-down time-up priority-down category-keep)
                                              (todo tag-up priority-down todo-state-up category-keep)
                                              (tags priority-down category-keep)
                                              (search category-keep)))))

  ;; Format file on save
  (defun format-for-filetype ()
    "Run generic format function if not a mode specific one is available"
    (let ((filetypes '("elm" "hs" "c" "cpp" "h" "hpp" "py" "pyc" "robot" "tf" "go" "yml" "yaml")))
      (if (not (member (file-name-extension (buffer-file-name)) filetypes))
          (save-excursion
            (evil-indent (point-min) (point-max))))))
  (add-hook 'before-save-hook 'format-for-filetype)

  ;; Checkout PR
  (defun smile13241324/cherry-pick-pr (id)
    "Take a given PR id and make a new local branch, then cherry pick the commit and print the thanks message"
    (interactive "MEnter PR Id: ")
    (with-current-buffer "*scratch*"
      (let ((default-directory "~/.emacs.d"))
        (erase-buffer)
        (call-process-shell-command (concat "git fetch origin pull/" id "/head:" id) nil nil)
        (call-process-shell-command (concat "git cherry-pick " id) nil nil)
        (goto-char (point-max))
        (insert "\n" "Thank you for contributing to Spacemacs! :+1:" "\n" "The PR has been cherry-picked into develop, you can safely delete your branch."))))
  (spacemacs/set-leader-keys "o c" #'smile13241324/cherry-pick-pr)

  ;; Activate line wrap for all text modes
  (add-hook 'text-mode-hook 'spacemacs/toggle-truncate-lines-off)
  (add-hook 'text-mode-hook 'spacemacs/toggle-visual-line-navigation-off))

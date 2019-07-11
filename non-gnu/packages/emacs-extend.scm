(define-module (non-gnu packages emacs-extend)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix cvs-download)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages code)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages lesstif)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages image)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages music)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages w3m)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages scheme)
  #:use-module (gnu packages speech)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gd)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages video)
  #:use-module (gnu packages haskell)
  #:use-module (gnu packages wordnet)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define-public emacs-font-lock+-master
  (let ((commit "f2c1ddcd4c9d581bd32be88fad026b49f98b6541")
        (revision "0"))
    (package
     (name "emacs-font-lock+")
     (version (git-version "208" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacsmirror/font-lock-plus.git")
                    (commit commit)))
              (sha256
               (base32
                "17kqvmh3k2lvkarqra3v9nzm66l7dc72fh48crypc8f8qma9sncl"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page "https://github.com/emacsmirror/font-lock-plus")
     (synopsis "")
     (description "")
     (license #f))))

;; The Guix-master build lacks proper reference to `emacs-font-lock+'
;; XXX: https://github.com/domtronn/all-the-icons.el/issues/105
(define-public emacs-all-the-icons-master
  (let ((commit "f996fafa5b2ea072d0ad1df9cd98acc75820f530")
        (revision "1"))
    (package
     (name "emacs-all-the-icons")
     (version (git-version "3.2.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/domtronn/all-the-icons.el.git")
                    (commit commit)))
              (sha256
               (base32
                "0yc07xppgv78l56v7qwqp4sf3p44znkv5l0vlvwg8x1dciksxgqw"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (arguments
      `(#:include '("\\.el$" "^data/" "^fonts/")
	;; Compiling "test/" fails with "Symbol’s value as variable is void:
	;; all-the-icons--root-code".  Ignoring tests.
	#:exclude '("^test/")
	#:tests? #f))
     (propagated-inputs
      `(("f" ,emacs-f)
	("memoize" ,emacs-memoize)
	("emacs-font-lock+" ,emacs-font-lock+-master)))
     (home-page "https://github.com/domtronn/all-the-icons.el")
     (synopsis "Collect icon fonts and propertize them within Emacs")
     (description "All-the-icons is a utility package to collect various icon
fonts and propertize them within Emacs.  Icon fonts allow you to propertize
and format icons the same way you would normal text.  This enables things such
as better scaling of and anti aliasing of the icons.")
     ;; Package is released under Expat license.  Elisp files are licensed
     ;; under GPL3+.  Fonts come with various licenses: Expat for
     ;; "all-the-icons.ttf" and "file-icons.ttf", Apache License 2.0 for
     ;; "material-design-icons.ttf", and SIL OFL 1.1 for "fontawesome.ttf",
     ;; "ocitcons.ttf" and "weathericons.ttf".
     (license
      (list license:expat license:gpl3+ license:silofl1.1 license:asl2.0)))))

(define-public emacs-doom-modeline-tagged
  (let ((commit "6b8d4c9719c4a2b222ac07e34cf3313f472fbb30")
        (revision "7"))
    (package
     (name "emacs-doom-modeline")
     (version (git-version "2.3.7" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/seagle0128/doom-modeline.git")
                    (commit commit)))
              (sha256
               (base32
                "1054gpvqlc9riyniqrbaamnsy8640f8y4kqxxvab2h5hxyqcah5g"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-all-the-icons" ,emacs-all-the-icons-master)
	("emacs-shrink-path" ,emacs-shrink-path-tagged)
	("emacs-eldoc-eval" ,emacs-eldoc-eval-master)
	("emacs-dash" ,emacs-dash)))
     (home-page
      "https://github.com/seagle0128/doom-modeline")
     (synopsis "A minimal and modern mode-line")
     (description
      "")
     (license license:gpl3+))))
    
(define-public emacs-shrink-path-tagged
  (let ((commit "9b8cfb59a2dcee8b39b680ab9adad5ecb1f53c0b")
        (revision "0"))
    (package
     (name "emacs-shrink-path")
     (version (git-version "0.3.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://gitlab.com/bennya/shrink-path.el.git")
                    (commit commit)))
              (sha256
               (base32
                "0kx0c4syd7k6ff9j463bib32pz4wq0rzjlg6b0yqnymlzfr1mbki"))
              (file-name (git-file-name name version))))
       (build-system emacs-build-system)
       (propagated-inputs
	`(("emacs-s" ,emacs-s)
	  ("emacs-dash" ,emacs-dash)
	  ("emacs-f" ,emacs-f)))
       (home-page
	"https://gitlab.com/bennya/shrink-path.el")
       (synopsis "fish-style path")
       (description
	"Provides functions that offer fish shell[1] path truncation.
Directory /usr/share/emacs/site-lisp => /u/s/e/site-lisp

Also includes utility functions that make integration in eshell or the
modeline easier.

[1] https://fishshell.com/
")
       (license license:gpl3+))))

;; Track master
(define-public emacs-eldoc-eval-master
  (let ((commit "a67fe3637378dcb6c5f9e140acc8131f0d2346b3")
        (revision "1"))
    (package
     (name "emacs-eldoc-eval")
     (version (git-version "1.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/thierryvolpiatto/eldoc-eval.git")
                    (commit commit)))
              (sha256
               (base32
                "0504yyzxp1rk0br6f25395n4aa4w8ixf59vqxxb55a7agxplfpjc"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page "https://github.com/thierryvolpiatto/eldoc-eval")
     (synopsis
      "Enable eldoc support when minibuffer is in use.")
     (description
      "This package enables eldoc support when minibuffer is in use.")
     (license license:gpl3+))))

(define-public emacs-company-coq-tagged
  (let ((commit "a4e0625725e4f54d202e746bb41b8bc14c14ddef")
        (revision "1"))
    (package
     (name "emacs-company-coq")
     (version (git-version "1.0.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/cpitclaudel/company-coq.git")
                    (commit commit)))
              (sha256
               (base32
                "0dxi4h8xqq5647k7h89s4pi8nwyj3brlhsckrv3p3b1g4dr6mk3b"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-company-math" ,emacs-company-math-master)
	("emacs-company" ,emacs-company)
	("emacs-yasnippet" ,emacs-yasnippet)
	("emacs-dash" ,emacs-dash)))
     (home-page "https://github.com/cpitclaudel/company-coq.git")
     (synopsis
      "A collection of extensions for Proof General's Coq mode")
     (description
      "This package includes a collection of company-mode backends for
Proof-General's Coq mode, and many useful extensions to Proof-General.

See https://github.com/cpitclaudel/company-coq/ for a detailed description,
including screenshots and documentation.  After installing, you may want to
use M-x company-coq-tutorial to open the tutorial.
")
     (license license:gpl3+))))

(define-public emacs-company-math-master
  (let ((commit "600e49449644f6835f9dc3501bc58461999e8ab9")
        (revision "1"))
    (package
     (name "emacs-company-math")
     (version (git-version "1.3" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/vspinu/company-math.git")
                    (commit commit)))
              (sha256
               (base32
                "1ps2lpkzn8mjbpcbvvy1qz3xbgrh6951x8y9bsd1fm32drdph9lh"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-company" ,emacs-company)
	("emacs-math-symbol-lists"
	 ,emacs-math-symbol-lists-master)))
     (home-page
      "https://github.com/vspinu/company-math")
     (synopsis
      "Completion backends for unicode math symbols and latex tags")
     (description "No description available.")
     (license license:gpl3+))))

(define-public emacs-math-symbol-lists-master
  (let ((commit "dc7531cff0c845d5470a50c24d5d7309b2ced7eb")
        (revision "2"))
    (package
     (name "emacs-math-symbol-lists")
     (version (git-version "1.2.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/vspinu/math-symbol-lists.git")
                    (commit commit)))
              (sha256
               (base32
                "094m21i9rns6m59cmhxcivxxafbg52w8f8na4y3v47aq67zmhhqm"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page
      "https://github.com/vspinu/math-symbol-lists")
     (synopsis
      "Lists of Unicode math symbols and latex commands")
     (description
      "")
     (license license:gpl3+))))

;; Track master
(define-public emacs-fstar-mode-master
  (let ((commit "ddb653cb3d6ba6568ffaf531ca57c9ea3e7498f5")
        (revision "4"))
    (package
     (name "emacs-fstar-mode")
     (version (git-version "0.9.4.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/FStarLang/fstar-mode.el.git")
                    (commit commit)))
              (sha256
               (base32
                "0mr48y24p81srv2m4glif1d7iy6i7jpx98lbv9577xry22d3vvhb"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-dash" ,emacs-dash)
	("emacs-company" ,emacs-company)
	("emacs-quick-peek" ,emacs-quick-peek-master)
	("emacs-yasnippet" ,emacs-yasnippet)
	("emacs-flycheck" ,emacs-flycheck)
	("emacs-company-quickhelp" ,emacs-company-quickhelp)))
     (home-page
      "https://github.com/FStarLang/fstar.el")
     (synopsis "Support for F* programming")
     (description
      "This file implements support for F* programming in Emacs, including:

* Syntax highlighting
* Unicode math (with prettify-symbols-mode)
* Indentation
* Real-time verification (requires the Flycheck package)
* Interactive proofs (à la Proof-General)

See https://github.com/FStarLang/fstar-mode.el for setup and usage tips.
")
     (license license:expat))))

(define-public emacs-ccls-master
  (let ((commit "2764ddd57b03646f0327ea680a954b4a67450aef")
        (revision "1"))
    (package
     (name "emacs-ccls")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/MaskRay/emacs-ccls.git")
                    (commit commit)))
              (sha256
               (base32
                "16427jvzhjy8kpvlgl3qzkzppv98124hkgi8q8pv1h7m46k9lhh3"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-lsp-mode" ,emacs-lsp-mode)
	("emacs-dash" ,emacs-dash)
	("emacs-projectile" ,emacs-projectile)))
     (home-page
      "https://github.com/MaskRay/emacs-ccls")
     (synopsis "ccls client for lsp-mode")
     (description
      "To enable, call (lsp) in c-mode-hook c++-mode-hook objc-mode-hook.
See more at https://github.com/MaskRay/ccls/wiki/Emacs
")
     (license license:expat))))

(define-public emacs-quick-peek-master
  (let ((commit "fd8a6c81422932539d221f39f18c90f2811f2dd9")
        (revision "0"))
    (package
     (name "emacs-quick-peek")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/cpitclaudel/quick-peek.git")
                    (commit commit)))
              (sha256
               (base32
                "18jr3syd7jd809qq1j61zwaaclmqn24qyb0mv0q8sj6ac4vzl1c3"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page "https://github.com/cpitclaudel/quick-peek")
     (synopsis "Inline quick-peek windows")
     (description
      "")
     (license license:gpl3+))))

(define-public emacs-fsharp-mode-tagged
  (let ((commit "da164a1bc29891530ea1f890982f7bd2541aa0ab")
        (revision "2"))
    (package
     (name "emacs-fsharp-mode")
     (version (git-version "1.9.14" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/fsharp/emacs-fsharp-mode.git")
                    (commit commit)))
              (sha256
               (base32
                "1p395dxzpksp0y9j83h9841zqmmp6pxs715yfb6q44m332bl9is4"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-company" ,emacs-company)
	("emacs-company-quickhelp"
	 ,emacs-company-quickhelp)
	("emacs-popup" ,emacs-popup)
	("emacs-pos-tip" ,emacs-pos-tip)
	("emacs-s" ,emacs-s)
	("emacs-dash" ,emacs-dash)
	("emacs-flycheck" ,emacs-flycheck)))
     (home-page "https://github.com/fsharp/emacs-fsharp-mode")
     (synopsis "F# mode for Emacs")
     (description "F# mode for Emacs.")
     (license license:asl2.0))))

(define-public emacs-md4rd-master
  (let ((commit "443c8059af4925d11c93a1293663165c52472f08")
        (revision "1"))
    (package
     (name "emacs-md4rd")
     (version (git-version "0.3.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/ahungry/md4rd.git")
                    (commit commit)))
              (sha256
               (base32
                "1n6g6k4adzkkn1g7z4j27s35xy12c1fg2r08gv345ddr3wplq4ri"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-hierarchy" ,emacs-hierarchy)
	("emacs-request" ,emacs-request)
	("emacs-dash" ,emacs-dash)
	("emacs-s" ,emacs-s)
	("emacs-tree-mode" ,emacs-tree-mode)))
     (home-page "https://github.com/ahungry/md4rd")
     (synopsis "Emacs Mode for Reddit")
     (description
      "This package allows to read Reddit from within Emacs interactively.")
     (license license:gpl3+))))

(define-public emacs-rust-mode-tagged
  (let ((commit "106aeab800fb3404baf231845d3e3549ec235afa")
        (revision "1"))
    (package
     (name "emacs-rust-mode")
     (version (git-version "0.4.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/rust-lang/rust-mode.git")
                    (commit commit)))
              (sha256
               (base32
                "0bcrklyicxh032rrp585rl5mxd26nb61dp6r5bl935rlcmxzsczh"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page
      "https://github.com/rust-lang/rust-mode")
     (synopsis
      "A major emacs mode for editing Rust source code")
     (description "")
     (license #f))))

(define-public emacs-lsp-haskell-master
  (let ((commit "8f2dbb6e827b1adce6360c56f795f29ecff1d7f6")
        (revision "1"))
    (package
     (name "emacs-lsp-haskell")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacs-lsp/lsp-haskell.git")
                    (commit commit)))
              (sha256
               (base32
                "00j6d5rpsi7h5jz54zpjmbpg38fda4xy67xc4x67r834493ldzlq"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-lsp-mode" ,emacs-lsp-mode)
	("emacs-haskell-mode" ,emacs-haskell-mode)))
     (home-page
      "https://github.com/emacs-lsp/lsp-haskell")
     (synopsis "Haskell support for lsp-mode")
     (description "Haskell support for lsp-mode")
     (license license:gpl3+))))

(define-public emacs-fancy-battery-master
  (let ((commit "9b88ae77a01aa3edc529840338bcb2db7f445822")
        (revision "0"))
    (package
     (name "emacs-fancy-battery")
     (version (git-version "0.2" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/lunaryorn/fancy-battery.el.git")
                    (commit commit)))
              (sha256
               (base32
                "1k6prddw277iszh9hq145yqidwiiy9iqz656rpmqwn5hmr1vakhk"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page
      "https://github.com/lunaryorn/fancy-battery.el")
     (synopsis "Fancy battery display")
     (description
      "Fancy battery display")
     (license license:gpl3+))))

(define-public emacs-webpaste-tagged
  (let ((commit "7345c5f62d5cff4d84379eaf5dc8b2bb8bc4f99c")
        (revision "0"))
    (package
     (name "emacs-webpaste")
     (version (git-version "3.0.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/etu/webpaste.el.git")
                    (commit commit)))
              (sha256
               (base32
                "00dfp2dyj9cvcvvpsh4g61b37477c8ahfj3xig2x2kgfz15lk89n"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-request" ,emacs-request)))
     (home-page "https://github.com/etu/webpaste.el")
     (synopsis "Paste to pastebin-like services")
     (description
      "This mode allows to paste whole buffers or parts of buffers to
pastebin-like services.  It supports more than one service and will
failover if one service fails.  More services can easily be added
over time and prefered services can easily be configured.
")
     (license license:gpl3+))))

(define-public emacs-lean-mode-master
  (let ((commit "9d6b8471e2044310b4cd7cd3213b1fc8f78ec499")
        (revision "0"))
    (package
     (name "emacs-lean-mode")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/leanprover/lean-mode.git")
                    (commit commit)))
              (sha256
               (base32
                "0r8vfklrdw3f11cpk279jg3mnfbqm60m6klisqndkvir7vsrshni"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-dash" ,emacs-dash)
	("emacs-company" ,emacs-company)
	("emacs-cl-lib" ,emacs-cl-lib)
	("emacs-s" ,emacs-s)
	("emacs-f" ,emacs-f)
	("emacs-helm" ,emacs-helm)
	("emacs-flycheck" ,emacs-flycheck)))
     (home-page
      "https://github.com/leanprover/lean-mode")
     (synopsis "A major mode for the Lean language")
     (description
      "Provides a major mode for the Lean programming language.

Provides highlighting, diagnostics, goal visualization,
and many other useful features for Lean users.

See the README.md for more advanced features and the
associated keybindings.
")
     (license license:asl2.0))))

(define-public emacs-cl-lib
  (package
  (name "emacs-cl-lib")
  (version "0.6.1")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "https://elpa.gnu.org/packages/cl-lib-"
             version
             ".el"))
      (sha256
        (base32
          "00w7bw6wkig13pngijh7ns45s1jn5kkbbjaqznsdh6jk5x089j9y"))))
  (build-system emacs-build-system)
  (home-page
    "http://elpa.gnu.org/packages/cl-lib.html")
  (synopsis
    "Properly prefixed CL functions and macros")
  (description
    "This is a forward compatibility package, which provides (a subset of) the
features of the cl-lib package introduced in Emacs-24.3, for use on
previous emacsen (it should work on Emacs≥21 as well as XEmacs).

Make sure this is installed *late* in your `load-path`, i.e. after Emacs's
built-in .../lisp/emacs-lisp directory, so that if/when you upgrade to
Emacs-24.3, the built-in version of the file will take precedence, otherwise
you could get into trouble (although we try to hack our way around the
problem in case it happens).

This code is largely copied from Emacs-24.3's cl.el, with the alias bindings
simply reversed.")
  (license license:gpl3+)))

(define-public emacs-erc-status-sidebar-master
  (let ((commit "ea4189a1dbfe60117359c36e681ad7c389e2968c")
        (revision "0"))
    (package
     (name "emacs-erc-status-sidebar")
     (version (git-version "0.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/drewbarbs/erc-status-sidebar.git")
                    (commit commit)))
              (sha256
               (base32
                "1hwlhzgx03z8891sblz56zdp8zj0izh72kxykgcnz5rrkyc3vfi3"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs `(("emacs-seq" ,emacs-seq)))
     (home-page
      "https://github.com/drewbarbs/erc-status-sidebar")
     (synopsis
      "a hexchat-like activity overview for ERC channels")
     (description
      "This package is provides a hexchat-like status bar for joined
channels in ERC.  It relies on the `erc-track' module, and displays
all the same information erc-track does in the mode line, but in an
alternative format.

Credit to sidebar.el (https://github.com/sebastiencs/sidebar.el)
and outline-toc.el (https://github.com/abingham/outline-toc.el),
from which all the sidebar window management ideas were lifted.

# Setup

To open the ERC status sidebar in the current frame:

M-x erc-status-sidebar-open

Ensure the `erc-track' module is active (a member of
`erc-modules'). This is the default.

To close the sidebar on the current frame:

M-x erc-status-sidebar-close

Use a prefix argument to close the sidebar on all frames.

To kill the sidebar buffer and close the sidebar on all frames:

M-x erc-status-sidebar-kill
")
     (license license:gpl3+))))

(define-public emacs-auto-compile-tagged
  (let ((commit "e6bbb1371324c8884af3b201e9adbc9296eb2ff4")
        (revision "0"))
    (package
     (name "emacs-auto-compile")
     (version (git-version "1.5.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacscollective/auto-compile.git")
                    (commit commit)))
              (sha256
               (base32
                "1jyn7yvbvk7cydy3pzwqlb0yxf5cxdiipa1gnigdk9wdbj68wjjk"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-packed" ,emacs-packed-tagged)))
     (home-page
      "https://github.com/emacscollective/auto-compile")
     (synopsis
      "automatically compile Emacs Lisp libraries")
     (description
      "")
     (license license:gpl3+))))

(define-public emacs-packed-tagged
  (let ((commit "c41c3dfda86ae33832ffc146923e2a4675cbacfa")
        (revision "0"))
    (package
     (name "emacs-packed")
     (version (git-version "3.0.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacscollective/packed.git")
                    (commit commit)))
              (sha256
               (base32
                "1272xmb3l8ddfijqzci3x0kxwibqb0sbkci4rbcv9ba9hpxp4d1v"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page
      "https://github.com/emacscollective/packed")
     (synopsis
      "package manager agnostic Emacs Lisp package utilities")
     (description
      "Packed provides some package manager agnostic utilities to work
with Emacs Lisp packages.  As far as Packed is concerned packages
are collections of Emacs Lisp libraries that are stored in a
dedicated directory such as a Git repository.  And libraries are
Emacs Lisp files that provide the correct feature (matching the
filename).

Where a package manager might depend on metadata, Packed instead
uses some heuristics to get the same information — that is slower
and might also fail at times but makes it unnecessary to maintain
package recipes.
")
     (license license:gpl3+))))

(define-public emacs-racket-mode-master
  (let ((commit "d42db218d953250bbf74a1ffacfe83c336df805f")
        (revision "7"))
    (package
      (name "emacs-racket-mode")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
	       (url "https://github.com/greghendershott/racket-mode.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1k1s5rwh1bjhpqkvpvjs555ndw07xk3j2q50vw63w0wz56gqgv35"))))
      (build-system emacs-build-system)
      (arguments
       `(#:include '("\\.el$" "\\.rkt$")))
      (propagated-inputs
       `(("emacs-faceup" ,emacs-faceup)
         ("emacs-s" ,emacs-s)))
      (home-page "https://github.com/greghendershott/racket-mode")
      (synopsis "Major mode for Racket language")
      (description "@code{racket-mode} provides:

@itemize
@item Focus on Racket (not various Schemes).
@item Follow DrRacket concepts where applicable.
@item Thorough font-lock and indent.
@end itemize\n")
      (license license:gpl3+))))

(define-public emacs-dashboard-tagged
  (let ((commit "5b66b65c4c7536f43e8e58b3f7055e5bd6381cda")
        (revision "0"))
    (package
     (name "emacs-dashboard")
     (version (git-version "1.6.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://github.com/emacs-dashboard/emacs-dashboard.git")
	     (commit commit)))
       (file-name (git-file-name name version))
       (sha256
	(base32
	 "1g6g8vad1kdmv1zxp95a8sn70idl26isqjb3xk1r95pqnx1cn591"))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-page-break-lines" ,emacs-page-break-lines)))
     (arguments
      '(#:include '("\\.el$" "\\.txt$" "\\.png$")
	#:phases
	(modify-phases %standard-phases
		       (add-after 'unpack 'patch-dashboard-widgets
				  ;; This phase fixes compilation error.
				  (lambda _
				    (chmod "dashboard-widgets.el" #o666)
				    (emacs-substitute-variables "dashboard-widgets.el"
								("dashboard-init-info"
								 '(format "Loaded in %s" (emacs-init-time))))
				    #t)))))
     (home-page "https://github.com/rakanalh/emacs-dashboard")
     (synopsis "Startup screen extracted from Spacemacs")
     (description "This package provides an extensible Emacs dashboard, with
sections for bookmarks, projectil projects, org-agenda and more. ")
     (license license:gpl3+))))
(define-public emacs-slime-tagged
  (let ((commit "c1f15e2bd02fabe7bb468b05fe311cd9a932f14f")
        (revision "1"))
    (package
     (name "emacs-slime")
     (version (git-version "2.24" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://github.com/slime/slime.git")
	     (commit commit)))
       (file-name (git-file-name name version))
       (sha256
	(base32
	 "0js24x42m7b5iymb4rxz501dff19vav5pywnzv50b673rbkaaqvh"))))
     (build-system emacs-build-system)
     (native-inputs
     `(("texinfo" ,texinfo)))
    (arguments
     `(#:include '("\\.el$" "\\.lisp$" "\\.asd$" "contrib")
       #:exclude '("^slime-tests.el" "^contrib/test/"
                   "^contrib/Makefile$" "^contrib/README.md$")
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'make-git-checkout-writable
           (lambda _
             (for-each make-file-writable (find-files "."))
             #t))
         (add-before 'install 'configure
           (lambda* _
             (emacs-substitute-variables "slime.el"
               ("inferior-lisp-program" "sbcl"))
             #t))
         (add-before 'install 'install-doc
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (info-dir (string-append out "/share/info"))
                    (doc-dir (string-append out "/share/doc/"
                                            ,name "-" ,version))
                    (doc-files '("doc/slime-refcard.pdf"
                                 "README.md" "NEWS" "PROBLEMS"
                                 "CONTRIBUTING.md")))
               (with-directory-excursion "doc"
                 (substitute* "Makefile"
                   (("infodir=/usr/local/info")
                    (string-append "infodir=" info-dir)))
                 (invoke "make" "html/index.html")
                 (invoke "make" "slime.info")
                 (install-file "slime.info" info-dir)
                 (copy-recursively "html" (string-append doc-dir "/html")))
               (for-each (lambda (f)
                           (install-file f doc-dir)
                           (delete-file f))
                         doc-files)
               (delete-file-recursively "doc")
               #t))))))
    (home-page "https://github.com/slime/slime")
    (synopsis "Superior Lisp Interaction Mode for Emacs")
    (description
     "SLIME extends Emacs with support for interactive programming in
Common Lisp.  The features are centered around @command{slime-mode},
an Emacs minor mode that complements the standard @command{lisp-mode}.
While lisp-mode supports editing Lisp source files, @command{slime-mode}
adds support for interacting with a running Common Lisp process
for compilation, debugging, documentation lookup, and so on.")
    (license (list license:gpl2+ license:public-domain)))))

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

(define-public emacs-font-lock+
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
(define-public emacs-all-the-icons-channel
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
	("emacs-font-lock+" ,emacs-font-lock+)))
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

(define-public emacs-doom-modeline
  (let ((commit "c5226e4aaec89c7abfff5d9e46322b92c008dea2")
        (revision "3"))
    (package
     (name "emacs-doom-modeline")
     (version (git-version "2.3.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/seagle0128/doom-modeline.git")
                    (commit commit)))
              (sha256
               (base32
                "0snlq8z193bc9sl5jn3nk2f03fshb2shlgm6kmpn5hr01gkspbbw"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-all-the-icons" ,emacs-all-the-icons-channel)
	("emacs-shrink-path" ,emacs-shrink-path)
	("emacs-eldoc-eval" ,emacs-eldoc-eval)
	("emacs-dash" ,emacs-dash)))
     (home-page
      "https://github.com/seagle0128/doom-modeline")
     (synopsis "A minimal and modern mode-line")
     (description
      "")
     (license license:gpl3+))))
    
(define-public emacs-shrink-path
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
(define-public emacs-eldoc-eval
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

(define-public emacs-company-coq
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
      `(("emacs-company-math" ,emacs-company-math)
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

(define-public emacs-company-math
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
	 ,emacs-math-symbol-lists)))
     (home-page
      "https://github.com/vspinu/company-math")
     (synopsis
      "Completion backends for unicode math symbols and latex tags")
     (description "No description available.")
     (license license:gpl3+))))

(define-public emacs-math-symbol-lists
  (let ((commit "f5eea51926b3afd448c661e1d93c1bd0a2194561")
        (revision "1"))
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
                "0hj2jnnlxm8vmmljmnhzbkdfpr2g6gr6aka66g8zbr5b7hkdjkfd"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page
      "https://github.com/vspinu/math-symbol-lists")
     (synopsis
      "Lists of Unicode math symbols and latex commands")
     (description
      "")
     (license license:gpl3+))))

(define-public emacs-doom-themes
  (let ((commit "39e6971e81181b86a57f65cd0ea31376203a9756")
        (revision "0"))
    (package
     (name "emacs-doom-themes")
     (version (git-version "2.1.6" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/hlissner/emacs-doom-themes.git")
                    (commit commit)))
              (sha256
               (base32
                "042pzcdhxi2z07jcscgjbaki9nrrm0cbgbbrnymd1r4q8ckkn8l9"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-all-the-icons" ,emacs-all-the-icons-channel)))
     (home-page
      "https://github.com/hlissner/emacs-doom-theme")
     (synopsis
      "an opinionated pack of modern color-themes")
     (description
      "")
     (license #f))))

;; Track master
(define-public emacs-fstar-mode
  (let ((commit "b2540d287f6ef8036c47cbc80d11a546eee8fc41")
        (revision "2"))
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
                "0m5n55pmji2szq5jg5zrsn6k507w7jya8s0h2y0qiiwk4cgv7693"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-dash" ,emacs-dash)
	("emacs-company" ,emacs-company)
	("emacs-quick-peek" ,emacs-quick-peek)
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

(define-public emacs-ccls
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

(define-public emacs-quick-peek
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

(define-public emacs-fsharp-mode
  (let ((commit "5d8d8dd6d5fbb2d23f1e773a77bde4ffc187ebe5")
        (revision "0"))
    (package
     (name "emacs-fsharp-mode")
     (version (git-version "1.9.13" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/fsharp/emacs-fsharp-mode.git")
                    (commit commit)))
              (sha256
               (base32
                "0wkqff126gpfzs0nvfvzkgxi9m5npl23j2pq8s9ssnkwlvk7h0jh"))
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

(define-public emacs-md4rd
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

(define-public emacs-rust-mode
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

(define-public emacs-lsp-haskell
  (let ((commit "33e3ac438338b0a78971cd26aa919482d290c51b")
        (revision "0"))
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
                "1ihc6djxsdrd0q9f79bs0qwxxhw3bnw1kxw2rq92drfnypqbiqcq"))
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

(define-public emacs-fancy-battery
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

(define-public emacs-webpaste
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

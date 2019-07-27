(define-module (non-gnu packages ocaml-extend)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system dune)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system ocaml)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix svn-download)
  #:use-module (guix utils)
  #:use-module ((srfi srfi-1) #:hide (zip)))

;; (define-public lablgtk-tagged
;;   (package
;;     (name "lablgtk")
;;     (version "3.0.beta6")
;;     (source
;;      (origin
;;       (method git-fetch)
;;       (uri (git-reference
;; 	    (url "https://github.com/garrigue/lablgtk.git")
;; 	    (commit (string-append version))))
;;       (sha256
;;        (base32
;; 	"0g3xp6v0ab6yhs2n18acfq6dls3g35anvk1p463f61asnf1hnc7b"))))
;;     (build-system gnu-build-system)
;;     (native-inputs
;;      `(("camlp4" ,camlp4)
;;        ("ocaml" ,ocaml)
;;        ("ocaml-cairo2" ,ocaml-cairo2-tagged)
;;        ("findlib" ,ocaml-findlib)
;;        ("pkg-config" ,pkg-config)))
;;     ;; FIXME: Add inputs gtkgl-2.0, libpanelapplet-2.0, gtkspell-2.0,
;;     ;; and gtk+-quartz-2.0 once available.
;;     (inputs
;;      `(("gtk+" ,gtk+)
;;        ("gtksourceview" ,gtksourceview-2)
;;        ("libgnomecanvas" ,libgnomecanvas)
;;        ("libgnomeui" ,libgnomeui)
;;        ("libglade" ,libglade)
;;        ("librsvg" ,librsvg)))
;;     (arguments
;;      `(#:tests? #f ; no check target

;;        ;; opt: also install cmxa files
;;        #:make-flags (list "all" "opt"
;;                           (string-append "FINDLIBDIR="
;;                                          (assoc-ref %outputs "out")
;;                                          "/lib/ocaml"))
;;        ;; Occasionally we would get "Error: Unbound module GtkThread" when
;;        ;; compiling 'gtkThInit.ml', with 'make -j'.  So build sequentially.
;;        #:parallel-build? #f

;;        #:phases
;;          (modify-phases %standard-phases
;;            (add-before 'install 'prepare-install
;;              (lambda* (#:key inputs outputs #:allow-other-keys)
;;                (let ((out (assoc-ref outputs "out"))
;;                      (ocaml (assoc-ref inputs "ocaml")))
;;                  ;; Install into the output and not the ocaml directory.
;;                  (mkdir-p (string-append out "/lib/ocaml"))
;;                  (substitute* "config.make"
;;                    ((ocaml) out))
;;                  #t))))))
;;     (home-page "http://lablgtk.forge.ocamlcore.org/")
;;     (synopsis "GTK+ bindings for OCaml")
;;     (description
;;      "LablGtk is an OCaml interface to GTK+ 1.2 and 2.x.  It provides
;; a strongly-typed object-oriented interface that is compatible with the
;; dynamic typing of GTK+.  Most widgets and methods are available.  LablGtk
;; also provides bindings to
;; gdk-pixbuf, the GLArea widget (in combination with LablGL), gnomecanvas,
;; gnomeui, gtksourceview, gtkspell,
;; libglade (and it an generate OCaml code from .glade files),
;; libpanel, librsvg and quartz.")
;;     (license license:lgpl2.1)))

;; (define-public ocaml-cairo2-tagged
;;   (package
;;    (name "ocaml-cairo2")
;;    (version "0.6.1")
;;    (source
;;     (origin
;;      (method url-fetch)
;;      (uri "https://github.com/Chris00/ocaml-cairo/releases/download/0.6.1/cairo2-0.6.1.tbz")
;;      (sha256
;;       (base32
;;        "1ik4qf4b9443sliq2z7x9acd40rmzvyzjh3bh98wvjklxbb84a9i"))))
;;    (build-system dune-build-system)
;;    (native-inputs
;;     `(("cairo" ,cairo)))
;;    (inputs
;;     `(("lablgtk"
;;        ,lablgtk)))
;;    (home-page
;;     "https://github.com/Chris00/ocaml-cairo")
;;    (synopsis
;;     "Binding to Cairo, a 2D Vector Graphics Library")
;;    (description
;;     "This is a binding to Cairo, a 2D graphics library with support for
;; multiple output devices. Currently supported output targets include
;; the X Window System, Quartz, Win32, image buffers, PostScript, PDF,
;; and SVG file output.")
;;    (license #f)))

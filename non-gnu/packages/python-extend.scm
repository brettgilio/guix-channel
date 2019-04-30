(define-module (non-gnu packages python-extend)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages adns)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages monitoring)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages openstack)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages search)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages web)
  #:use-module (gnu packages base)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages serialization)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (non-gnu packages hy))

(define-public python-fastentrypoints
  (package
   (name "python-fastentrypoints")
   (version "0.12")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "fastentrypoints" version))
     (sha256
      (base32
       "02s1j8i2dzbpbwgq2a3fiqwm3cnmhii2qzc0k42l0rdxd4a4ya7z"))))
   (build-system python-build-system)
   (home-page
    "https://github.com/ninjaaron/fast-entry_points")
   (synopsis
    "Makes entry_points specified in setup.py load more quickly")
   (description
    "Makes entry_points specified in setup.py load more quickly")
   (license license:bsd-3)))

(define-public python-funcparserlib
  (package
   (name "python-funcparserlib")
   (version "0.3.6")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "funcparserlib" version))
     (sha256
      (base32
       "07f9cgjr3h4j2m67fhwapn8fja87vazl58zsj4yppf9y3an2x6dp"))))
   (build-system python-build-system)
   (arguments
    ;; Disable tests
    ;; AttributeError: 'NoneType' object has no attribute 'split'
    `(#:tests? #f))
   (home-page
    "https://github.com/vlasovskikh/funcparserlib")
   (synopsis
    "Recursive descent parsing library based on functional combinators")
   (description
    "Recursive descent parsing library based on functional combinators")
   (license license:expat)))

(define-public python-rply
  (package
    (name "python-rply")
    (version "0.7.7")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "rply" version))
              (sha256
               (base32
                "03fhcrm20vd21gqmmhm5b5hk0v769yyv7xq7awyzna7x7rq2avad"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-appdirs" ,python-appdirs)))
    (home-page "https://github.com/alex/rply")
    (synopsis "Parser generator for Python")
    (description
     "This package provides a pure Python based parser generator, that also
works with RPython.  It is a more-or-less direct port of David Bazzley's PLY,
with a new public API, and RPython support.")
    (license license:bsd-3)))

(define-public python-control
  (package
   (name "python-control")
   (version "0.8.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "control" version))
     (sha256
      (base32
       "1nxayfzw6y7hblfl4hdhz3j0vms0sxhghcfzhs44r9akl8v8qvkj"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f))
   (propagated-inputs
    `(("python-matplotlib" ,python-matplotlib)
      ("python-numpy" ,python-numpy)
      ("python-scipy" ,python-scipy)
      ("python-nose" ,python-nose)))
   (home-page
    "http://python-control.sourceforge.net")
   (synopsis "Python control systems library")
   (description "Python control systems library")
   (license license:bsd-3)))

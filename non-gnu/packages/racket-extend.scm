(define-module (non-gnu packages racket-extend)
  #:use-module (gnu packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libunistring)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages netpbm)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages libphidget)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages image)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages libedit)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define-public racket-tagged
  (package
    (name "racket")
    (version "7.3")
    (source (origin
              (method url-fetch)
              (uri (list (string-append "http://mirror.racket-lang.org/installers/"
                                        version "/racket-" version "-src.tgz")
                         (string-append
                          "http://mirror.informatik.uni-tuebingen.de/mirror/racket/"
                          version "/racket-" version "-src.tgz")))
              (sha256
               (base32
                "0h6072njhb87rkz4arijvahxgjzn8r14s4wns0ijvxm89bg136yl"))
              ;(patches (search-patches
              ;          "racket-store-checksum-override.patch"))
	      ))
    (build-system gnu-build-system)
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (add-before 'configure 'pre-configure
           (lambda* (#:key inputs #:allow-other-keys)
             ;; Patch dynamically loaded libraries with their absolute paths.
             (let* ((library-path   (search-path-as-string->list
                                     (getenv "LIBRARY_PATH")))
                    (find-so        (lambda (soname)
                                      (search-path
                                       library-path
                                       (format #f "~a.so" soname))))
                    (patch-ffi-libs (lambda (file libs)
                                      (for-each
                                       (lambda (lib)
                                         (substitute* file
                                           (((format #f "\"~a\"" lib))
                                            (format #f "\"~a\"" (find-so lib)))))
                                       libs))))
               (substitute* "collects/db/private/sqlite3/ffi.rkt"
                 (("ffi-lib sqlite-so")
                  (format #f "ffi-lib \"~a\"" (find-so "libsqlite3"))))
               (substitute* "collects/openssl/libssl.rkt"
                 (("ffi-lib libssl-so")
                  (format #f "ffi-lib \"~a\"" (find-so "libssl"))))
               (substitute* "collects/openssl/libcrypto.rkt"
                 (("ffi-lib libcrypto-so")
                  (format #f "ffi-lib \"~a\"" (find-so "libcrypto"))))
               (substitute* "share/pkgs/math-lib/math/private/bigfloat/gmp.rkt"
                 (("ffi-lib libgmp-so")
                  (format #f "ffi-lib \"~a\"" (find-so "libgmp"))))
               (substitute* "share/pkgs/math-lib/math/private/bigfloat/mpfr.rkt"
                 (("ffi-lib libmpfr-so")
                  (format #f "ffi-lib \"~a\"" (find-so "libmpfr"))))
               (substitute* "share/pkgs/readline-lib/readline/rktrl.rkt"
                 (("\\(getenv \"PLT_READLINE_LIB\"\\)")
                  (format #f "\"~a\"" (find-so "libedit"))))
               (for-each
                (lambda (x) (apply patch-ffi-libs x))
                '(("share/pkgs/draw-lib/racket/draw/unsafe/cairo-lib.rkt"
                   ("libfontconfig" "libcairo"))
                  ("share/pkgs/draw-lib/racket/draw/unsafe/glib.rkt"
                   ("libglib-2.0" "libgmodule-2.0" "libgobject-2.0"))
                  ("share/pkgs/draw-lib/racket/draw/unsafe/jpeg.rkt"
                   ("libjpeg"))
                  ("share/pkgs/draw-lib/racket/draw/unsafe/pango.rkt"
                   ("libpango-1.0" "libpangocairo-1.0"))
                  ("share/pkgs/draw-lib/racket/draw/unsafe/png.rkt"
                   ("libpng"))
                  ("share/pkgs/db-lib/db/private/odbc/ffi.rkt"
                   ("libodbc"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/x11.rkt"
                   ("libX11"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/gsettings.rkt"
                   ("libgio-2.0"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/gtk3.rkt"
                   ("libgdk-3" "libgtk-3"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/unique.rkt"
                   ("libunique-1.0"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/utils.rkt"
                   ("libgdk-x11-2.0" "libgdk_pixbuf-2.0" "libgtk-x11-2.0"))
                  ("share/pkgs/gui-lib/mred/private/wx/gtk/gl-context.rkt"
                   ("libGL"))
                  ("share/pkgs/sgl/gl.rkt"
                   ("libGL" "libGLU")))))
             (chdir "src")
             #t))
         (add-after 'unpack 'patch-/bin/sh
           (lambda _
             (substitute* "collects/racket/system.rkt"
               (("/bin/sh") (which "sh")))
             #t)))
       #:tests? #f                      ; XXX: how to run them?
       ))
    (inputs
     `(("libffi" ,libffi)
       ;; Hardcode dynamically loaded libraries for better functionality.
       ;; sqlite and libraries for `racket/draw' are needed to build the doc.
       ("cairo" ,cairo)
       ("fontconfig" ,fontconfig)
       ("glib" ,glib)
       ("glu" ,glu)
       ("gmp" ,gmp)
       ("gtk+" ,gtk+)                   ; propagates gdk-pixbuf+svg
       ("libjpeg" ,libjpeg)
       ("libpng" ,libpng)
       ("libx11" ,libx11)
       ("mesa" ,mesa)
       ("mpfr" ,mpfr)
       ("openssl" ,openssl)
       ("pango" ,pango)
       ("sqlite" ,sqlite)
       ("unixodbc" ,unixodbc)
       ("libedit" ,libedit)))
    (home-page "http://racket-lang.org")
    (synopsis "Implementation of Scheme and related languages")
    (description
     "Racket is an implementation of the Scheme programming language (R5RS and
R6RS) and related languages, such as Typed Racket.  It features a compiler and
a virtual machine with just-in-time native compilation, as well as a large set
of libraries.")
    (license license:lgpl2.0+)))

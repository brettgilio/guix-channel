(define-module (non-gnu packages c-extend)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages hurd))

(define-public libgc-tagged
  (package
   (name "libgc")
   (version "8.0.4")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/ivmai/bdwgc/releases"
                                "/download/v" version "/gc-" version ".tar.gz"))
            (sha256
             (base32
              "1798rp3mcfkgs38ynkbg2p47bq59pisrc6mn0l20pb5iczf0ssj3"))))
   (build-system gnu-build-system)
   (arguments
    `(#:configure-flags
      (list
       ;; Install gc_cpp.h et al.
       "--enable-cplusplus"
       ;; In GNU/Hurd systems during the 'Check' phase,
       ;; there is a deadlock caused by the 'gctest' test.
       ;; To disable the error set "--disable-gcj-support"
       ;; to configure script. See bug report and discussion:
       ;; <https://lists.opendylan.org/pipermail/bdwgc/2017-April/006275.html>
       ;; <https://lists.gnu.org/archive/html/bug-hurd/2017-01/msg00008.html>
       ,@(if (hurd-triplet? (or (%current-system)
                                (%current-target-system)))
             '("--disable-gcj-support")
             '()))))
   (native-inputs `(("pkg-config" ,pkg-config)))
   (inputs `(("libatomic-ops" ,libatomic-ops)))
   (outputs '("out" "debug"))
   (synopsis "The Boehm-Demers-Weiser conservative garbage collector
for C and C++")
   (description
    "The Boehm-Demers-Weiser conservative garbage collector can be used
as a garbage collecting replacement for C malloc or C++ new.  It allows
you to allocate memory basically as you normally would, without
explicitly deallocating memory that is no longer useful.  The collector
automatically recycles memory when it determines that it can no longer
be otherwise accessed.

The collector is also used by a number of programming language
implementations that either use C as intermediate code, want to
facilitate easier interoperation with C libraries, or just prefer the
simple collector interface.

Alternatively, the garbage collector may be used as a leak detector for
C or C++ programs, though that is not its primary goal.")
   (home-page "http://www.hboehm.info/gc/")

   (license (x11-style (string-append home-page "license.txt")))))

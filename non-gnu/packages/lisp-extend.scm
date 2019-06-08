(define-module (non-gnu packages lisp-extend)
  #:use-module (gnu packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages ed)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages libffcall)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libsigsegv)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-19))

(define-public stumpwm-master
  (let ((commit "e7c762c4cd6aec0efcd99819f7288adb423cad56")
        (revision "0"))
    (package
     (name "stumpwm")
     (version (git-version "18.11" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://github.com/stumpwm/stumpwm.git")
	     (commit commit)))
       (file-name (git-file-name name version))
       (sha256
	(base32
	 "07mm556qpbyxc1y6k8n0h2a27g3cwvxj9jl8k1gms8vggkz3k5ak"))))
     (build-system asdf-build-system/sbcl)
     (native-inputs `(("fiasco" ,sbcl-fiasco)
		      ("texinfo" ,texinfo)))
     (inputs `(("cl-ppcre" ,sbcl-cl-ppcre)
	       ("clx" ,sbcl-clx-master)
	       ("alexandria" ,sbcl-alexandria)))
     (outputs '("out" "lib"))
     (arguments
      '(#:asd-system-name "stumpwm"
	#:phases
	(modify-phases %standard-phases
		       (add-after 'create-symlinks 'build-program
				  (lambda* (#:key outputs #:allow-other-keys)
				    (build-program
				     (string-append (assoc-ref outputs "out") "/bin/stumpwm")
				     outputs
				     #:entry-program '((stumpwm:stumpwm) 0))))
		       (add-after 'build-program 'create-desktop-file
				  (lambda* (#:key outputs #:allow-other-keys)
				    (let* ((out (assoc-ref outputs "out"))
					   (xsessions (string-append out "/share/xsessions")))
				      (mkdir-p xsessions)
				      (call-with-output-file
					  (string-append xsessions "/stumpwm-master.desktop")
					(lambda (file)
					  (format file
						  "[Desktop Entry]~@
                                                   Name=stumpwm-master~@
                                                   Comment=The Stump Window Manager~@
                                                   Exec=~a/bin/stumpwm~@
                                                   TryExec=~@*~a/bin/stumpwm~@
                                                   Icon=~@
                                                   Type=Application~%"
						  out)))
				      #t)))
		       (add-after 'install 'install-manual
				  (lambda* (#:key outputs #:allow-other-keys)
				    ;; The proper way to the manual is bootstrapping a full autotools
				    ;; build system and running ‘./configure && make stumpwm.info’ to
				    ;; do some macro substitution.  We can get away with much less.
				    (let* ((out  (assoc-ref outputs "out"))
					   (info (string-append out "/share/info")))
				      (invoke "makeinfo" "stumpwm.texi.in")
				      (install-file "stumpwm.info" info)
				      #t))))))
     (synopsis "Window manager written in Common Lisp")
     (description "Stumpwm is a window manager written entirely in Common Lisp.
It attempts to be highly customizable while relying entirely on the keyboard
for input.  These design decisions reflect the growing popularity of
productive, customizable lisp based systems.")
     (home-page "https://github.com/stumpwm/stumpwm")
     (license license:gpl2+)
     (properties `((cl-source-variant . ,(delay cl-stumpwm)))))))
  
(define-public sbcl-clx-master
  (let ((commit "4b9c2026c98e81af5734106dc19a6609c2cbe5ab")
        (revision "1"))
    (package
     (name "sbcl-clx")
     (version (git-version "0.7.5" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://github.com/sharplispers/clx.git")
	     (commit commit)))
       (file-name (string-append "clx-" version "-checkout"))
       (sha256
	(base32
	 "0apwflfr0l8hwfn3vcchll3zw6g19qq4d6cgi0mac13m95rmpzvg"))))
     (build-system asdf-build-system/sbcl)
     (propagated-inputs
      `(("sbcl-fiasco" ,sbcl-fiasco)))
     (home-page "http://www.cliki.net/portable-clx")
     (synopsis "X11 client library for Common Lisp")
     (description "CLX is an X11 client library for Common Lisp.  The code was
originally taken from a CMUCL distribution, was modified somewhat in order to
make it compile and run under SBCL, then a selection of patches were added
from other CLXes around the net.")
     (license license:x11))))

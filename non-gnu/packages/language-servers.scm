(define-module (non-gnu packages language-servers)
  #:use-module (srfi srfi-1)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages code)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages web)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages check)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages llvm))

;; Modified from https://github.com/trivialfis/guixpkgs
(define-public ccls-tagged
  (package
   (name "ccls")
   (version "0.20190314.1")
   (home-page "https://github.com/MaskRay/ccls")
   (source (origin
	    (method url-fetch)
	    (uri (string-append
		  "https://github.com/MaskRay/ccls/archive/"
		  version ".tar.gz"))
	    (sha256
             (base32
	      "0msf479by5vd4qk9p52hq1jvbg4135a390xaxfhk1dbiq1knf581"))
	    (file-name (string-append name "-" version ".tar.gz"))))
   (build-system cmake-build-system)
   (arguments
    `(#:configure-flags
      (list "-DUSE_SYSTEM_RAPIDJSON=ON"
	    (string-append "-DCMAKE_CXX_FLAGS='-isystem "
			   (assoc-ref %build-inputs "gcc-toolchain")
			   "/include/c++'"))
      #:tests? #f))
   (native-inputs
    `(("rapidjson" ,rapidjson)
      ("gcc-toolchain" ,gcc-toolchain-7)))
   (inputs
    `(("clang" ,clang)
      ("ncurses" ,ncurses)))
   (synopsis "C/C++/ObjC language server.")
   (description "C/C++/ObjC language server.")
   (license license:expat)))

(define-public python-language-server-tagged
  (package
    (name "python-language-server")
    (version "0.27.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "python-language-server" version))
       (sha256
        (base32
         "0rdixdix4vrvzszpd6m87l243lwkrlmz23yqaqpw7isbpm1x1ikp"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-pluggy" ,python-pluggy)
       ("python-jsonrpc-server" ,python-jsonrpc-server)
       ("python-jedi" ,python-jedi)
       ("python-yapf" ,python-yapf)
       ("python-pyflakes" ,python-pyflakes)
       ("python-pydocstyle" ,python-pydocstyle)
       ("python-pycodestyle" ,python-pycodestyle)
       ("python-mccabe" ,python-mccabe)
       ("python-rope" ,python-rope)
       ("python-autopep8" ,python-autopep8)
       ("python-pylint" ,python-pylint)))
    (home-page "https://github.com/palantir/python-language-server")
    (synopsis "Python implementation of the Language Server Protocol")
    (description
     "The Python Language Server (pyls) is an implementation of the Python 3
language specification for the Language Server Protocol (LSP).  This tool is
used in text editing environments to provide a complete and integrated
feature-set for programming Python effectively.")
    (license license:expat)))

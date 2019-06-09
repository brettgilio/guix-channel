(define-module (non-gnu packages coq-extend)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages coq)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages version-control)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system ocaml)
  #:use-module (guix download)
  #:use-module (guix deprecation)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module ((srfi srfi-1) #:hide (zip)))

;; Stop tracking tags, and track master instead
(define-public proof-general-master
  (let ((commit "9ebfbb6abbd5480b434ceadebec824d7c8804e73")
        (revision "5"))
    (package
     (name "proof-general")
     (version (git-version "4.4" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/ProofGeneral/PG.git")
                    (commit commit)))
              (sha256
               (base32
                "1p7i3ms6lny3yr7wrdpazchxryai329vx43qgvbqdrh51kdxyfvv"))
              (file-name (git-file-name name version))))
     (build-system gnu-build-system)
     (native-inputs
      `(("which" ,which)
	("emacs" ,emacs-minimal)
	("texinfo" ,texinfo)))
     (inputs
      `(("host-emacs" ,emacs)
	("perl" ,perl)
	("coq" ,coq-tagged)))
     (arguments
      `(#:tests? #f  ; no check target
	#:make-flags (list (string-append "PREFIX=" %output)
                           (string-append "DEST_PREFIX=" %output))
	#:phases
	(modify-phases %standard-phases
		       (delete 'configure))))
     (home-page "http://proofgeneral.inf.ed.ac.uk/")
     (synopsis "Generic front-end for proof assistants based on Emacs")
     (description
      "Proof General is a major mode to turn Emacs into an interactive proof
assistant to write formal mathematical proofs using a variety of theorem
provers.")
     (license license:gpl2+))))

(define-public coq-tagged
  (deprecated-package "coq" coq))

(define-public coq-mathcomp-tagged
  (let ((commit "748d716efb2f2f75946c8386e441ce1789806a39")
        (revision "0"))
    (package
     (name "coq-mathcomp")
     (version (git-version "1.9.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/math-comp/math-comp.git")
                    (commit commit)))
              (sha256
               (base32
                "19dk4nbx3rrnlnkk4kvakbsafv2saawhp4z9p67fmilc6q7aydq0"))
              (file-name (git-file-name name version))))
     (build-system gnu-build-system)
     (native-inputs
      `(("ocaml" ,ocaml)
	("which" ,which)
	("coq" ,coq)))
     (arguments
      `(#:tests? #f             ; no need to test formally-verified programs :)
	#:phases
	(modify-phases %standard-phases
		       (delete 'configure)
		       (add-before 'build 'chdir
				   (lambda _ (chdir "mathcomp") #t))
		       (replace 'install
				(lambda* (#:key outputs #:allow-other-keys)
				  (setenv "COQLIB" (string-append (assoc-ref outputs "out") "/lib/coq/"))
				  (invoke "make" "-f" "Makefile.coq"
					  (string-append "COQLIB=" (assoc-ref outputs "out")
							 "/lib/coq/")
					  "install"))))))
     (home-page "https://math-comp.github.io/math-comp/")
     (synopsis "Mathematical Components for Coq")
     (description "Mathematical Components for Coq has its origins in the formal
proof of the Four Colour Theorem.  Since then it has grown to cover many areas
of mathematics and has been used for large scale projects like the formal proof
of the Odd Order Theorem.

The library is written using the Ssreflect proof language that is an integral
part of the distribution.")
     (license license:cecill-b))))

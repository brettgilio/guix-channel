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
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module ((srfi srfi-1) #:hide (zip)))

;; Stop tracking tags, and track master instead
(define-public proof-general-master
  (let ((commit "0058999ac42d7d1b3ee093aa5a4e8956d1eb8a9c")
        (revision "4"))
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
                "0q4qm0vi08wrl0wdlz5fhyfj8g4w8l1k5jyhfflig7pnjdw19lqa"))
              (file-name (git-file-name name version))))
     (build-system gnu-build-system)
     (native-inputs
      `(("which" ,which)
	("emacs" ,emacs-minimal)
	("texinfo" ,texinfo)))
     (inputs
      `(("host-emacs" ,emacs)
	("perl" ,perl)
	("coq" ,coq)))
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

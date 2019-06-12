(define-module (non-gnu packages compcert)
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

;; WIP

;; (define-public compcert-tagged
;;   (let ((commit "72ba1c282e2a8bfd0e826352a251fa71bfb71e05")
;;         (revision "0"))
;;     (package
;;      (name "compcert")
;;      (version (git-version "3.5" revision commit))
;;      (source (origin
;;               (method git-fetch)
;;               (uri (git-reference
;;                     (url "https://github.com/AbsInt/CompCert.git")
;;                     (commit commit)))
;;               (sha256
;;                (base32
;;                 "1g8067a5x3vd0l47d04gjvy5yx49nghh55am5d1fbrjirfsnsz8j"))
;;               (file-name (git-file-name name version))))
;;      (build-system gnu-build-system)
;;      (home-page "http://proofgeneral.inf.ed.ac.uk/")
;;      (synopsis "Generic front-end for proof assistants based on Emacs")
;;      (description
;;       "Proof General is a major mode to turn Emacs into an interactive proof
;; assistant to write formal mathematical proofs using a variety of theorem
;; provers.")
;;      (license license:gpl2+))))

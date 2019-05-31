(define-module (non-gnu packages meta-packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix cvs-download)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (non-gnu packages emacs-extend))

(define %meta-base
  (package
    (name #f)
    (version "1")
    (source #f)
    (build-system trivial-build-system)
    (arguments '(#:builder (begin (mkdir %output) #t)))
    (synopsis #f)
    (home-page #f)
    (description #f)
    (license #f)))

(define-public meta-emacs
  (package
   (inherit %meta-base)
   (name "meta-emacs")
   (propagated-inputs
    `(("emacs" ,emacs)
      ("emacs-all-the-icons" ,emacs-all-the-icons-master)
      ("emacs-auto-compile" ,emacs-auto-compile-tagged)
      ("emacs-company" ,emacs-company)
      ("emacs-company-quickhelp" ,emacs-company-quickhelp)
      ("emacs-doom-modeline" ,emacs-doom-modeline-tagged)
      ("emacs-fancy-battery" ,emacs-fancy-battery-master)
      ("emacs-gitpatch" ,emacs-gitpatch)
      ("emacs-guix" ,emacs-guix)
      ("emacs-helm" ,emacs-helm)
      ("emacs-magit" ,emacs-magit)
      ("emacs-magit-popup" ,emacs-magit-popup)
      ("emacs-nix-mode" ,emacs-nix-mode)
      ("emacs-pdf-tools" ,emacs-pdf-tools)
      ("emacs-use-package" ,emacs-use-package)
      ("emacs-webpaste" ,emacs-webpaste-tagged)
      ("emacs-yasnippet" ,emacs-yasnippet)))))

(define-public meta-lsp
  (package
   (inherit %meta-base)
   (name "meta-lsp")
   (propagated-inputs
    `(("emacs-company-lsp" ,emacs-company-lsp)
      ("emacs-lsp-mode" ,emacs-lsp-mode)
      ("emacs-lsp-ui" ,emacs-lsp-ui)))))

(define-public meta-python
  (package
   (inherit %meta-base)
   (name "meta-python")
   (propagated-inputs
    `(("meta-emacs" ,meta-emacs)
      ("meta-lsp" ,meta-lsp)
      ("python" ,python)
      ("python" ,python "tk")
      ("python-language-server"
       ,python-language-server)))))

(define-public meta-cobjc
  (package
   (inherit %meta-base)
   (name "meta-cobjc")
   (propagated-inputs
    `(("meta-emacs" ,meta-emacs)
      ("meta-lsp" ,meta-lsp)
      ("emacs-ccls" ,emacs-ccls-master)
      ("ccls" ,ccls-tagged)
      ("gcc-toolchain" ,gcc-toolchain)))))


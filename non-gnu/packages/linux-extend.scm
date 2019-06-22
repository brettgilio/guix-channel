(define-module (non-gnu packages linux-extend)
  #:use-module (gnu)
  #:use-module (gnu system nss)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (srfi srfi-1))

(define (linux-nonfree-urls version)
  "Return a list of URLs for Linux-Nonfree VERSION."
  (list (string-append
         "https://www.kernel.org/pub/linux/kernel/v4.x/"
         "linux-" version ".tar.xz")))

(define-public linux-nonfree-4.19
  (let* ((version "4.19.53"))
    (package
     (inherit linux-libre)
     (name "linux-nonfree")
     (version version)
     (source (origin
	      (method url-fetch)
	      (uri (linux-nonfree-urls version))
	      (sha256
	       (base32
		"00pbppnn57x7c86cnpv49iwyn2asxpkd9gkspp1p1b5ggq5p6iz6"))))
     (synopsis "Mainline Linux kernel, nonfree binary blobs included.")
     (description "Linux is a kernel.")
     (home-page "http://kernel.org/")
     (license license:gpl2))))

(define-public iwlwifi-firmware-nonfree
  (package
   (name "iwlwifi-firmware-nonfree")
   (version "1884732e01bec25affbd5d3366b187b757b095db")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
		  (commit version)))
	    (sha256
	     (base32
	      "0dbnib2gh8kajyys3pps99lp5s4k6b26v2jmbq2x3vbl9fa1xgda"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder (begin
		  (use-modules (guix build utils))
		  (let ((source (assoc-ref %build-inputs "source"))
			(fw-dir (string-append %output "/lib/firmware")))
		    (mkdir-p fw-dir)
		    (for-each (lambda (file)
				(copy-file file
					   (string-append fw-dir "/"
							  (basename file))))
			      (find-files source "iwlwifi-.*\\.ucode$|LICENCE\\.iwlwifi_firmware$"))
		    #t))))
   (home-page "https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi")
   (synopsis "Non-free firmware for Intel wifi chips")
   (description "Non-free firmware for Intel wifi chips")
   (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.iwlwifi_firmware;hb=HEAD"))))

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
  (let* ((version "4.19.57"))
    (package
     (inherit linux-libre)
     (name "linux-nonfree")
     (version version)
     (source (origin
	      (method url-fetch)
	      (uri (linux-nonfree-urls version))
	      (sha256
	       (base32
		"11rz1pfphc4zkn3fbfavn1764g3ymp4b1bfnr7b630w8smcmfz1j"))))
     (synopsis "Mainline Linux kernel, nonfree binary blobs included.")
     (description "Linux is a kernel.")
     (home-page "http://kernel.org/")
     (license license:gpl2))))

(define-public iwlwifi-firmware-nonfree
  (let ((commit "0731d06eadc7d9c52e58f354727101813b8da6ea")
	(revision "7"))
    (package
     (name "iwlwifi-firmware-nonfree")
     (version (git-version "20190618" revision commit))
     (source (origin
	      (method git-fetch)
	      (uri (git-reference
		    (url "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git")
		    (commit commit)))
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
     (license (license:non-copyleft "http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git;a=blob_plain;f=LICENCE.iwlwifi_firmware;hb=HEAD")))))

(define-module (artwork)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:export (%artwork-channel))

(define %artwork-channel
  (let ((commit "defa3d04cb05b3de96e707877c17d6ad111a127b"))
    (origin
      (method git-fetch)
      (uri (git-reference
             (url "https://git.sr.ht/~brettgilio/artwork-channel")
             (commit commit)))
      (file-name (string-append "artwork-channel-" (string-take commit 7)
                                "-checkout"))
      (sha256
       (base32
        "1cn2pgp2dvxwkkzhiqvnsxgsy8dg8q5hmc9m317r0gd9sxk7ycr2")))))

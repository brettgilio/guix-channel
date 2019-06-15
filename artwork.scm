(define-module (artwork)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:export (%artwork-channel))

(define %artwork-channel
  (let ((commit "05421aa22ca0ccd8a21bbda4b99aaa421e7ffa70"))
    (origin
      (method git-fetch)
      (uri (git-reference
             (url "https://git.sr.ht/~brettgilio/artwork-channel")
             (commit commit)))
      (file-name (string-append "artwork-channel-" (string-take commit 7)
                                "-checkout"))
      (sha256
       (base32
        "1g8f1rdmj3nsf3j7b3d2vwynh18xil2kidb71h9lgs4qbacd3q9i")))))

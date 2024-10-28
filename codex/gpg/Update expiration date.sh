# gpg, expiration, edit key, update expiration date

gpg -Kv # --keyid-format=long (set in .gnupg/gpg.conf)
# gpg: enabled compatibility flags:
# gpg: using pgp trust model
# gpg: Note: signature key B__________ expired 2024-10-25 16:30:44
# [keyboxd]
# ---------
# sec   ed25519/B__________ 2021-10-26 [SC] [expired: 2024-10-25]
#       ****************************************
# uid                 [ expired] Anthony Polichronis Fischetti <tony.fischetti@gmail.com>
# ssb   cv25519/A************** 2021-10-26 [E] [expired: 2024-10-25]

gpg --edit-key B_________
gpg> expire
gpg> save
gpg> key 1 # for encryption subkey
gpg> expire
gpg> save
gpg> quit


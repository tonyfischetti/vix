gpg -a --export --export-options backup --output public.asc
gpg -a --export-ownertrust > trust.asc
gpg -a -o private.asc --export-options backup --export-secret-keys tony.fischetti@gmail.com


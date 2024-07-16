gpg --import public.asc
gpg --import-options restore --import private.asc
gpg --import-ownertrust trust.asc

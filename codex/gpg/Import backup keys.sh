# gpg, import, restore, backup

gpg --import public.asc
gpg --import-options restore --import private.asc
gpg --import-ownertrust trust.asc

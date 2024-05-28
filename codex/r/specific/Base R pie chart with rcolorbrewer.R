
library(RColorBrewer)

dat[, percent:=round(100*checkouts/dat[, sum(checkouts)], 2)]
setorder(dat, -checkouts)

pie(dat[, checkouts], sprintf("%s (%s%%)", dat[, type], dat[, percent]),
    main="Reading Room Checkouts by Material Type",
    sub="* types that represent less than 1% (Unsassigned, Prints, Serial, Score, VHS, etc...)",
    col=brewer.pal(dat[,.N], "Set3"))

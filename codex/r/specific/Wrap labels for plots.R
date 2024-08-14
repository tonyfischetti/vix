# r, strwrap, wrap, wrap labels for plots, paste, collapse, wrap labels for plots

dat[, label2:=sapply(label1, function (x) paste(strwrap(x, 20), collapse="\n"))]

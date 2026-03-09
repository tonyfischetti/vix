# r, melt, data.table

# To change a CSV like this
#
# uid,switch_1,code_1,switch_2,code_2,switch_3,code_3
# 0,TRUE,600X,,,,
# 1,FALSE,000X,TRUE,600X,,
# 2,FALSE,100X,FALSE,200X,TRUE,600X
#
# to this
#
# uid,switch,code
# 0,TRUE,600X
# 1,FALSE,000X
# 1,TRUE,600X
# 2,FALSE,100X
# 2,FALSE,200X
# 2,TRUE,600X


library(data.table)

dat %<>%
  melt(measure.vars = patterns("^switch_\\d+$",
                               "^code_\\d+$"),
       variable.name = "idx",
       value.name = c("switch", "code"))


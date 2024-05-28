
paste("one", "two")             # [1] "one two"
paste("pee", "poo", sep=",")    # [1] "one,two"

paste(c("one", "two"))          # [1] "one" "two"
paste(c("one", "two"),
      collapse="<>")            # [1] "one<>two"


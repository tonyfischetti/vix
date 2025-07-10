# r, mutate, mutate_if, mutate column conditionally

# --- data.table ---
char_cols <- names(dt)[sapply(dt, is.character)]
dt[, (char_cols) := lapply(.SD, toupper), .SDcols=char_cols]


# --- tidyverse ---
DT %>%
  dplyr::mutate_if(is.character, toupper)



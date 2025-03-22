# r, mutate, mutate_if, mutate column conditionally

DT %>%
  dplyr::mutate_if(is.character, toupper)


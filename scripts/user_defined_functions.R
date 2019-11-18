# User-defined function to standardize join keys.
standardize_key <- function(key, q){
  # first, convert to lower case
  clean_key <- stringr::str_to_lower(key)
  
  # next, replace stop words
  clean_key <- stringr::str_replace_all(clean_key, "[:punct:]|univ[a-z]*|insti[a-z]*|school|college| of | at ", " ")
  
  # next, replace multiple spaces with single spaces
  clean_key <- stringr::str_replace_all(clean_key, "[ ]+", " ")
  
  # finally, trim extra whitespace
  clean_key <- stringr::str_trim(clean_key)
  
  clean_key
}

# User-defined function to compute Levenshtein ratio distance.
lvr <- function(str_a = "", str_b = ""){
  if(max(str_length(c(str_a, str_b))) == 0){
    return(0)
  }
  return(stringdist::stringdist(str_a, str_b, method = "lv") / pmax(str_length(str_a), str_length(str_b)))
}

# User-defined function to fuzzy join on Levenshtein ratio.
lvr_inner_join <- function(x, y, by = NULL, max_dist = 1, distance_col = "dist"){
  fuzzy_inner_join(x,
                   y, 
                   by,
                   match_fun = function(a,b){lvr(a,b) <= max_dist}) %>%
    mutate(!!distance_col := lvr(paste0(by,".x"), paste0(by,".y")))
}

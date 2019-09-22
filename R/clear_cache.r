clear_cache <- function() {
  unlink(dir("caches", full.names = TRUE))
  if (".caches" %in% ls(envir = globalenv(), all.names = TRUE)) rm(list = ls(.caches), envir = .caches)
}

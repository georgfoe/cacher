# helper Functions

#' Title
#'
#' @return
#'
#' @examples
.create_build_dir <- function() {

  build.dir.name <- .get_build_dir_name()

  if (!dir.exists(build.dir.name)) {
    dir.create(build.dir.name)
  }
}

#' Title
#'
#' @return
#'
#' @examples
.get_build_dir_name <- function() {
  default <- getOption("build.dir")
  if (!is.null(default)) {
    return(default)
  } else {
    return("build")
  }
}

#' Title
#'
#' @return
#'
#' @examples
.get_cache_dir_name <- function() {
  default <- getOption("cache.dir")
  if (!is.null(default)) {
    return(default)
  } else {
    return("cache")
  }
}


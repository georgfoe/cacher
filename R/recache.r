#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
recache <- function(...) {

  #  cache.name <- substitute(cache.name)
  #  if (class(cache.name) == "name") cache.name <- deparse(cache.name)

  cache(..., reBuild = TRUE)
}

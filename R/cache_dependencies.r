#' Title
#'
#' @param cache.name
#'
#' @return
#' @export
#' @importFrom purrr map
#' @importFrom magrittr %>%
#' @importFrom stringr str_split
#'
#' @examples
cache_dependencies <- function(cache.name) {

  cache.name <- substitute(cache.name)
  if (class(cache.name) == "name") cache.name <- deparse(cache.name)

  build.file = paste0("build/", cache.name, ".r")

  readLines(build.file) %>%

    grep("cache\\(", ., value = TRUE) %>%

    str_split("cache\\(") %>%
    map(`[`, -1) %>%
    unlist() %>%

    str_split("\\)") %>%
    map(`[`, 1) %>%
    unlist() %>%
    unique()

}

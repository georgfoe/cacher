#' Title
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
list_caches <- function() {
  build.dir <- .get_build_dir_name()
  dir(build.dir) %>% tools::file_path_sans_ext()
}

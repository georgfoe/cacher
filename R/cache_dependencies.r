#' Title
#'
#' @param cache.names
#'
#' @return
#' @export
#'
#' @importFrom purrr map
#' @importFrom magrittr %>%
#' @importFrom stringr str_split
#'
#' @examples
cache_dependencies <- function(cache.names) {

  arg.name <- substitute(cache.names) %>% deparse()

  if (arg.name %in% list_caches()) cache.names = arg.name

  dep.list <- purrr::map(cache.names, function(cache.name) {

  build.file = paste0(cacher:::.get_build_dir_name(), "/", cache.name, ".r")

  readLines(build.file) %>%

    grep("cache\\(", ., value = TRUE) %>%

    str_split("cache\\(") %>%
    map(`[`, -1) %>%
    unlist() %>%

    str_split("\\)") %>%
    map(`[`, 1) %>%
    gsub("\"", "", .) %>%
    unlist() %>%
    unique() -> deps

    if (length(deps) == 0) return(NULL) else return(deps)

  })

  names(dep.list) <- cache.names

  if (length(dep.list) < 2) dep.list = dep.list[[1]]

  return(dep.list)

}

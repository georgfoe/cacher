#' Title
#'
#' @param cache.name
#' @param reBuild
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#'
cache <- function(cache.name, reBuild = FALSE) {

  #attach(.GlobalEnv$.caches)

  build.dir <- .get_build_dir_name()
  cache.dir <- .get_cache_dir_name()

  if (!dir.exists(cache.dir)) dir.create(cache.dir)
  if (!dir.exists(build.dir)) dir.create(build.dir)

  if (!(".caches" %in% ls(envir = globalenv(), all.names = TRUE))) .caches <<- new.env(parent = globalenv())

  cache.name <- substitute(cache.name)
  if (class(cache.name) == "name") cache.name <- deparse(cache.name)

  cache.name.full = paste0(".GlobalEnv$.caches$", cache.name)
  cache.file = paste0(cache.dir, "/", cache.name, ".RDS")
  build.file = paste0(build.dir, "/", cache.name, ".r")

  if (exists(cache.name, envir = .GlobalEnv$.caches) & !(reBuild)) {
    message("## Cache '", cache.name, "' ist bereits vorhanden ##")
    return(invisible(eval(parse(text = cache.name.full))))
  }

  if (file.exists(cache.file) & !(reBuild)) {
    message("## Cache '", cache.name, "' wird geladen ##")
    load.cache = paste0(cache.name.full, " = readRDS('", cache.file, "')")
    parse(text = load.cache) %>% eval()
    return(invisible(eval(parse(text = cache.name.full))))
  }

  message("## Cache '", cache.name, "' wird neu berechnet ##")
  instruction = paste0(cache.name.full, " = source('", build.file, "', local = TRUE, encoding = 'UTF8')$value")

  parse(text = instruction) %>% eval()

  save.cache = paste0("saveRDS(", cache.name.full, ", file = '", cache.file, "')")

  parse(text = save.cache) %>% eval()

  return(invisible(eval(parse(text = cache.name.full))))

}

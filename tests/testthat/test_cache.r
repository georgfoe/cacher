test_that("Cache is loaded successfully", {

  clear_cache()
  cacher:::.create_build_dir()
  writeLines("test = { runif(100, 1, 1000) }", paste0(cacher:::.get_build_dir_name(), "/test.r"))
  cache(test) -> x
  expect_true(file.exists(paste0(cacher:::.get_cache_dir_name(), "/test.rds")))
  expect_true(".caches" %in% ls(all.names = TRUE, envir = globalenv()))
  expect_true(length(x) == 100)

  unlink(cacher:::.get_build_dir_name(), recursive = TRUE)
  unlink(cacher:::.get_cache_dir_name(), recursive = TRUE)

})

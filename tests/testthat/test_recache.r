test_that("Cache is rebuild after calling recache", {


  clear_cache()
  build.dir <- cacher:::.get_build_dir_name()
  if (!dir.exists(build.dir)) dir.create(build.dir)
  writeLines("test = { runif(100, 1, 1000) }", paste0(build.dir, "/test.r"))
  cache(test) -> x1
  cache(test) -> x2
  recache(test) -> x3

  expect_equal(x1, x2)
  expect_true(all(x3 != x2))

  unlink(build.dir)
  unlink(cacher:::.get_cache_dir_name())

})

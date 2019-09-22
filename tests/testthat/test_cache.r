test_that("Cache is loaded successfully", {

  if (!dir.exists("build")) dir.create("build")
  writeLines("test = { runif(100, 1, 1000) }", "build/test.r")
  cache(test) -> x
  expect_true(file.exists("caches/test.rds"))
  expect_true(".caches" %in% ls(all.names = TRUE, envir = globalenv()))
  expect_true(length(x) == 100)

})

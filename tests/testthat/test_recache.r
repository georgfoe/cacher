test_that("Cache is rebuild after calling recache", {


  clear_cache()
  if (!dir.exists("build")) dir.create("build")
  writeLines("test = { runif(100, 1, 1000) }", "build/test.r")
  cache(test) -> x1
  cache(test) -> x2
  recache(test) -> x3

  expect_equal(x1, x2)
  expect_true(all(x3 != x2))

})

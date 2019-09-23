test_that("Dependencies on other caches are retrieved correctly from build code",
          {
            clear_cache()

            .create_build_dir()

            writeLines("test1 <- runif(100, 1, 1000)",
                       "build/test1.r")

            writeLines(c("test2 <- {",
                         "cache(test1) ^ 2",
                         "}"),
                       "build/test2.r")

            writeLines(c("test3 <- {",
                         "cache(test1) * cache(test2)",
                         "}"),
                       "build/test3.r")

            cache(test3) -> x

            dep1 <- cache_dependencies(test1)
            dep2 <- cache_dependencies(test2)
            dep3 <- cache_dependencies(test3)

            expect_equal(dep1, NULL)
            expect_equal(dep2, c("test1"))
            expect_equal(dep3, c("test1", "test2"))


            unlink("build", recursive = TRUE)
            unlink("caches", recursive = TRUE)
          })

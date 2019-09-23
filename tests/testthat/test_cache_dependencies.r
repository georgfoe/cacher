test_that("Dependencies on other caches are retrieved correctly from build code",
          {
            clear_cache()

            cacher:::.create_build_dir()
            build.dir <- cacher:::.get_build_dir_name()

            writeLines("test1 <- runif(100, 1, 1000)",
                       paste0(build.dir, "/test1.r"))

            writeLines(c("test2 <- {",
                         "cache(test1) ^ 2",
                         "}"),
                       paste0(build.dir, "/test2.r"))

            writeLines(c("test3 <- {",
                         "cache(test1) * cache(test2)",
                         "}"),
                       paste0(build.dir, "/test3.r"))

            cache(test3) -> x

            dep1 <- cache_dependencies(test1)
            dep2 <- cache_dependencies(test2)
            dep3 <- cache_dependencies(test3)

            expect_equal(dep1, NULL)
            expect_equal(dep2, c("test1"))
            expect_equal(dep3, c("test1", "test2"))


            unlink(cacher:::.get_build_dir_name(), recursive = TRUE)
            unlink(cacher:::.get_cache_dir_name(), recursive = TRUE)
          })

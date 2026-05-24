
data_path <- testthat::test_path("data/coord_test.xlsx")

test_that("convert_coords works", {
  test_wb <- openxlsx2::wb_load(data_path)
  test_data <- openxlsx2::wb_data(test_wb, sheet = 1)
  test_result <- convert_coords(test_data,
                                "Long",
                                "Lat",
                                "EPSG:4326",
                                "EPSG:26917")

  expect_equal(round(test_result$x, 1),
               c(641082.5, 642300.6, 640672.8, 641060.2))

  expect_equal(round(test_result$y), c(4405648, 4339055, 4427848, 4406858))
})

test_that("add_coords works", {
  test_wb <- openxlsx2::wb_load(data_path)
  test_wb$from_x_name <- "Long"
  test_wb$from_y_name <- "Lat"
  test_wb$from_crs <- "EPSG:4326"
  test_wb$to_crs <- "EPSG:26917"

  expect_no_error(test_wb$add_coords())

  test_result <- openxlsx2::wb_data(test_wb)

  expect_equal(round(test_result$x, 1),
               c(642300.6, 555935.9, 623597.0, 606504.6))

  expect_equal(round(test_result$y), c(4339055, 4337961, 4427551, 4428503))
})

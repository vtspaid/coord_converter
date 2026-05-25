
data_path <- testthat::test_path("data/coord_test.xlsx")

test_that("convert_coords works", {
  test_wb <- openxlsx2::wb_load(data_path)
  test_data <- openxlsx2::wb_data(test_wb, sheet = 1)
  test_result <- convert_coords(test_data,
                                "Long",
                                "Lat",
                                "EPSG:4326",
                                "EPSG:26917",
                                "x",
                                "y",
                                0)

  expect_equal(round(test_result$x, 1),
               c(641082, 642301, 640673, 641060))

  expect_equal(round(test_result$y), c(4405648, 4339055, 4427848, 4406858))
})

test_that("get_likely_columns works", {
  test_wb <- openxlsx2::wb_load(data_path)
  df <- openxlsx2::wb_data(test_wb, sheet = 1)
  colnames(df)[is.na(colnames(df))] <- "NA"
  expect_equal(get_likely_columns(colnames(df), x_coord_names),
               c("Long", "Tort", "Lat", "NA"))
  expect_equal(get_likely_columns(colnames(df), y_coord_names),
               c("Lat", "Tort", "Long", "NA"))
})

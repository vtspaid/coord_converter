
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{coordconvert}`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Installation

You can install the development version of `{coordconvert}` like so:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_git("https://github.com/vtspaid/coord_converter")
```

## Run

You can launch the application by running:

``` r
coordconvert::run_app()

# Or if you prefer to launch in a browser
coordconvert::run_app(options = list(launch.browser = TRUE))
```

# Create Shortcut

Note: only tested on windows.

If you wish to create a shortcut to run the app use the following code
to find the path to R’s executable

``` r
paste0(R.home(), "/bin/R.exe")
#> [1] "C:/PROGRA~1/R/R-45~1.1/bin/R.exe"
```

Then paste that result with quotation marks into a .bat file on windows
or a .sh file on Mac or Linux. Then add
`-e "coordconvert::run_app(options = list(launch.browser = TRUE))"` to
same line.

So the final file will have a line similar to this, however the first
portion will be different depending on the result of R.home()

`"C:/PROGRA~1/R/R-45~1.1/bin/R.exe" -e "coordconvert::run_app(options = list(launch.browser = TRUE))"`

Save it to your desktop and double click it to launch the app, or
optionally, save it somewhere else and create a shortcut to it. Note
that when it opens it will also open a terminal window. The terminal
window can be minimized but if it is closed it will close the app.

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2026-05-25 20:17:52 EDT"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading coordconvert
#> ── R CMD check results ──────────────────────────── coordconvert 0.0.0.9000 ────
#> Duration: 38.4s
#> 
#> ❯ checking for portable file names ... WARNING
#>   Found the following file with a non-portable file name:
#>     tests/testthat/data/.~lock.coord_test.xlsx#
#>   These are not fully portable file names.
#>   See section 'Package structure' in the 'Writing R Extensions' manual.
#> 
#> ❯ checking for hidden files and directories ... NOTE
#>   Found the following hidden files and directories:
#>     tests/testthat/data/.~lock.coord_test.xlsx#
#>   These were most likely included in error. See section 'Package
#>   structure' in the 'Writing R Extensions' manual.
#> 
#> ❯ checking top-level files ... NOTE
#>   Non-standard file/directory found at top level:
#>     'manifest.json'
#> 
#> ❯ checking package subdirectories ... NOTE
#>   Problems with news in 'NEWS.md':
#>   No news entries found.
#> 
#> ❯ checking dependencies in R code ... NOTE
#>   Namespaces in Imports field not imported from:
#>     'covr' 'pkgload' 'shinyFiles'
#>     All declared Imports should be used.
#> 
#> ❯ checking R code for possible problems ... NOTE
#>   convert_coords: no visible global function definition for
#>     'complete.cases'
#>   guess_crs: no visible global function definition for 'na.omit'
#>   Undefined global functions or variables:
#>     complete.cases na.omit
#>   Consider adding
#>     importFrom("stats", "complete.cases", "na.omit")
#>   to your NAMESPACE file.
#> 
#> 0 errors ✔ | 1 warning ✖ | 5 notes ✖
#> Error: R CMD check found WARNINGs
```

``` r
covr::package_coverage()
#> coordconvert Coverage: 41.98%
#> R/app_config.R: 0.00%
#> R/app_server.R: 0.00%
#> R/app_ui.R: 0.00%
#> R/mod_datatable.R: 0.00%
#> R/mod_sidebar.R: 0.00%
#> R/run_app.R: 0.00%
#> R/fct_helpers.R: 53.57%
#> R/golem_utils_ui.R: 97.24%
#> R/golem_utils_server.R: 100.00%
```

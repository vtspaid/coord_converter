
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{coordconvert}`

<!-- badges: start -->

<!-- badges: end -->

## Installation

You can install the development version of `{coordconvert}` like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Run

You can launch the application by running:

``` r
coordconvert::run_app()
```

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2026-05-22 18:25:21 MDT"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ══ Documenting ═════════════════════════════════════════════════════════════════
#> ℹ Installed roxygen2 version (7.3.3) doesn't match required (7.1.1)
#> ✖ `check()` will not re-document this package
#> ── R CMD check results ──────────────────────────── coordconvert 0.0.0.9000 ────
#> Duration: 31.1s
#> 
#> ❯ checking for portable file names ... WARNING
#>   Found the following file with a non-portable file name:
#>     test_data/.~lock.coord_test.xlsx#
#>   These are not fully portable file names.
#>   See section 'Package structure' in the 'Writing R Extensions' manual.
#> 
#> ❯ checking for hidden files and directories ... NOTE
#>   Found the following hidden files and directories:
#>     test_data/.~lock.coord_test.xlsx#
#>   These were most likely included in error. See section 'Package
#>   structure' in the 'Writing R Extensions' manual.
#> 
#> ❯ checking top-level files ... NOTE
#>   Non-standard file/directory found at top level:
#>     'test_data'
#> 
#> 0 errors ✔ | 1 warning ✖ | 2 notes ✖
#> Error: R CMD check found WARNINGs
```

``` r
covr::package_coverage()
#> Error in loadNamespace(x): there is no package called 'covr'
```

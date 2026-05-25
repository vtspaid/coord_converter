
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
#> Loading required package: remotes
remotes::install_git("https://github.com/vtspaid/coord_converter")
#> Downloading git repo https://github.com/vtspaid/coord_converter
#> "C:\PROGRA~1\Git\cmd\git.exe" clone --depth 1 --no-hardlinks https://github.com/vtspaid/coord_converter C:\Users\vtspa\AppData\Local\Temp\RtmpCgH3jL\file4a0c430422d9
#> rappdirs    (0.3.3   -> 0.3.4    ) [CRAN]
#> fs          (1.6.6   -> 2.1.0    ) [CRAN]
#> magrittr    (2.0.3   -> 2.0.5    ) [CRAN]
#> Rcpp        (1.0.12  -> 1.1.1-1.1) [CRAN]
#> digest      (0.6.37  -> 0.6.39   ) [CRAN]
#> sass        (0.4.9   -> 0.4.10   ) [CRAN]
#> base64enc   (0.1-3   -> 0.1-6    ) [CRAN]
#> xtable      (1.8-4   -> 1.8-8    ) [CRAN]
#> sourcetools (0.1.7-1 -> 0.1.7-2  ) [CRAN]
#> rlang       (1.1.3   -> 1.2.0    ) [CRAN]
#> promises    (1.3.0   -> 1.5.0    ) [CRAN]
#> mime        (0.12    -> 0.13     ) [CRAN]
#> lifecycle   (1.0.4   -> 1.0.5    ) [CRAN]
#> later       (1.3.2   -> 1.4.8    ) [CRAN]
#> jsonlite    (1.8.8   -> 2.0.0    ) [CRAN]
#> httpuv      (1.6.15  -> 1.6.17   ) [CRAN]
#> htmltools   (0.5.8.1 -> 0.5.9    ) [CRAN]
#> glue        (1.7.0   -> 1.8.1    ) [CRAN]
#> fastmap     (1.1.1   -> 1.2.0    ) [CRAN]
#> cli         (3.6.5   -> 3.6.6    ) [CRAN]
#> cachem      (1.0.8   -> 1.1.0    ) [CRAN]
#> bslib       (0.9.0   -> 0.11.0   ) [CRAN]
#> utf8        (1.2.4   -> 1.2.6    ) [CRAN]
#> vctrs       (0.6.5   -> 0.7.3    ) [CRAN]
#> cpp11       (0.5.2   -> 0.5.5    ) [CRAN]
#> tibble      (3.2.1   -> 3.3.1    ) [CRAN]
#> hms         (1.1.3   -> 1.1.4    ) [CRAN]
#> bit64       (4.6.0-1 -> 4.8.2    ) [CRAN]
#> ps          (1.9.1   -> 1.9.3    ) [CRAN]
#> processx    (3.8.6   -> 3.9.0    ) [CRAN]
#> yaml        (2.3.10  -> 2.3.12   ) [CRAN]
#> tinytex     (0.57    -> 0.59     ) [CRAN]
#> xfun        (0.53    -> 0.57     ) [CRAN]
#> highr       (0.11    -> 0.12     ) [CRAN]
#> rmarkdown   (2.30    -> 2.31     ) [CRAN]
#> knitr       (1.50    -> 1.51     ) [CRAN]
#> lazyeval    (0.2.2   -> 0.2.3    ) [CRAN]
#> shiny       (1.8.1.1 -> 1.13.0   ) [CRAN]
#> vroom       (1.6.6   -> 1.7.1    ) [CRAN]
#> clipr       (0.8.0   -> 0.8.1    ) [CRAN]
#> terra       (1.8-70  -> 1.9-27   ) [CRAN]
#> shinyjs     (2.1.0   -> 2.1.1    ) [CRAN]
#> readr       (2.1.5   -> 2.2.0    ) [CRAN]
#> pkgload     (1.4.1   -> 1.5.2    ) [CRAN]
#> openxlsx2   (1.26    -> 1.27     ) [CRAN]
#> Installing 45 packages: rappdirs, fs, magrittr, Rcpp, digest, sass, base64enc, xtable, sourcetools, rlang, promises, mime, lifecycle, later, jsonlite, httpuv, htmltools, glue, fastmap, cli, cachem, bslib, utf8, vctrs, cpp11, tibble, hms, bit64, ps, processx, yaml, tinytex, xfun, highr, rmarkdown, knitr, lazyeval, shiny, vroom, clipr, terra, shinyjs, readr, pkgload, openxlsx2
#> Installing packages into 'C:/Users/vtspa/AppData/Local/Temp/RtmpS2nlXi/temp_libpath746c14b6755b'
#> (as 'lib' is unspecified)
#> 
#>   There are binary versions available but the source versions are later:
#>           binary source needs_compilation
#> clipr      0.8.0  0.8.1             FALSE
#> openxlsx2   1.26   1.27              TRUE
#> 
#> package 'rappdirs' successfully unpacked and MD5 sums checked
#> package 'fs' successfully unpacked and MD5 sums checked
#> package 'magrittr' successfully unpacked and MD5 sums checked
#> package 'Rcpp' successfully unpacked and MD5 sums checked
#> package 'digest' successfully unpacked and MD5 sums checked
#> package 'sass' successfully unpacked and MD5 sums checked
#> package 'base64enc' successfully unpacked and MD5 sums checked
#> package 'xtable' successfully unpacked and MD5 sums checked
#> package 'sourcetools' successfully unpacked and MD5 sums checked
#> package 'rlang' successfully unpacked and MD5 sums checked
#> package 'promises' successfully unpacked and MD5 sums checked
#> package 'mime' successfully unpacked and MD5 sums checked
#> package 'lifecycle' successfully unpacked and MD5 sums checked
#> package 'later' successfully unpacked and MD5 sums checked
#> package 'jsonlite' successfully unpacked and MD5 sums checked
#> package 'httpuv' successfully unpacked and MD5 sums checked
#> package 'htmltools' successfully unpacked and MD5 sums checked
#> package 'glue' successfully unpacked and MD5 sums checked
#> package 'fastmap' successfully unpacked and MD5 sums checked
#> package 'cli' successfully unpacked and MD5 sums checked
#> package 'cachem' successfully unpacked and MD5 sums checked
#> package 'bslib' successfully unpacked and MD5 sums checked
#> package 'utf8' successfully unpacked and MD5 sums checked
#> package 'vctrs' successfully unpacked and MD5 sums checked
#> package 'cpp11' successfully unpacked and MD5 sums checked
#> package 'tibble' successfully unpacked and MD5 sums checked
#> package 'hms' successfully unpacked and MD5 sums checked
#> package 'bit64' successfully unpacked and MD5 sums checked
#> package 'ps' successfully unpacked and MD5 sums checked
#> package 'processx' successfully unpacked and MD5 sums checked
#> package 'yaml' successfully unpacked and MD5 sums checked
#> package 'tinytex' successfully unpacked and MD5 sums checked
#> package 'xfun' successfully unpacked and MD5 sums checked
#> package 'highr' successfully unpacked and MD5 sums checked
#> package 'rmarkdown' successfully unpacked and MD5 sums checked
#> package 'knitr' successfully unpacked and MD5 sums checked
#> package 'lazyeval' successfully unpacked and MD5 sums checked
#> package 'shiny' successfully unpacked and MD5 sums checked
#> package 'vroom' successfully unpacked and MD5 sums checked
#> package 'terra' successfully unpacked and MD5 sums checked
#> package 'shinyjs' successfully unpacked and MD5 sums checked
#> package 'readr' successfully unpacked and MD5 sums checked
#> package 'pkgload' successfully unpacked and MD5 sums checked
#> 
#> The downloaded binary packages are in
#>  C:\Users\vtspa\AppData\Local\Temp\RtmpCgH3jL\downloaded_packages
#> installing the source packages 'clipr', 'openxlsx2'
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>          checking for file 'C:\Users\vtspa\AppData\Local\Temp\RtmpCgH3jL\file4a0c430422d9/DESCRIPTION' ...  ✔  checking for file 'C:\Users\vtspa\AppData\Local\Temp\RtmpCgH3jL\file4a0c430422d9/DESCRIPTION'
#>       ─  preparing 'coordconvert': (1s)
#>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
#>       ─  excluding invalid files
#>    Subdirectory 'R' contains invalid file names:
#>      '_disable_autoload.R'
#>       ─  checking for LF line-endings in source and make files and shell scripts
#>       ─  checking for empty or unneeded directories
#>      Omitted 'LazyData' from DESCRIPTION
#>       ─  building 'coordconvert_0.0.0.9000.tar.gz'
#>      
#> 
#> Installing package into 'C:/Users/vtspa/AppData/Local/Temp/RtmpS2nlXi/temp_libpath746c14b6755b'
#> (as 'lib' is unspecified)
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
or a .sh file on Mac or Linux. Then add \`-e
“coordconvert::run_app(options = list(launch.browser = TRUE))” to same
line.

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
#> [1] "2026-05-25 18:31:33 EDT"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]): namespace 'fastmap' 1.1.1 is already loaded, but >= 1.2.0 is required
```

``` r
covr::package_coverage()
#> Error in loadNamespace(x): there is no package called 'covr'
```

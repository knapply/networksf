
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![R build
status](https://github.com/knapply/networksf/workflows/R-CMD-check/badge.svg)](https://github.com/knapply/networksf/actions?workflow=R-CMD-check)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/knapply/networksf?branch=master&svg=true)](https://ci.appveyor.com/project/knapply/networksf)
[![Travis-CI Build
Status](https://travis-ci.org/knapply/networksf.svg?branch=master)](https://travis-ci.org/knapply/networksf)
[![Depends](https://img.shields.io/badge/Depends-GNU_R%3E=3.3-blue.svg)](https://www.r-project.org/)
[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub code size in
bytes](https://img.shields.io/github/languages/code-size/knapply/networksf.svg)](https://github.com/knapply/networksf)
[![HitCount](http://hits.dwyl.io/knapply/networksf.svg)](http://hits.dwyl.io/knapply/networksf)
<!-- badges: end -->

## Introduction

[`{networksf}`](https://github.com/knapply/networksf) provides data
structures and routines facilitating spatial network analysis using
[`{statnet}`](http://statnet.org/)’s
[`{network}`](https://cran.r-project.org/web/packages/network/index.html)
and [`{sf}`](https://r-spatial.github.io/sf/index.html).

### Goals

  - [ ] flexible data structures to describe complex spatial networks
  - [ ] arbitrary geometries to represent vertices, edges, and entire
    networks
  - [ ] powerful and efficient spatial network analysis routines
  - [ ] simple interoperability with relevant tools from R’s network and
    spatial ecosystems

## Installation

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")

remotes::install_github("knapply/networksf")
```

## Usage

``` r
library(networksf)
```

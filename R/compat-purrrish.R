.map <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
}
map_mold <- function(.x, .f, .mold, ...) {
  out <- vapply(.x, .f, .mold, ..., USE.NAMES = FALSE)
  names(out) <- names(.x)
  out
}
.map_lgl <- function(.x, .f, ...) {
  map_mold(.x, .f, logical(1), ...)
}
.map_int <- function(.x, .f, ...) {
  map_mold(.x, .f, integer(1), ...)
}
.map_dbl <- function(.x, .f, ...) {
  map_mold(.x, .f, double(1), ...)
}
.map_chr <- function(.x, .f, ...) {
  map_mold(.x, .f, character(1), ...)
}




.map2 <- function(.x, .y, .f, ...) {
  out <- mapply(.f, .x, .y, MoreArgs = list(...), SIMPLIFY = FALSE)
  if (length(out) == length(.x)) {
    .set_names(out, names(.x))
  } else {
    .set_names(out, NULL)
  }
}
.map2_lgl <- function(.x, .y, .f, ...) {
  as.vector(.map2(.x, .y, .f, ...), "logical")
}
.map2_int <- function(.x, .y, .f, ...) {
  as.vector(.map2(.x, .y, .f, ...), "integer")
}
.map2_dbl <- function(.x, .y, .f, ...) {
  as.vector(.map2(.x, .y, .f, ...), "double")
}
.map2_chr <- function(.x, .y, .f, ...) {
  as.vector(.map2(.x, .y, .f, ...), "character")
}

args_recycle <- function(args) {
  lengths <- .map_int(args, length)
  n <- max(lengths)
  
  stopifnot(all(lengths == 1L | lengths == n))
  to_recycle <- lengths == 1L
  args[to_recycle] <- .map(args[to_recycle], function(x) rep.int(x, n))
  
  args
}
.pmap <- function(.l, .f, ...) {
  args <- args_recycle(.l)
  do.call("mapply", c(
    FUN = list(quote(.f)),
    args, MoreArgs = quote(list(...)),
    SIMPLIFY = FALSE, USE.NAMES = FALSE
  ))
}

probe <- function(.x, .p, ...) {
  if (is.logical(.p)) {
    stopifnot(length(.p) == length(.x))
    .p
  } else {
    .map_lgl(.x, .p, ...)
  }
}

.keep <- function(.x, .f, ...) {
  .x[probe(.x, .f, ...)]
}

.discard <- function(.x, .p, ...) {
  sel <- probe(.x, .p, ...)
  .x[is.na(sel) | !sel]
}

.map_if <- function(.x, .p, .f, ...) {
  matches <- probe(.x, .p)
  .x[matches] <- .map(.x[matches], .f, ...)
  .x
}

.compact <- function(.x) {
  Filter(length, .x)
}


.imap <- function(.x, .f, ...) {
  .map2(.x, vec_index(.x), .f, ...)
}
vec_index <- function(x) {
  names(x) %||% seq_along(x)
}


.is_empty <- function(x) {
  length(x) == 0L
}

.set_names <- function(x, nm = x, ...) {
  stopifnot(length(x) == length(nm))
  names(x) <- nm
  x
}

`%||%` <- function(lhs, rhs) {
  if (is.null(lhs)) rhs else lhs
}
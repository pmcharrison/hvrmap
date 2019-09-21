`.` <- NULL

#' Generate transposition mapping
#'
#' Generates a mapping between pitch-class chords and their transpositions.
#' For more information see \code{\link{pc_chord_transpositions}}.
#'
#' @export
generate_transpose_pc_chord_id <- function() {
  pc_chords <- hrep::list_chords("pc_chord")
  n <- length(pc_chords)
  x <- matrix(nrow = 12, ncol = n)
  message("Generating transpose_pc_chord_id mapping...")
  pb <- utils::txtProgressBar(max = n, style = 3)
  for (i in seq_len(n)) {
    x[, i] <- purrr::map(0:11, ~ hrep::tp(pc_chords[[i]], interval = .)) %>%
      hrep::vec("pc_chord") %>%
      hrep::encode() %>%
      as.integer()
    utils::setTxtProgressBar(pb, i)
  }
  close(pb)
  message("Done.")
  x
}

#' Transpose pitch-class chord
#'
#' Transposes a series of pitch-class chords by a given interval.
#'
#' @param pc_chord_id
#' An integer vector corresponding to pitch-class chords as encoded
#' using the \code{hrep} package (https://pmcharrison.github.io/hrep).
#'
#' @param interval
#' A single integer between 0 and 12, corresponding to the pitch-class
#' interval by which the pitch-class chords ought to be transposed.
#'
#' @return
#' An integer vector corresponding to transposed pitch-class chords
#' encoded using the encoding scheme from the \code{hrep} package.
#'
#' @export
transpose_pc_chord_id <- function(pc_chord_id, interval) {
  checkmate::qassert(interval, "X1")
  hvrmap::pc_chord_transpositions[(interval %% 12L) + 1L, pc_chord_id]
}

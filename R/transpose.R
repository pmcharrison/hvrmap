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

#' @export
transpose_pc_chord_id <- function(pc_chord_id, interval) {
  checkmate::qassert(interval, "X1")
  hvrmap::pc_chord_transpositions[(interval %% 12L) + 1L, pc_chord_id]
}

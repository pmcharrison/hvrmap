test_that("misc", {
  pc_int <- 1
  pc_chord_transpositions[pc_int + 1, hrep::encode_pc_chord(c(0, 4, 7))] %>%
    hrep::decode_pc_chord() %>%
    expect_equal(hrep::pc_chord(c(1, 5, 8)))

  pc_int <- 5
  pc_chord_transpositions[pc_int + 1, hrep::encode_pc_chord(c(0, 1, 2))] %>%
    hrep::decode_pc_chord() %>%
    expect_equal(hrep::pc_chord(c(5, 6, 7)))

  pc_int <- 5
  pc_chord_transpositions[pc_int + 1, hrep::encode_pc_chord(c(8, 11))] %>%
    hrep::decode_pc_chord() %>%
    expect_equal(hrep::pc_chord(c(1, 4)))

  chords <- c(
    hrep::encode_pc_chord(c(0, 3, 7)),
    hrep::encode_pc_chord(c(0, 2, 4))
  )
  pc_int <- 2
  pc_chord_transpositions[pc_int + 1, chords] %>%
    purrr::map(hrep::decode_pc_chord) %>%
    expect_equal(list(
      hrep::pc_chord(c(2, 5, 9)),
      hrep::pc_chord(c(2, 4, 6))
    ))

  transpose_pc_chord_id(chords, pc_int) %>%
    purrr::map(hrep::decode_pc_chord) %>%
    expect_equal(list(
      hrep::pc_chord(c(2, 5, 9)),
      hrep::pc_chord(c(2, 4, 6))
    ))
})


chords <- list(
  hrep::pc_chord(c(0, 4, 7)),
  hrep::pc_chord(c(4, 7, 0)),
  hrep::pc_chord(c(7, 2, 5, 11)),
  hrep::pc_chord(c(0, 5, 9))
)
chord_ids <- purrr::map_int(chords, hrep::encode_pc_chord)

test_that("pc_chord_type_id", {
  map_pc_chord$pc_chord_type_id[chord_ids] %>%
    purrr::map(hrep::decode_pc_chord_type) %>%
    expect_equal(list(
      hrep::pc_chord_type(c(0, 4, 7)),
      hrep::pc_chord_type(c(0, 3, 8)),
      hrep::pc_chord_type(c(0, 4, 7, 10)),
      hrep::pc_chord_type(c(0, 5, 9))
    ))
})

test_that("pc_set_id", {
  map_pc_chord$pc_set_id[chord_ids] %>%
    purrr::map(hrep::decode_pc_set) %>%
    expect_equal(list(
      hrep::pc_set(c(0, 4, 7)),
      hrep::pc_set(c(0, 4, 7)),
      hrep::pc_set(c(2, 5, 7, 11)),
      hrep::pc_set(c(0, 5, 9))
    ))
})

test_that("pc_set_rel_root_id", {
  map_pc_chord$pc_set_rel_root_id[chord_ids] %>%
    as.character() %>%
    as.integer() %>%
    purrr::map(hrep::decode_pc_set) %>%
    expect_equal(list(
      hrep::pc_set(c(0, 4, 7)),
      hrep::pc_set(c(0, 4, 7)),
      hrep::pc_set(c(0, 4, 7, 10)),
      hrep::pc_set(c(0, 4, 7))
    ))
})

test_that("num_pcs", {
  c("0", "0 1", "0 2 3", "0 1 2 3 4 5") %>%
    purrr::map(hrep::pc_chord) %>%
    purrr::map_int(hrep::encode_pc_chord) %>%
    map_pc_chord$num_pcs[.] %>%
    expect_equal(c(1, 2, 3, 6))
})

test_that("hutch_78_roughness", {
  v1 <- chords %>%
    purrr::map(hrep::pc_chord_type) %>%
    purrr::map_int(hrep::encode_pc_chord_type) %>%
    voicer::pc_chord_type_ideal_voicings[.] %>%
    purrr::map_dbl(incon::incon, model = "hutch_78_roughness")

  v2 <- map_pc_chord$hutch_78_roughness[chord_ids]

  expect_equal(v1, v2)
})

test_that("har_18_harmonicity", {
  v1 <- chords %>%
    purrr::map(hrep::pc_chord_type) %>%
    purrr::map_int(hrep::encode_pc_chord_type) %>%
    voicer::pc_chord_type_ideal_voicings[.] %>%
    purrr::map_dbl(incon::incon, model = "har_18_harmonicity")

  v2 <- map_pc_chord$har_18_harmonicity[chord_ids]

  expect_equal(v1, v2)
})

test_that("bass_pc", {
  map_pc_chord$bass_pc[chord_ids] %>%
    expect_equal(c(0, 4, 7, 0))

  map_pc_chord$bass_pc_id[chord_ids] %>%
    expect_equal(c(0, 4, 7, 0) + 1)
})

test_that("root_pc", {
  map_pc_chord$root_pc[chord_ids] %>%
    expect_equal(c(0, 0, 7, 5))

  map_pc_chord$root_pc_id[chord_ids] %>%
    expect_equal(c(0, 0, 7, 5) + 1)
})

test_that("bass_pc_rel_root_id", {
  map_pc_chord$bass_pc_rel_root[chord_ids] %>%
    expect_equal(c(0, 4, 0, 7))

  map_pc_chord$bass_pc_rel_root_id[chord_ids] %>%
    expect_equal(c(0, 4, 0, 7) + 1)
})

test_that("milne_pc_spectrum", {
  expect_equal(
    purrr::map(chord_ids, ~ map_pc_chord$milne_pc_spectrum[ , .]),
    purrr::map(chords, ~ as.numeric(hrep::milne_pc_spectrum(.)))
  )
})

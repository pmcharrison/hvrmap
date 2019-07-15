new_map <- list()

new_map$bass_pc <- function(pc_chords) {
  pc_chords %>%
    purrr::map_int(~ as.integer(hrep::get_bass_pc(.)))
}

new_map$pc_chord_type <- function(pc_chords) {
  message("Generating pitch-class chord type mappings...")
  x <- pc_chords %>%
    hrep::vec("pc_chord") %>%
    hrep::represent("pc_chord_type") %>%
    hrep::encode() %>%
    as.integer()
  message("Done.")
  x
}

new_map$pc_set_rel_root <- function(pc_chords, root_pcs) {
  message("Generating pc_set_rel_root mapping...")
  x <- pc_chords %>%
    purrr::map(hrep::pc_set) %>%
    purrr::map2(root_pcs, ~ hrep::tp(.x, interval = - .y)) %>%
    hrep::vec("pc_set") %>%
    hrep::encode() %>%
    factor()
  message("Done.")
  x
}

new_map$milne_pc_spectrum <- function(pc_chords) {
  message("Generating Milne pitch-class spectra...")
  plyr::laply(pc_chords,
              function(x) as.numeric(hrep::milne_pc_spectrum(x)),
              .progress = "time")
}

#' Generate pc_chord map
#'
#' This function generates mappings between pc_chord IDs and derived features.
#'
#' @export
generate_map_pc_chord <- function() {
  pc_chord_ids <- seq_len(hrep::alphabet_size("pc_chord"))
  pc_chords <- hrep::list_chords("pc_chord")

  bass_pcs <- new_map$bass_pc(pc_chords)    # alphabet: 0-11
  root_pcs <- parn88::root_by_pc_chord  # alphabet: 0-11

  bass_pc_rel_root <- (bass_pcs - root_pcs) %% 12L

  map_pc_chord_type <- new_map$pc_chord_type(pc_chords)

  message("Applying consonance models...")
  R.utils::mkdirs("cache/incon")
  incon <- memoise::memoise(incon::incon,
                            cache = memoise::cache_filesystem("cache/incon"))
  consonance <-
    voicer::pc_chord_type_ideal_voicings %>%
    plyr::laply(incon,
                model = c("hutch_78_roughness",
                          "har_18_harmonicity"),
                .progress = "time") %>%
    {.[map_pc_chord_type, ]}

  list(
    pc_chord_type_id = map_pc_chord_type, # alphabet: pc_chord_type

    pc_set_id = hrep::pc_chord_id_to_pc_set_id_map,  # alphabet: pc_set
    pc_set_rel_root_id = new_map$pc_set_rel_root(pc_chords, root_pcs), # alphabet: pc_set_rel_root

    num_pcs = purrr::map_int(pc_chords, length),

    hutch_78_roughness = consonance[, "hutch_78_roughness"],
    har_18_harmonicity = consonance[, "har_18_harmonicity"],

    bass_pc_id = bass_pcs + 1L,
    root_pc_id = root_pcs + 1L,
    bass_pc_rel_root_id = bass_pc_rel_root + 1L,

    bass_pc = bass_pcs,
    root_pc = root_pcs,
    bass_pc_rel_root = bass_pc_rel_root,

    milne_pc_spectrum = new_map$milne_pc_spectrum(pc_chords)
  )
}

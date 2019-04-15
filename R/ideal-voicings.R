# # This turned out to be prohibitively time-consuming.
# # To move forward with this, someone needs to rewrite the
# # expand_harmonics function in the hrep package in C++.
#
# generate_ideal_voicings <- function() {
#   message("Getting ideal pc_chord voicings...")
#
#   pc_chords <- hrep::list_chords("pc_chord")
#
#   cache_dir <- "cache/get_ideal_voicing"
#   R.utils::mkdirs(cache_dir)
#   get_ideal_voicing <- memoise::memoise(get_ideal_voicing,
#                                         cache = memoise::cache_filesystem(cache_dir))
#
#   .pc_chord_ideal_voicings <- plyr::llply(pc_chords,
#                                           get_ideal_voicing,
#                                           .progress = "text")
#   save(.pc_chord_ideal_voicings, file = "data/pc_chord_ideal_voicings.rda")
# }
#
# get_ideal_voicing <- function(pc_chord) {
#   x <- hrep::vec(list(pc_chord), "pc_chord")
#   size <- length(pc_chord)
#   opt <- voicer::voice_opt(min_notes = 1L,
#                            max_notes = pmax(5, size),
#                            max_octave = 0,
#                            features = voicer::voice_features(ideal_num_notes = 5L),
#                            verbose = FALSE)
#   voicer::voice(x, opt)[[1]]
# }

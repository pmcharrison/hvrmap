library(hvrmap)

map_pc_chord <- generate_map_pc_chord()
pc_chord_transpositions <- generate_transpose_pc_chord_id()

use_data(map_pc_chord, pc_chord_transpositions, internal = FALSE, overwrite = TRUE)

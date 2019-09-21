#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

#' Pitch-class chord transpositions
#'
#' This 12 x 24,576 matrix constitutes a look-up table for efficiently
#' transposing vectors of pitch-class chords,
#' which must be encoded using the integer mapping scheme
#' from the \code{hrep} package.
#' The element in the ith row and the jth column corresponds to the
#' (encoded) pitch-class chord produced by transposing
#' pitch-class chord j by pitch-class interval i.
#'
#' @name pc_chord_transpositions
#' @docType data
#' @keywords data
NULL

#' Mapping pitch-class chords
#'
#' This is a list of mappings from pitch-class chords (encoded using the
#' integer mapping scheme from the \code{hrep} package)
#' to various derived features or representations.
#' These mappings are designed to support efficient vectorised
#' derivations of representations from input chords.
#'
#' The list comprises the following elements:
#'
#' - \code{pc_chord_type_id} -
#' An integer vector where element i corresponds to the encoded \code{pc_chord_type} of
#' pitch-class chord i.
#'
#' - \code{pc_set_id} -
#' An integer vector where element i corresponds to the encoded \code{pc_set} of
#' pitch-class chord i.
#'
#' - \code{pc_set_rel_root_id} -
#' A factor vector where element i corresponds to the \code{pc_set} of
#' pitch-class chord i, where the pitch-class set is represented relative
#' to the chord's root as inferred by the root-finding algorithm of
#' \insertCite{Parncutt1988;textual}{hvrmap}.
#' In particular, the name of the ith element corresponds to the
#' pitch-class set as encoded by the \code{hrep} package,
#' whereas the underlying integer value of the ith element corresponds to
#' to a new integer encoding that only has 4,045 levels, corresponding
#' to all legal pitch-class sets that may be expressed relative to the
#' chord root (some pitch-class sets are omitted because they would
#' imply a different chord root).
#'
#' - \code{num_pcs} -
#' An integer vector where the ith element identifies the number of
#' unique pitch classes in pitch-class chord i.
#'
#' - \code{hutch_78_roughness} -
#' A numeric vector where the ith element corresponds to the roughness
#' of pitch-class chord i as represented in the optimised voicing
#' from the voicer package (\code{\link[voicer]{pc_chord_type_ideal_voicings}})
#' and analysed using the \code{hutch_78_roughness} model from the
#' \code{\link[incon]{incon}} function
#' in the \code{incon} package.
#'
#' - \code{har_18_harmonicity} -
#' Same as \code{hutch_78_roughness}, except using the \code{har_18_harmonicity}
#' model from the \code{\link[incon]{incon}} function in the \code{incon} package.
#'
#' - \code{bass_pc_id} -
#' An integer vector where the ith element corresponds to 1 + the
#' bass pitch class of pitch-class chord i. The values therefore range
#' from 1 to 12.
#'
#' - \code{root_pc_id} -
#' An integer vector where the ith element corresponds to 1 + the
#' root pitch class of pitch-class chord i, as computed using the
#' root-finding algorithm of \insertCite{Parncutt1988;textual}{hvrmap}.
#' Its values range from 1 to 12.
#'
#' - \code{bass_pc_rel_root_id} -
#' An integer vector where the ith element corresponds to 1 + the
#' bass pitch class of pitch-class chord i expressed relative to the
#' chord's root, as computed using the
#' root-finding algorithm of \insertCite{Parncutt1988;textual}{hvrmap}.
#' This representation essentially captures inversion inversion.
#' Its values range from 1 to 12.
#'
#' - \code{bass_pc} -
#' Corresponds to \code{bass_pc_id} - 1, producing pitch classes
#' on a scale from 0 to 11 as traditionally defined by music theorists.
#'
#' - \code{root_pc} -
#' Corresponds to \code{root_pc_id} - 1, producing pitch classes
#' on a scale from 0 to 11 as traditionally defined by music theorists.
#'
#' - \code{bass_pc_rel_root} -
#' Corresponds to \code{bass_pc_rel_root_id} - 1, producing pitch classes
#' on a scale from 0 to 11 as traditionally defined by music theorists.
#'
#' - \code{milne_pc_spectrum} -
#' A matrix of dimensions 1,200 x 24,576,
#' where column j corresponds to the pitch-class spectrum of pitch-class chord j
#' as computed by the function \code{\link[hrep]{milne_pc_spectrum}}
#' from the \code{hrep} package, after \insertCite{Milne2016;textual}{hrep}.
#'
#' @references
#' \insertAllCited{}
#'
#' @md
#'
#' @name map_pc_chord
#' @docType data
#' @keywords data
NULL

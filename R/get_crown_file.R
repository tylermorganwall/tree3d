#'@title Get a 3D Crown File
#'
#'@description Generate a specific 3D representation of a tree crown,
#'given the parameters for the type of tree crown, the desired level of detail
#'or resolution, and whether or not to offset the crown to align it with the
#'trunk at the origin.
#'
#'@param tree Default `"rounded"`. Crown type. Full list of options:
#'`"columnar"`
#'`"pyramidal1"`
#'`"pyramidal2"`
#'`"oval"`
#'`"palm"`
#'`"rounded"`
#'`"spreading1"`
#'`"spreading2"`
#'`"vase"`
#'`"weeping"`
#'@param resolution Default `"medium"`. Level of detail of the tree mesh. All options:
#'`"low"`
#'`"medium"`
#'`"high`
#'@param offset_origin Default `TRUE`. Whether to offset the crown so that the bottom of the
#'tree will be exactly at the origin, aligning it with the trunk.
#' @param solid Default `FALSE`. Whether the crown should be a solid mesh (`TRUE`), or a collection of flat
#' 2D planes (`FALSE`).
#'@export
#'
#'@return Filename of OBJ file (as `.txt` file)
#'@examples
#'#Get a crown OBJ
#'get_crown_file(tree = "rounded", resolution = "high")
get_crown_file = function(tree = "oval",
                          resolution = "medium",
                          offset_origin = TRUE,
                          solid = FALSE) {
  if(solid) {
    get_solid_crown_file(tree = tree,
                         resolution = resolution,
                         offset_origin = offset_origin)
  } else {
    get_flat_crown_file(tree = tree,
                        resolution = resolution,
                        offset_origin = offset_origin)
  }
}

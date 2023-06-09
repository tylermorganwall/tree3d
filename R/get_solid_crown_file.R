#'@title Get a Solid 3D Crown File
#'
#'@description Generate a specific 3D representation of a tree crown,
#'given the parameters for the type of tree crown, the desired level of detail
#'or resolution, and whether or not to offset the crown to align it with the
#'trunk at the origin.
#'
#'@param tree Default `"oval"`. Crown type. Full list of options:
#'`"columnar`"
#'`"pyramidal1`"
#'`"pyramidal2`"
#'`"oval`"
#'`"spreading1`"
#'`"weeping`"
#'@param resolution Default `"medium"`. Level of detail of the tree mesh. All options:
#'`"low"`
#'`"medium"`
#'`"high`
#'@param offset_origin Default `TRUE`. Whether to offset the crown so that the bottom of the
#'tree will be exactly at the origin, aligning it with the trunk.
#'@export
#'
#'@return Filename of OBJ file (as `.txt` file)
#'@examples
#'#Load an arrow OBJ
#'get_solid_crown_file(tree = "oval", resolution = "high")
get_solid_crown_file = function(tree = "oval",
                                resolution = "medium",
                                offset_origin = TRUE) {
  tree_types = c("Columnar",
                 "Pyramidal1",
                 "Pyramidal2",
                 "Oval",
                 "Spreading1",
                 "Weeping")
  tree_types = tolower(tree_types)
  tree_files =  c("columnar_crown_clean.txt",
                  "evergreen_1_crown_clean.txt",
                  "evergreen_2_crown_clean.txt",
                  "oval_crown_clean.txt",
                  "spreading_1_crown_clean.txt",
                  "weeping_crown_clean.txt" )

  if(offset_origin) {
    tree_files =  c("columnar_crown_clean_offset.txt",
                    "evergreen_1_crown_clean_offset.txt",
                    "evergreen_2_crown_clean_offset.txt",
                    "oval_crown_clean_offset.txt",
                    "spreading_1_crown_clean_offset.txt",
                    "weeping_crown_clean_offset.txt" )
  }
  tree = tolower(tree)
  resolution = tolower(resolution)
  stopifnot(resolution %in% c("low","medium","high"))
  resolution_dir = paste0(resolution, "res")

  stopifnot(length(tree) == 1)
  if(!tree %in% tree_types) {
    stop("`tree` must be one of the following: c(",
         paste0(tree_types,collapse = ", "),
         ")")
  }
  tree_file = tree_files[which(tree == tree_types)]
  system.file("extdata",resolution_dir,tree_file, package="tree3d", mustWork = TRUE)
}


#'@title Get a Flat 3D Crown File
#'
#'@description Description
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
#'tree will be exactly at the originm, aligning it with the trunk.
#'@export
#'
#'@return Filename of OBJ file (as `.txt` file)
#'@examples
#'#Load an arrow OBJ
#'get_flat_crown_file(tree = "rounded", resolution = "high")
get_flat_crown_file = function(tree = "rounded",
                               resolution = "medium",
                               offset_origin = TRUE) {
  tree_types = c("Columnar",
                 "Pyramidal1",
                 "Pyramidal2",
                 "Oval",
                 "Palm",
                 "Rounded",
                 "Spreading1",
                 "Spreading2",
                 "Vase",
                 "Weeping")
  tree_types = tolower(tree_types)
  tree_files =  c("columnar_clean.txt",
                  "evergreen_1_clean.txt",
                  "evergreen_2_clean.txt",
                  "oval_clean.txt",
                  "palm_clean.txt",
                  "rounded_clean.txt",
                  "spreading_1_clean.txt",
                  "spreading_2_clean.txt",
                  "vase_clean.txt",
                  "weeping_clean.txt" )
  if(offset_origin) {
    tree_files =  c("columnar_clean_offset.txt",
                    "evergreen_1_clean_offset.txt",
                    "evergreen_2_clean_offset.txt",
                    "oval_clean_offset.txt",
                    "palm_clean_offset.txt",
                    "rounded_clean_offset.txt",
                    "spreading_1_clean_offset.txt",
                    "spreading_2_clean_offset.txt",
                    "vase_clean_offset.txt",
                    "weeping_clean_offset.txt" )
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
  system.file("extdata",resolution_dir,tree_file, package="tree3d", mustWork =TRUE)
}

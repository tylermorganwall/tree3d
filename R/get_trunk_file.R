#'@title Get Trunk File
#'
#'@description Description
#'
#'@export
#'
#'@return Filename of OBJ file (as `.txt` file)
#'@examples
#'#Load an arrow OBJ
#'get_trunk_file()
get_trunk_file = function() {
  system.file("extdata", "trunk", "trunk_clean.txt", package="elementslabtrees", mustWork = TRUE)
}

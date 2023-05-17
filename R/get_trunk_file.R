#' @title Get Trunk File
#'
#' @description This function retrieves a trunk OBJ file. The trunk OBJ file can be used to create a tree trunk in a 3D scene. The function has an option to scale the trunk model based on the radius.
#'
#' @param scaled Default `TRUE`. This parameter determines whether the trunk model should be scaled from a radius of 0.1 to 1. If TRUE, the trunk model will be scaled; otherwise, it will use the original size.
#' @param offset Default `TRUE`. This parameter determines whether the trunk model should be offset to start at the origin, or centered at the origin (`FALSE`).
#' @export
#'
#' @return Returns the filename of the selected OBJ file (as a .txt file) for the tree trunk. This file can be used to create tree trunk models in a 3D scene.
#' @examples
#' # Fetch an trunk OBJ path
#' get_trunk_file()
get_trunk_file = function(scaled = TRUE, offset = TRUE) {
  if(!scaled) {
    if(!offset) {
      system.file("extdata", "trunk", "trunk_clean.txt", package="tree3d", mustWork = TRUE)
    } else {
      system.file("extdata", "trunk", "trunk_clean_offset.txt", package="tree3d", mustWork = TRUE)
    }
  } else {
    if(!offset) {
      system.file("extdata", "trunk", "trunk_clean_scaled.txt", package="tree3d", mustWork = TRUE)
    } else {
      system.file("extdata", "trunk", "trunk_clean_scaled_offset.txt", package="tree3d", mustWork = TRUE)
    }
  }
}

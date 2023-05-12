#'@title Write Tree to OBJ
#'
#'@description Export the tree mesh to an OBJ file for use in other 3D programs
#'
#'@param tree_mesh Tree mesh.
#'@param filename Filename for the OBJ file. If the file extension is not included, it
#'will automatically be added.
#'@param materials Default `TRUE`. Whether to also write the material (MTL) file.
#'@param fileext Default `".obj"`. File extension to be added if not present.
#'@export
#'
#'@return None
#'@examples
#'#Save tree mesh to file
#'tempfileloc = tempfile()
#'write_tree_to_obj(tree_mesh(), filename = tempfileloc)
write_tree_to_obj = function(tree_mesh,
                             filename,
                             materials = TRUE,
                             fileext = ".obj") {
  stopifnot(!missing(filename))
  rayvertex::write_scene_to_obj(tree_mesh,
                                filename = filename,
                                materials = materials,
                                fileext = fileext)
}

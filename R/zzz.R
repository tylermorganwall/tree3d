# Generates pre-offset versions of crown and trunk files
.onLoad <- function(libname, pkgname) {
  pkg_path = grep(list.files(system.file("extdata", package = "tree3d"),
                             recursive = TRUE, full.names = T), pattern='trunk|offset|zip', invert=TRUE, value=TRUE)
  offset_paths = sprintf("%s%s.txt", tools::file_path_sans_ext(pkg_path),"_offset")
  for(i in seq_len(length(offset_paths))) {
    if(!file.exists(offset_paths[i]) && file.exists(pkg_path[i])) {
      tree_data = tree3d:::tree_mesh_data[which(basename(pkg_path[i]) == tree3d:::tree_mesh_data$filename), ]
      trunk_offset = -tree_data$trunk_start
      rayvertex::obj_mesh(pkg_path[i],
                          position = c(0,trunk_offset, 0),
                          material = NULL) |>
        write_tree_to_obj(offset_paths[i],
                          materials = FALSE,
                          fileext = ".txt")
    }
  }
  return(invisible())
}

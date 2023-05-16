# Generates pre-offset versions of crown and trunk files
.onLoad <- function(libname, pkgname) {
  sys_pkg_files = list.files(system.file("extdata", package = "tree3d"),
                             recursive = TRUE, full.names = T)
  pkg_files = grep(sys_pkg_files, pattern='trunk|offset|zip|scaled', invert=TRUE, value=TRUE)
  offset_paths = sprintf("%s%s.txt", tools::file_path_sans_ext(pkg_files),"_offset")
  for(i in seq_len(length(offset_paths))) {
    if(!file.exists(offset_paths[i]) && file.exists(pkg_files[i])) {
      tree_data = tree3d:::tree_mesh_data[which(basename(pkg_files[i]) == tree3d:::tree_mesh_data$filename), ]
      trunk_offset = -tree_data$trunk_start
      rayvertex::obj_mesh(pkg_files[i],
                          position = c(0, trunk_offset, 0),
                          material = NULL) |>
        write_tree_to_obj(offset_paths[i],
                          materials = FALSE,
                          fileext = ".txt")
    }
  }
  trunk_file_path = grep(sys_pkg_files, pattern = 'trunk_clean.txt',
                         invert = FALSE, value = TRUE)
  scaled_trunk_path = sprintf("%s%s.txt",
                              tools::file_path_sans_ext(trunk_file_path),
                              "_scaled")
  if(!file.exists(scaled_trunk_path)) {
    rayvertex::obj_mesh(trunk_file_path,
                        scale = c(10, 1, 10),
                        material = NULL) |>
      write_tree_to_obj(scaled_trunk_path,
                        materials = FALSE,
                        fileext = ".txt")
  }
  sys_pkg_files = list.files(system.file("extdata", package = "tree3d"),
                             recursive = TRUE, full.names = T)
  trunk_file_path = grep(sys_pkg_files, pattern = 'trunk',
                         invert = FALSE, value = TRUE)
  offset_trunk_path = sprintf("%s%s.txt",
                              tools::file_path_sans_ext(trunk_file_path),
                              "_offset")
  for(i in seq_len(length(trunk_file_path))) {
    if(!file.exists(offset_trunk_path[i])) {
      rayvertex::obj_mesh(trunk_file_path[i],
                          position = c(0, 0.5, 0),
                          material = NULL) |>
        write_tree_to_obj(offset_trunk_path[i],
                          materials = FALSE,
                          fileext = ".txt")
    }
  }
  return(invisible())
}

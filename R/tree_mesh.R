#'@title Tree Mesh
#'
#'@description Loads an tree OBJ file as a `ray_mesh` object.
#'
#' @param crown_type Default `"oval"`. Crown type. Full list of options
#' (star indicates both flat and solid variants available, no star indicates only flat version available):
#'
#'| **3D/Flat** | **Name**   |
#'| :----------: | :----------------: |
#'| Both       | `"columnar"`   |
#'| Both       | `"evergreen1"` |
#'| Both       | `"evergreen2"` |
#'| Both       | `"weeping"`    |
#'| Both       | `"spreading1"` |
#'| Both       | `"oval"`       |
#'| Flat-only  | `"palm"`       |
#'| Flat-only  | `"rounded"`    |
#'| Flat-only  | `"spreading2"` |
#'| Flat-only  | `"vase"`       |
#' @param solid Default `FALSE`. Whether the crown should be a solid mesh, or a collection of flat
#' 2D planes.
#' @param position Default `c(0,0,0)`. X/Y/Z position of the mesh.
#' @param angle Default `0`. Amount of rotation around the y-axis for the tree.
#' @param resolution Default `"medium"`. Level of detail of the tree mesh. All options:
#'`"low"`
#'`"medium"`
#'`"high`
#' @param filename Default `NULL`. Filename of the OBJ file, if saving the mesh to a local file.
#' @param crown_height   Default `1`. Crown height.
#' @param crown_diameter Default `1`. Crown diameter.
#' @param trunk_height   Default `1`. Trunk height.
#' @param trunk_diameter Default `0.1`. Trunk diameter.
#' @param crown_color    Default `0.1`. Crown color.
#' @param trunk_color    Default `0.1`. Trunk color.
#' @param diffuse_intensity Default `1.0`. Amount of diffuse (shaded) color included in the model.
#' @param ambient_intensity Default `0.2`. Amount of ambient (constant) color included in the model.
#'
#'@export
#'
#'@return `ray_mesh` list object
#'@examples
#'#Load a tree
tree_mesh = function(crown_type = "oval",
                     position = c(0,0,0),
                     angle = 0,
                     solid = FALSE,
                     resolution = "medium",
                     filename = NULL,
                     crown_height = 1,
                     crown_diameter  = 1,
                     trunk_height = 1,
                     trunk_diameter = 0.1,
                     crown_color = "darkgreen",
                     trunk_color = "#725c42",
                     diffuse_intensity = 1.0,
                     ambient_intensity = 0.2) {
  if(solid) {
    crown_file = get_solid_crown_file(crown_type, resolution)
  } else {
    crown_file = get_flat_crown_file(crown_type, resolution)
  }
  tree_data = tree_mesh_data[which(basename(crown_file) == tree_mesh_data$filename), ]
  trunk_offset = -tree_data$trunk_start
  crown_aspect = tree_data$aspect_ratio

  crown_mesh = rayvertex::obj_mesh(crown_file, position = c(0,trunk_offset, 0),
                                   material = rayvertex::material_list(diffuse = crown_color,
                                                                       ambient = crown_color,
                                                                       diffuse_intensity = diffuse_intensity,
                                                                       ambient_intensity = ambient_intensity,
                                                                       culling = "none", two_sided = TRUE)) |>
    rayvertex::scale_mesh(scale = c(crown_diameter,crown_height,crown_diameter)) |>
    rayvertex::translate_mesh(position = c(0,trunk_height,0))

  trunk_diameter = trunk_diameter / 0.1
  trunk_mesh = rayvertex::obj_mesh(get_trunk_file(), position = c(0,0.5,0),
                                   material = rayvertex::material_list(diffuse = trunk_color,
                                                                       diffuse_intensity = diffuse_intensity,
                                                                       ambient_intensity = ambient_intensity,
                                                                       ambient = trunk_color)) |>
    rayvertex::scale_mesh(scale = c(trunk_diameter,
                                    trunk_height,
                                    trunk_diameter))
  tree_full = rayvertex::add_shape(crown_mesh, trunk_mesh) |>
    rayvertex::rotate_mesh(angle = c(0,angle,0)) |>
    rayvertex::translate_mesh(position)
  if(!is.null(filename)) {
    rayvertex::write_scene_to_obj(tree_full, filename)
  }
  return(tree_full)
}

#'@title Generate a Tree Mesh
#'
#'@description This function generates a tree model and transforms it into a `ray_mesh` object or an OBJ file.
#' The tree model consists of two main parts: the crown (leafy part) and the trunk. Both parts can be customized according
#' to a range of preset types, as well as full control over the tree's colors and dimensions.
#' The tree model can be positioned, scaled, and rotated in 3D space.
#'
#' @param crown_type Default `"oval"`. Crown type (the leafy part of the tree). Full list of options:
#'| **3D/Flat** | **Name** | **Crown Color** |
#'| :----------: | :----------------: | :--------: |
#'| Both       | `"columnar"`   | `"#A2C683"` \figure{columnar_square.png}   |
#'| Both       | `"pyramidal1"` | `"#066038"` \figure{pyramidal1_square.png} |
#'| Both       | `"pyramidal2"` | `"#447765"` \figure{pyramidal2_square.png} |
#'| Both       | `"weeping"`    | `"#CBD362"` \figure{weeping_square.png}    |
#'| Both       | `"spreading1"` | `"#CCB471"` \figure{spreading1_square.png} |
#'| Both       | `"oval"`       | `"#7CB262"` \figure{oval_square.png}       |
#'| Flat-only  | `"palm"`       | `"#DB8952"` \figure{palm_square.png}       |
#'| Flat-only  | `"rounded"`    | `"#E0A854"` \figure{rounded_square.png}    |
#'| Flat-only  | `"spreading2"` | `"#75C165"` \figure{spreading2_square.png} |
#'| Flat-only  | `"vase"`       | `"#AECCB1"` \figure{vase_square.png}       |
#' @param solid Default `FALSE`. Whether the crown should be a solid mesh (`TRUE`), or a collection of flat
#' 2D planes (`FALSE`).
#' @param position Default `c(0,0,0)`. A length-3 numeric vector specifying the X, Y, and Z coordinates of the tree mesh in 3D space.
#' @param angle Default `0`. Amount of rotation around the y-axis for the tree.
#' @param resolution Default `"medium"`. String indicating the level of detail of the tree mesh. All options:
#'`"low"`
#'`"medium"`
#'`"high`
#' @param filename Default `NULL`. File name of the OBJ file, if saving the mesh to a local file.
#' @param tree_height Default `1`. A numeric value setting the total height of the tree.
#' @param trunk_height_ratio Default `1/3`. A numeric value specifying the ratio of the trunk height to the total height of the tree.
#' @param crown_width_ratio Default `1`. A numeric value specifying the ratio of the crown width to the crown height.
#' @param crown_height Default `NULL`. A numeric value setting the height of the crown. If not provided, it is calculated based on the tree height and trunk height ratio.
#' @param crown_width Default `NULL`. A numeric value setting the diameter of the crown. If not provided, it is calculated based on the crown height and crown width ratio.
#' @param trunk_height Default `NULL`. A numeric value setting the height of the trunk. If not provided, it is calculated based on the tree height and trunk height ratio.
#' @param trunk_width Default `NULL`. A numeric value setting the diameter of the trunk. If not provided, this is set to 1/5th the trunk height.
#' @param crown_color Default `NA`, use default for crown type. A string specifying the hex code of the crown color.
#' @param trunk_color Default `"#8C6F5B"`. A string specifying the hex code of the trunk color.
#' @param diffuse_intensity Default `1.0`. A numeric value controlling the amount of diffuse (shaded) color included in the model.
#' @param ambient_intensity Default `0.2`. A numeric value controlling the amount of ambient (constant) color included in the model.
#'@export
#'
#'@return `ray_mesh` list object
#'@examples
#'#Load a tree and render it
#'library(rayvertex)
#'render_tree_example = function(example_tree_mesh) {
#'  example_tree_mesh |>
#'    add_shape(xz_rect_mesh(c(0,0,-9),
#'                           material = material_list(diffuse="tan",
#'                           ambient = "grey", diffuse_intensity = 0.7,
#'                           ambient_intensity = 0.6),
#'                           scale=25)) |>
#'    rasterize_scene(lookat=c(0,0.75,0),
#'                    light_info = directional_light(c(0.3,1,1), intensity = 0.7),
#'                    lookfrom=c(0,3,10),
#'                    fov=10,
#'                    shadow_map_dims = 2, shadow_map_bias = 0.0005,
#'                    width = 800, height = 800,
#'                    fsaa = 4, ssao = TRUE, ssao_intensity = 1,
#'                    background = "lightblue")
#'}
#'if(tree3d:::run_documentation()) {
#'#Render a basic 3D crown
#'tree_mesh("columnar",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'#Render the 2D planar version
#'tree_mesh("columnar",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'#Adjust the trunk/crown proportions of the overall tree using ratios
#'tree_mesh("columnar",
#'          tree_height = 1,
#'          trunk_height_ratio = 1/5,
#'          crown_width_ratio = 1.25,
#'          trunk_width = 0.125,
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'
#'}
#'
#'if(tree3d:::run_documentation()) {
#'#The crown width is set proportional to the crown height (not the overall tree)
#'tree_mesh("columnar",
#'          tree_height = 1,
#'          trunk_height_ratio = 2/3,
#'          crown_width_ratio = 1,
#'          trunk_width = 0.075,
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'
#'if(tree3d:::run_documentation()) {
#'#Set the trunk and crown dimensions directly
#'tree_mesh("columnar",
#'          trunk_height = 0.25,
#'          trunk_width = 0.05,
#'          crown_height = 0.75,
#'          crown_width = 0.33,
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'#Change the crown and trunk color
#'tree_mesh("columnar",
#'          solid = TRUE,
#'          crown_color = "orange",
#'          trunk_color = "tan",
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'#Render different tree types, both 2D and 3D versions
#'tree_mesh("columnar",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("columnar",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("pyramidal1",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("pyramidal1",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("pyramidal2",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("pyramidal2",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("weeping",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("weeping",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("spreading1",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("spreading1",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("oval",
#'          solid = TRUE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("oval",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("palm",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("rounded",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("spreading2",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
#'if(tree3d:::run_documentation()) {
#'tree_mesh("vase",
#'          solid = FALSE,
#'          ambient_intensity = 0.3) |>
#'  render_tree_example()
#'}
tree_mesh = function(crown_type = "oval",
                     position = c(0,0,0),
                     angle = 0,
                     solid = FALSE,
                     resolution = "medium",
                     filename = NULL,
                     tree_height  = 1,
                     trunk_height_ratio = 1/3,
                     crown_width_ratio = 1,
                     crown_height = NULL,
                     crown_width = NULL,
                     trunk_height = NULL,
                     trunk_width = NULL,
                     crown_color = NA,
                     trunk_color = "#8C6F5B",
                     diffuse_intensity = 1.0,
                     ambient_intensity = 0.2) {
  if(solid) {
    crown_file = get_solid_crown_file(crown_type, resolution, offset_origin = TRUE)
  } else {
    crown_file = get_flat_crown_file(crown_type, resolution, offset_origin = TRUE)
  }

  if(is.na(crown_color)) {
    crown_color = get_default_tree_color(crown_type)
  }

  #Define crown dimensions
  if(is.null(crown_height)) {
    stopifnot(trunk_height_ratio < 1 && trunk_height_ratio >= 0)
    crown_height = (1 - trunk_height_ratio) * tree_height
  }
  if(is.null(crown_width)) {
    crown_width = crown_height * crown_width_ratio
  }

  #Define trunk dimensions
  if(is.null(trunk_height)) {
    trunk_height = trunk_height_ratio * tree_height
  }
  if(is.null(trunk_width)) {
    trunk_width = trunk_height / 5
  }

  crown_mesh = rayvertex::obj_mesh(crown_file,
                                   material = rayvertex::material_list(diffuse = crown_color,
                                                                       ambient = crown_color,
                                                                       diffuse_intensity = diffuse_intensity,
                                                                       ambient_intensity = ambient_intensity,
                                                                       culling = "none", two_sided = TRUE)) |>
    rayvertex::scale_mesh(scale = c(crown_width,crown_height,crown_width)) |>
    rayvertex::translate_mesh(position = c(0,trunk_height,0))

  trunk_mesh = rayvertex::obj_mesh(get_trunk_file(offset = TRUE),
                                   material = rayvertex::material_list(diffuse = trunk_color,
                                                                       diffuse_intensity = diffuse_intensity,
                                                                       ambient_intensity = ambient_intensity,
                                                                       ambient = trunk_color)) |>
    rayvertex::scale_mesh(scale = c(trunk_width,
                                    trunk_height,
                                    trunk_width))
  tree_full = rayvertex::add_shape(crown_mesh, trunk_mesh) |>
    rayvertex::rotate_mesh(angle = c(0,angle,0)) |>
    rayvertex::translate_mesh(position)
  if(!is.null(filename)) {
    rayvertex::write_scene_to_obj(tree_full, filename)
  }
  return(tree_full)
}

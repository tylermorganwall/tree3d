#' @title Get Tree Data
#'
#' @description This function retrieves a data frame of tree default data.
#'
#' @param name Default `NULL`. The tree name, if only a single tree's info is needed. Otherwise,
#' all trees are returned.
#'
#' @export
#'
#' @return Returns a data frame.
#' @examples
#' # Fetch the tree data frame.
#' get_tree_data()
#'
#' # Get single tree
#' get_tree_data("palm")
get_tree_data = function(tree_name = NULL) {
  tree_color_data = data.frame(
    name = tolower(c("Columnar",
                     "Pyramidal1",
                     "Pyramidal2",
                     "Oval",
                     "Palm",
                     "Rounded",
                     "Spreading1",
                     "Spreading2",
                     "Vase",
                     "Weeping")),
    solid_available = c(TRUE, TRUE, TRUE, TRUE,
                        FALSE, FALSE, TRUE, FALSE,
                        FALSE, TRUE),
    trunk_color =  "#8C6F5B",
    tree_color = c("#A2C683",
                   "#066038",
                   "#447765",
                   "#CBD362",
                   "#CCB471",
                   "#7CB262",
                   "#DB8952",
                   "#E0A854",
                   "#75C165",
                   "#AECCB1"),
    trunk_crown_ratio = c(1/3,
                          1/6,
                          1/6,
                          1/3,
                          1/2,
                          1/3,
                          1/3,
                          1/3,
                          1/3,
                          1/3)
  )
  if(!is.null(tree_name)) {
    stopifnot(tree_name %in% tree_color_data$name)
    return(tree_color_data[tree_color_data$name == tree_name, ])
  } else {
    return(tree_color_data)
  }
}

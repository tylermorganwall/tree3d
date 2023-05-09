#'@title Get the default color for a tree
#'
#'@param crown_type Crown type. Full list of options:
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
#'@keywords internal
#'
#'@return Hex color
get_default_tree_color = function(crown_type) {
  tree_color_data = data.frame(
    tree_type = tolower(c("Columnar",
                  "Pyramidal1",
                  "Pyramidal2",
                  "Oval",
                  "Palm",
                  "Rounded",
                  "Spreading1",
                  "Spreading2",
                  "Vase",
                  "Weeping")),
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
                   "#AECCB1")
  )
  stopifnot(crown_type %in% tree_color_data$tree_type)
  return(tree_color_data$tree_color[which(tree_color_data$tree_type == crown_type)])
}

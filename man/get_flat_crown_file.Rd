% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_flat_crown_file.R
\name{get_flat_crown_file}
\alias{get_flat_crown_file}
\title{Get a Flat 3D Crown File}
\usage{
get_flat_crown_file(
  tree = "rounded",
  resolution = "medium",
  offset_origin = TRUE
)
}
\arguments{
\item{tree}{Default \code{"rounded"}. Crown type. Full list of options:
\code{"columnar"}
\code{"pyramidal1"}
\code{"pyramidal2"}
\code{"oval"}
\code{"palm"}
\code{"rounded"}
\code{"spreading1"}
\code{"spreading2"}
\code{"vase"}
\code{"weeping"}}

\item{resolution}{Default \code{"medium"}. Level of detail of the tree mesh. All options:
\code{"low"}
\code{"medium"}
\verb{"high}}

\item{offset_origin}{Default \code{TRUE}. Whether to offset the crown so that the bottom of the
tree will be exactly at the origin, aligning it with the trunk.}
}
\value{
Filename of OBJ file (as \code{.txt} file)
}
\description{
Generate a specific 3D representation of a planar tree crown,
given the parameters for the type of tree crown, the desired level of detail
or resolution, and whether or not to offset the crown to align it with the
trunk at the origin.
}
\examples{
#Load an arrow OBJ
get_flat_crown_file(tree = "rounded", resolution = "high")
}

#' Create a map for the wedding place
#'
#' @param data_markers Information about the wedding place. Tibble with 3 columns : longitude, latitude, name.
#' @param icon_markers Image to be used for the markers. Icon from ion library. Character.
#' @param zoom Zoom on the map. Numeric.
#'
#' @return Map.
#' @export
#'
#' @importFrom leaflet leafletOutput renderLeaflet leaflet addProviderTiles addMarkers %>% setView awesomeIcons addAwesomeMarkers
#' @importFrom dplyr pull select
#' @importFrom geosphere centroid
#' 
#' @examples
#' data_markers <- tibble::tibble(
#'   longitude = c(2.1203232115689707, 2.119756986412269, 2.120561059665001),
#'   latitude = c(48.80504860237253, 48.78022930537074, 48.85858486573977),
#'   name = c(
#'     "<b>Palace of Versailles</b><br/>Super great place to get married", 
#'     "<b>A random place to stay</b>", 
#'     "<b>A random place to stay</b>")
#' )
#' 
#' get_map_wedding(
#'   data_markers = data_markers,
#'   icon_markers = "home"
#'   )
#' 
#' get_map_wedding(
#'   data_markers = data_markers,
#'   icon_markers = "star",
#'   zoom = 10
#' )
get_map_wedding <- function(data_markers, 
                            icon_markers,
                            zoom = 7) {
  
  if (nrow(data_markers) > 1) {
    centroid_map <- as.vector(centroid(data_markers %>% select(longitude, latitude) %>% as.data.frame()))
  } else {
    centroid_map = c(data_markers$longitude, data_markers$latitude)
  }
  
  setview <- c("longitude" = centroid_map[1], 
               "latitude" = centroid_map[2], 
               "zoom" = zoom)
  
  data_markers %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(
      lng = as.numeric(setview["longitude"]),
      lat = as.numeric(setview["latitude"]),
      zoom = as.numeric(setview["zoom"])
    ) %>%
    addAwesomeMarkers(
      lng = ~ longitude,
      lat = ~ latitude,
      popup = ~ name,
      icon = awesomeIcons(
        icon = icon_markers,
        iconColor = "white",
        library = "ion",
        markerColor = "black"
      )
    )
  
}
#' Import app fonts.
#'
#' @importFrom extrafont font_import loadfonts fonts
#'
#' @return Nothing.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' load_wedding_fonts()
#' extrafont::fonts() # available fonts
#'
#' ggplot(data = iris) +
#'   aes(x = Sepal.Width, fill = Species) +
#'   geom_density(alpha = 0.6, color = NA) +
#'   labs(title = "Largeur des sépales des iris",
#'        subtitle = "3 variétés") +
#'   theme(
#'     plot.title = element_text(family = "Bauer Bodoni Std"),
#'     plot.subtitle = element_text(family = "Old Script"),
#'     text = element_text(family = "Bauer Bodoni Std")
#'     )
load_wedding_fonts <- function() {
  
  if(!("Old Script" %in% fonts()) | !("Bauer Bodoni Std" %in% fonts())) {
    
    font_import(
      paths = system.file("app/www/fonts", package = "wedding"),
      prompt = TRUE
    )
    
  }
  
  # To be used with the pdf output device
  pdfFonts <- grDevices::pdfFonts
  loadfonts(device = "pdf", quiet = TRUE)
  
  # To be used with the postscript output device
  postscriptFonts <- grDevices::postscriptFonts
  loadfonts(device = "postscript", quiet = TRUE)

  # To be used with the Windows output device
  if (.Platform$OS.type == "windows") {
    windowsFonts <- grDevices::windowsFonts
    loadfonts(device = "win", quiet = TRUE)
  }
  
  if(!("Old Script" %in% fonts()) | !("Bauer Bodoni Std" %in% fonts())) {
    
    message("wedding fonts were not successfully loaded")
    
  }
  
}

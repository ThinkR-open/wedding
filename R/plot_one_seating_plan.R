#' Plot the seating plan for a given table
#'
#' @param .data Tibble.
#' @param id_table Integer.
#' @param font_family_table Character.
#' @param font_family_guests Character.
#' 
#' @importFrom dplyr filter mutate row_number
#' @importFrom ggplot2 ggplot geom_text aes coord_polar labs theme element_blank element_text geom_rect
#'
#' @return A ggplot2 object.
#' @export
#'
#' @examples
#' data(data_guests_table_example)
#' #data_guests_table_example %>% 
#'   #plot_one_seating_plan(id_table = 1)
plot_one_seating_plan <- function(.data, id_table, font_family_table = "Times", font_family_guests = "Times") {
  

  data_guests_one_table <- .data %>% 
    filter(table == id_table) %>% 
    filter(here_diner == "Oui") %>% 
    mutate(id_guest = row_number())
  
  number_of_guests <- nrow(data_guests_one_table)
  angle_guests <-  90 - 360 * (data_guests_one_table$id_guest - 0.5) / number_of_guests
  data_guests_one_table$angle <- ifelse(angle_guests < -90, angle_guests + 180, angle_guests)
  
  wood_image <- system.file("app/www", "wood.png", package = "wedding")
  
  if (number_of_guests > 0) {
    ggplot() +
      # geom_rect_pattern(
      #   aes(
      #     xmin = -1,
      #     ymin = -1,
      #     xmax = number_of_guests - 1,
      #     ymax = 1
      #   ),
      #   pattern = 'image',
      #   pattern_type = 'squish',
      #   pattern_filename = wood_image,
      #   color = "#786149",
      #   size = 2
      # ) +
      geom_rect(
        aes(
          xmin = -1,
          ymin = -1,
          xmax = number_of_guests - 1,
          ymax = 1
        ),
        fill = "#786149",
        color = "#786149",
        size = 2
      ) +
      geom_text(
        data = data_guests_one_table,
        aes(
          x = id_guest - 1,
          y = 0.5,
          label = name,
          hjust = 0.5,
          angle = angle
        ),
        color = "white",
        family = font_family_guests,
        size = 2.5,
        inherit.aes = FALSE
      ) +
      coord_polar(start = 0) +
      labs(title = paste("Table", id_table)) +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(
          family = font_family_table,
          hjust = 0.5,
          size = 30
        )
      )
  } else {
    ggplot() +
      # geom_rect_pattern(
      #   aes(
      #     xmin = -1,
      #     ymin = -1,
      #     xmax = 1,
      #     ymax = 1
      #   ),
      #   pattern = 'image',
      #   pattern_type = 'squish',
      #   pattern_filename = wood_image,
      #   color = "#786149",
    #   size = 2
    # ) +
    geom_rect(
      aes(
        xmin = -1,
        ymin = -1,
        xmax = 1,
        ymax = 1
      ),
      fill = "#786149",
      color = "#786149",
      size = 2
    ) +
      coord_polar(start = 0) +
      labs(title = paste("Table", id_table)) +
      theme(
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(
          family = font_family_table,
          hjust = 0.5,
          size = 30
        )
      )
  }
  
}

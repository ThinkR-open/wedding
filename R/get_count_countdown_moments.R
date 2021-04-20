#' Construst a count/countdown between two moments
#'
#' @param start_moment Start moment YYYY-MM-DD HH:MM:SS. Character.
#' @param end_moment End moment format YYYY-MM-DD HH:MM:SS. Character.
#' @param time_zone Time zone. Character. Default is Sys.timezone().
#' @param text Text to print at the end of the count/countdown. Character.
#' @param language Language of text. Character. Either "en" or "fr". Default is "en"
#'
#' @return Count/countdown. Character.
#' @export
#'
#' @importFrom lubridate ymd_hms now interval days hours minutes seconds
#' @importFrom glue glue
#'
#' @examples
#' get_count_countdown_moments(start_moment = "1998-07-12 21:00:00",
#'                             end_moment = lubridate::now(tzone = Sys.timezone()),
#'                             text = "since worldcup 1998")
#' 
#' get_count_countdown_moments(start_moment = "2009-10-14 04:00:00",
#'                             end_moment = "2021-10-02 15:00:00",
#'                             text = "between the moment they met and the wedding")
get_count_countdown_moments <- function(start_moment, end_moment, text, 
                                        time_zone = Sys.timezone(),
                                        language = "en") {
  
  interval_moments <- interval(ymd_hms(start_moment), 
                               ymd_hms(end_moment), 
                               tzone = time_zone)
  
  nb_days <- interval_moments %/% days(1)
  nb_hours <- interval_moments %% days(1) %/% hours(1)
  nb_minutes <- interval_moments %% days(1) %% hours(1) %/% minutes(1)
  nb_seconds <- interval_moments %% days(1) %% hours(1) %% minutes(1) %/% seconds(1)
  
  if (language == "en") {
    glue("{nb_days} d. {nb_hours} h. {nb_minutes} m. {nb_seconds} s. {text}")
  } else if (language == "fr") {
    glue("{nb_days} j. {nb_hours} h. {nb_minutes} m. {nb_seconds} s. {text}")
  }
  
}
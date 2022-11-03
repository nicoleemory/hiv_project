here::i_am("code/04_render_report.R")

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG") # added this line for "Renaming Output Files" video
config_list <- config::get(
  config = WHICH_CONFIG
)

library(rmarkdown)
# changed the below for the "Renaming Output Files" Video, but also had made the below changes in this week's (6) pre-read
#report_filename <- paste(
#  "hiv_report_",
#  "cutpoint", config_list$cutpoint, "_", # saying that we're adding another underscore after "cutpoint"
#  "production", config_list$production, 
#  ".html"
#)

report_filename <- paste(
  "hiv_report_config_",
  WHICH_CONFIG,
  ".pdf"
)

# rendering a report in production mode
render("hiv_report.Rmd",
       output_file = report_filename)


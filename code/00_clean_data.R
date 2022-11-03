here::i_am("code/00_clean_data.R")
absolute_file_location <- here::here("data","raw_data", "vrc01_data.csv") #in the example file, I used slashes--also possible to use commas like did here in between data and file name
data <- read.csv(absolute_file_location, header = TRUE)

library(labelled)
library(gtsummary)

# creating variable labels
var_label(data) <- list(id = "ID", 
                        ab_resistance = "Antibody resistance",
                        shield_glycans = "Number of Shield glycans",
                        region = "Region",
                        env_length = "Length of Env protein")

data$numberglycans <- ifelse(data$shield_glycans < 4, "<4", ">= 4") # if <4 or greater than 4

saveRDS(data, 
        file = here::here("data/output/data_clean.rds"))

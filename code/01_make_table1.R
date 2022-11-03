here::i_am("code/01_make_table1.R")

data <- readRDS(file = here::here("data/output/data_clean.rds")) # here, bringing in an object from our 00_clean_table

library(gtsummary)

table_one <- data %>% # the object that we brough in is used to create a table one
              select("region", "env_length", "ab_resistance", "numberglycans") %>% # choosing only these variables as being relevant
              tbl_summary(by = numberglycans) %>% #getting summary statistics grouped by number of glycans
              modify_spanning_header(c("stat_1", "stat_2") ~ "**Number PNGs in Glycan Shield**") %>% # this is a function that creates a nice header for us; the asterisks within the title name make the title appear in bold
              add_overall() %>% # adds an overall column
              add_p() # adding a p-value (David isn't saying that Table 1 should always contain this)

saveRDS(table_one, file = here::here("data/output/table_one.rds")) # that table one is saved
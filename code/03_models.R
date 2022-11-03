here::i_am("code/03_models.R")

data <- readRDS(file = here::here("data/output/data_clean.rds"))

library(tidyverse)
library(gtsummary)

mod <- glm(ab_resistance ~ shield_glycans + region + env_length,
           data = data)

primary_regression_table <- tbl_regression(mod) %>%
  add_global_p()

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG") # this we added from steps taking in the "Renaming Output Files" Video; reads the variable WHICH_CONFIG from the ternminal/bash
config_list <- config::get(
  config = WHICH_CONFIG # added this line of code for "Renaming Output Files" video too
) # have added this line of code

binary_mod <- glm(I(ab_resistance > config_list$cutpoint) ~ shield_glycans + region + env_length, # have added the config_list here too
                  data = data,
                  family = binomial())

secondary_regression_table <- tbl_regression(binary_mod, exponentiate = TRUE) %>%
  add_global_p()

tertiary_mod <- glm( #new code
  I(ab_resistance > config_list$cutpoint) ~ shield_glycans + region + env_length, 
  data = data,
  family = binomial(link = "probit")
)

tertiary_regression_table <- tbl_regression(tertiary_mod) %>%
  add_global_p()

both_models <- list(primary = mod,
                    secondary = binary_mod,
                    tertiary = tertiary_mod)  #wrapping both model objects into a list

# Added this
# e.g., cutpoint
# the saved file will be called both_models_cutpoint1.rds
#both_models_filename <- paste0(
#  "both_models_cutpoint", #saving an object called both_models_[name of cutpoint]
#  config_list$cutpoint, # adding actual cutpoint here
#  ".rds"
#)
# The above now turned into the below once looking at the "Renaming Output Files" video but a lot of the above was changed in this week's pre-read
# We also made changes to the both_regression_tables paste0 but did not keep the original 

# saved file will be called both_models_config_[name of the config].rds
both_models_filename <- paste0(
 "both_models_config_", 
  WHICH_CONFIG,
  ".rds"
)

saveRDS(both_models, 
        file = here::here("data/output", both_models_filename)) # changed this to outbut the both_models_filename object

both_regression_tables <- list(primary = primary_regression_table,
                               secondary = secondary_regression_table,
                               tertiary = tertiary_regression_table)

# E.g., if cutpoint = 1
# both regression_tables_config_[name of config].rds
both_regression_tables_filename <- paste0( # this is because doing the same thing that my naming macros for each program did
  "both_regression_tables_config_",
  WHICH_CONFIG,
  ".rds"
)

saveRDS(both_regression_tables, 
        file = here::here("data/output", both_regression_tables_filename))




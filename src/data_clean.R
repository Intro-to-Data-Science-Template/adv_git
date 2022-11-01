# clean the survey data

# setup ####

# load packages
library(dplyr)

# source pet_split
source("./src/pet_split.R")

# data load ####

# read in survey data
survey = read.csv("./data/survey.csv")

# clean columns ####

# fix pet columns
pet_df = pet_split(survey$pets, c("dog", "cat", "fish", "bird", "reptile", "rock", "none"))

# fix days
coffee_df = pet_split(survey$coffee_days, c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"))
tea_df = pet_split(survey$tea_days, c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"))
soda_df = pet_split(survey$soda.pop_days, c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"))
juice_df = pet_split(survey$juice_days, c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"))
none_df = pet_split(survey$none_days, c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"))

# make "other" column unique for pets
colnames(pet_df)[9] = "pet_other"

# made days unique for drinks (exclude id)
colnames(coffee_df)[-1] = paste0(colnames(coffee_df)[-1], "_coffee")
colnames(tea_df)[-1] = paste0(colnames(tea_df)[-1], "_tea")
colnames(soda_df)[-1] = paste0(colnames(soda_df)[-1], "_soda")
colnames(juice_df)[-1] = paste0(colnames(juice_df)[-1], "_juice")
colnames(none_df)[-1] = paste0(colnames(none_df)[-1], "_none")

# combine dfs ####

# add ids to main df
survey$id = 1:nrow(survey)

# join by id
survey_comb = inner_join(survey, pet_df, by = "id")
# exclude the empty other columns
survey_comb = inner_join(survey_comb, coffee_df[, 1:8], by = "id")
survey_comb = inner_join(survey_comb, tea_df[, 1:8], by = "id")
survey_comb = inner_join(survey_comb, soda_df[, 1:8], by = "id")
survey_comb = inner_join(survey_comb, juice_df[, 1:8], by = "id")
survey_comb = inner_join(survey_comb, none_df[, 1:8], by = "id")

# data out ####

write.csv(survey_comb, "./data/survey_clean.csv", row.names = FALSE)

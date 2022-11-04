# create new measures for the survey data

# setup ####

# no packages needed

# data load ####

survey = read.csv("./data/survey_clean.csv")

# measures ####

## add total caffeine intake/week ####

# get all the X_day columns for coffee and tea
caffeine_columns =  colnames(survey)[grepl("_coffee", colnames(survey)) | grepl("_tea", colnames(survey))]

# get the row sum of all Caffeine days per person, add to df
survey$week_caffeine = rowSums(survey[ , caffeine_columns])

## NEW FEATURE HERE ####
#placeholder for new column
# data write ####

# save out
write.csv(survey, "./data/survey_processed.csv", row.names = FALSE)

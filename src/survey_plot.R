# plot the survey data

# setup ####

library(ggplot2)

# data load ####

survey = read.csv("./data/survey_processed.csv")

# data prep ####

# fix Rhys name
survey$fav_char = gsub(" (from A Court of Thorns and Roses)", "", survey$fav_char, fixed = TRUE)

# re-order chars for plotting later
survey$fav_char = reorder(survey$fav_char, survey$week_caffeine, function(char){char}, decreasing = TRUE)

# plots ####

# plot the total caffeine intake
ggplot(survey) +
 aes(x = fav_char, y = week_caffeine) +
 geom_col(fill = "#112446") +
 labs(x = "Character", 
      y = "Days/week",
      title = "Total Caffeine Intake/week",
      subtitle = "SDS 192 - Fall 2022",
      caption = "Source: Class Survey") +
 theme_minimal() +
 theme(plot.title = element_text(size = 18L, face = "bold"),
       axis.text.x = element_text(angle = 45, hjust = 1))
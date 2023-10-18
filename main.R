# Libraries
library(tidyr)
library(tidyverse)
library(dplyr)
library(readr)

# Get a list of the datasets
main_dir = file.path("C:","Users","ricar","Desktop","cQuant_Exercise")
data_files <- list.files(path = file.path(main_dir,"RawData"), pattern = NULL, all.files = TRUE, full.names = TRUE)

# Remove irrelevant filenames
data_files = data_files[3:length(data_files)]

# Import dataset A
data_A <- read.csv(data_files[1])
# head(data_A)

# Import dataset B
data_B <- read.csv(data_files[2])
# head(data_B)

# Pivot dataset A into long format
data_A <- data_A %>% pivot_longer(
  cols = starts_with("Run"),
  names_to = "Run",
  values_to = "Value"
)
# head(data_A)

# Pivot dataset B into long format
data_B <- data_B %>% pivot_longer(
  cols = starts_with("Run"),
  names_to = "Run",
  values_to = "Value"
)
# head(data_B)

# Join both datasets by the Name, Date, and Run variables
combined_data <- merge(x = data_A, y = data_B, by = c("Name", "Date", "Run"))
# head(combined_data)

# Change the column names to better reflect the data
colnames(combined_data)[which(names(combined_data) == "Value.x")] <- "Value.A"
colnames(combined_data)[which(names(combined_data) == "Value.y")] <- "Value.B"
# head(combined_data)

# Determine difference metrics for the data and add them onto the data frame
combined_data$Value_diff <- combined_data$Value.A - combined_data$Value.B
combined_data$Percent_diff <- (combined_data$Value.A - combined_data$Value.B) / combined_data$Value.A
combined_data$Abs_value_diff <- abs(combined_data$Value_diff)
combined_data$Abs_percent_diff <- abs(combined_data$Percent_diff)
# head(combined_data)

# Calculate summary statistics
#stats_by_year <- combined_data $>$ 
#  group_by(Date = floor_date(Date, "year")) $>$
#  summarize(mins = min(combined_data$Abs_value_diff), maxs = max(combined_data$Abs_value_diff), means = mean(combined_data$Abs_value_diff))
#head(stats_by_year)

#stats_by_month <- combined_data $>$ 
#  group_by(Date = floor_date(Date, "month")) $>$
#  summarize(mins = min(combined_data$Abs_value_diff), maxs = max(combined_data$Abs_value_diff), means = mean(combined_data$Abs_value_diff))
#head(stats_by_year)

#stats_by_day <- combined_data $>$ 
#  group_by(Date = floor_date(Date, "day")) $>$
#  summarize(mins = min(combined_data$Abs_value_diff), maxs = max(combined_data$Abs_value_diff), means = mean(combined_data$Abs_value_diff))
#head(stats_by_year)

#stats_by_hour <- combined_data $>$ 
#  group_by(Date = floor_date(Date, "1 hour")) $>$
#  summarize(mins = min(combined_data$Abs_value_diff), maxs = max(combined_data$Abs_value_diff), means = mean(combined_data$Abs_value_diff))
#head(stats_by_year)

# I indended to use scatter plots to display the data by year and month, 
# showing trends in how this data varies by year. I also intended to use 
# bar graphs to show which day of the week sees the most difference in the data
# and a similar graph for the hours of the day.
# Case Study 4
  # Eleanor M. Byrne 

# install/load packages 
library(tidyverse)
# install.packages('nycflights13')
library(nycflights13)
library(dplyr)


# Open and access the nyc flights 
airports <- nycflights13::airports
flights <- nycflights13::flights

# Find the maximum distance and the corresponding destination airport code
highest <- flights %>%
  arrange(desc(distance)) %>%
  slice(1) %>% 
  select(dest, distance)
# It would be HNL (dest)

# Join with airports data to get the full name of the airport
farthest_airport_data <- highest %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  select(name) # select the the destName column only 

# Convert the data.frame to a single character value with as.character()
farthest_airport <- as.character(farthest_airport_data$name)





  
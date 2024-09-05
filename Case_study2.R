# Case Study 2
  # Eleanor M. Byrne 

# 1. Dowload the data 
  # downloaded as csv file 

# 2. Download/install packages 
library(tidyverse) 

# 3. Define the csv link
nasa_url <- "C:/Users/Margo/OneDrive/Documents/Fall 2024 Courses/Spatial Data Science Course/Spatial_DataScience/station.csv"
  # input the directory/path 

# 4. read the csv file 
temp_data <- read.csv(nasa_url)
  # use read.csv function 

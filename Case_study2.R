# Case Study 2
  # Eleanor M. Byrne 

# 1. Dowload the data 
  # downloaded as csv file 

# 2. Download/install packages 
library(tidyverse) 
library(ggplot2)

# 3. Define the csv link
nasa_url <- "C:/Users/Margo/OneDrive/Documents/Fall 2024 Courses/Spatial Data Science Course/Spatial_DataScience/station.csv"
  # input the directory/path 

# 4. read the csv file 
temp_data <- read.csv(nasa_url, na.strings = "999.90")
  # use read.csv function
  # na.strings for assuming 999.90 is NA/invalid

# 5. Graph the annual mean temperature in June, July and August (JJA) 
      # using ggplot
    # first, take the June, July, and August and put it into 
        # their own dataframe
jja_data <- data.frame(Year = temp_data$YEAR, 
                       June = temp_data$JUN, 
                       July = temp_data$JUL, 
                       August = temp_data$AUG)

# 5. Find the mean using rowMeans 
    # rowMeans: used to calculate the mean of several rows of a matrix or data frame
jja_data$Mean_Temperature <- rowMeans(jja_data[, c("June", "July", "August")], na.rm = TRUE)
    # na.rm means that NA values should be removed before plotting 

# 6. Using ggplot 
    # Plot the data using ggplot2
    # Include the geom_smooth
p <- ggplot(jja_data, aes(x = Year, y = Mean_Temperature)) +
  # have the jja_data variable, Year, and the Mean_Temperature 
  geom_line(color = "blue") +
  geom_smooth(method = "loess", color = "red") +
  # use geom_smooth
  xlab("Year") +
  ylab("Mean Temperature (°C)") +
  ggtitle("Annual Mean Temperature in June, July, and August (JJA)")
    # use ggtitle 
plot(p)

#7. Now save the file using png and ggsave 
ggsave("annual_mean_temp_JJA.png", plot = p, width = 10, height = 6, dpi = 300)
  # find a width and height that works and won't cut off anything 
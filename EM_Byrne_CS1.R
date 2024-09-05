# 8/29/2024 
  # Spatial Data Science Course 
    # Your First Script Assignment 

# sources/references
  # https://www.geeksforgeeks.org/histograms-in-r-language/
  # R studio help section: Histogram 


# 1. Created a new script for assignment & save file 

# 2. Load the iris dataset 
data("iris") # data() displays list of available datasets
  # Add in the specific dataset in data("_name_here_")
library(ggplot2)

# 3. Finding the mean of Petal.Length
petal_length_mean <- mean(iris$Petal.Length)
  # assign variable to the mean found  
  # iris is the name of the dataset and using $ will direct/display 
      # the data from that column 

# 4. Plot the Petal.Length on a histogram graph 
hist(iris$Petal.Length, xlab = "Length of Petal", main = "Histogram of Petal Length", 
     col = 'blue',border = 'pink')
  # adding a line of the mean using abline  
abline(v=petal_length_mean, col = "yellow", lty = 2, lwd = 3)
  # xlab is the x-axis label
  # iris$Sepal.Length will be the x-axis 
  # col is the color chosen 
  # border is the line color of the border, can also input null(non)


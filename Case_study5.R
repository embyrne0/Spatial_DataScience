# Case  Study 5 
  # Eleanor M. Byrne 

# Step 1 
  # download the libraries/packages 
#install.packages("spData")
#install.packages("sf")
#install.packages("tidyverse")
# install.packages("units")

library(spData)
library(sf)
library(tidyverse)
library(units)
  # download the data 
data(world) # this is the data from the spData package 
  # load the lad 
data(us_states)

# Step 2
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
  # transform to the albers equal area projection 
  # # Transform world dataset to Albers Equal Area projection
world_albers <- st_transform(world, crs = albers)
  # Canada
  # Filter the world dataset to include only Canada
canada <- world_albers %>% 
  filter(name_long == "Canada") # filter the world dataset for Canada 
  # Set to 10km (10000m)
# Buffer Canada by 10 km (10000 meters)
canada_buffer <- st_buffer(canada, dist = 10000)
  # plot using ggplot 
ggplot() +
  geom_sf(data = canada_buffer, fill = "lightblue", color = "black") +
  ggtitle("Buffered Area of Canada (10 km)") +
  theme_minimal()

# Step 3
  # Create one for New York 
# transform us_states dataset to the same Albers projection
us_states_albers <- st_transform(us_states, crs = albers)

  # filter for NY
new_york <- us_states_albers %>% 
  filter(NAME == "New York") # New York and use the us_states_albers 
  # Create border object by intersecting Canada buffer with New York

border <- st_intersection(canada_buffer, new_york)

# Step 4
  # Plot using ggplot and geom_sf()
# Plot the border area using ggplot2
# Step 8: Plot the border area using ggplot and geom_sf()
ggplot() +
  geom_sf(data = new_york, fill = 'blue', color = "red") +  # New York outline
  geom_sf(data = border, fill = "yellow", color = "black") +  # Intersection area
  ggtitle("Border Area Between Canada and New York") +
  theme_minimal()

# Step 5
  # Calculate the area of the intersected polygon
area_sq_m <- st_area(border) # Area in square meters
  # Convert to km^2
area_sq_km <- set_units(area_sq_m, km^2)
  # Print the area in square kilometers
print(area_sq_km)

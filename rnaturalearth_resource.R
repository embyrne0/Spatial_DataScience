# Presentation for rnaturalearth
  # Eleanor M. Byrne 

# Install the package
# install.packages("rnaturalearth") 
  # additional packages that are needed (important)
#install.packages("rnaturalearthdata")
# install.packages("ggOceanMaps")
# install.packages("ggspatial")
# install.packages("randomcoloR")


# Call the libraries
  # make sure they are install prev
library(rnaturalearth)
library(rnaturalearthdata)
library(sf) # used for simple spatial vector data
library(ggplot2) # creating data visualizations
library(dplyr) # data manipulation and transformation
library(ggOceanMaps) # Oceanographic data visualization
library(randomcoloR) # For generating random colors


# Download the required data for Greenland 
world_data <- ne_countries(scale = "medium", returnclass = "sf")
  # Download country boundaries at the 1:50m scale
# Plot all countries (optional, for verification)
plot(ne_countries()) 
# Filter for Greenland
greenland <- world_data %>% filter(admin == "Greenland")

# Visualize Greenland using ggplot 
greenland_base <- ggplot() +
  geom_sf(data = greenland, fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Map of Greenland",
       subtitle = "Source: Natural Earth",
       caption = "Visualization by Eleanor M. Byrne")
plot(greenland_base)

# Download glaciated areas at the medium scale (1:50m)
glaciers <- ne_download(scale = "medium", type = "glaciated_areas", category = "physical", returnclass = "sf")
  # Explanation of parameters
    # scale: The map scale (resolution) of the data, e.g., "small", "medium", "large".
    # type: The type of vector layer to download, e.g., "glaciated_areas", "lakes", "rivers".
    # category: The category of the data, e.g., "physical" for physical features, "cultural" for cultural features.

# Is to filter the glaciers on to Greenland 
  # Clean the geometries to ensure they are valid
glaciers <- st_make_valid(glaciers)
greenland_glaciers <- st_intersection(glaciers, greenland)

# Plotting Greenland glaciers
greenland_filter <- ggplot() +
  geom_sf(data = greenland, fill = "lightblue", color = "black") +
  geom_sf(data = greenland_glaciers, fill = "white", color = "blue") +
  theme_minimal() +
  labs(title = "Glaciers in Greenland",
       subtitle = "Source: Natural Earth",
       caption = "Visualization by Eleanor M. Byrne")
plot(greenland_filter)


# Load the KML file
kml_file <- "C:/Users/Margo/Downloads/Greenland_glaciers.kml"
kml_data <- st_read(kml_file)
# Generate random colors for each glacier
set.seed(123)  # Set seed for reproducibility of random colors
colors <- randomColor(nrow(kml_data), hue = "random", luminosity = "light")
  # using the randomcolors package for kml_data 

# Create a color mapping data frame
color_mapping <- data.frame(Name = kml_data$Name, color = colors)

# Join the color mapping with the KML data
kml_data <- kml_data %>%
  left_join(color_mapping, by = "Name")

# Visualize Greenland and its glaciers using ggOceanMaps
ggOcean_Greenland <- basemap(limits = c(-75, -15, 58, 84), bathymetry = TRUE, rotate = TRUE) +
  geom_sf(data = greenland, fill = "lightblue", color = "black") +
  geom_sf(data = greenland_glaciers, fill = "white", color = "blue") +
  geom_sf(data = kml_data, aes(geometry = geometry, color = color), size = 1) + # Use the color column for mapping
  scale_color_identity() + # Use specified colors directly
  theme_minimal() +
  labs(title = "Glaciers in Greenland",
       subtitle = "Source: Natural Earth and KML File",
       caption = "Visualization by Eleanor M. Byrne")
# Plot the map
plot(ggOcean_Greenland)
  # basemap is used for oceanographic data
  # limits is the geographical limits of the map (longitude and latitude)
  # bathymetry adds underwater topography 
  # geom_sf plots the geometry of Greenland 



# Case Study 3 
  # Eleanor M. Byrne 

# sources/references 
  # https://cran.r-project.org/web/packages/gapminder/readme/README.html 
  # https://www.staringatr.com/1-data-exploration-and-manipulation/manipulating-data/3_filter/

# Step 1a. Load the library 
  # intsall if needed to 
# install.packages("gapminder")
  # load 
library(ggplot2)
library(gapminder)
library(dplyr)

# Step 1b. Remove “Kuwait” from the gapminder
  # use filter 
gapminder_filtered <- filter(gapminder, country != "Kuwait")
  # removed 

# Step 2. Use ggplot() and the theme_bw()
  # use the new Data variable that was created 
gdp_exp <- ggplot(gapminder_filtered,aes(x = lifeExp, y =  gdpPercap, 
                              color = continent, size=pop/100000)) +
  geom_point() +
  facet_wrap(~year, nrow = 1) +
  scale_y_continuous(trans = "sqrt") +
  theme_bw() +
  labs(
    x = "Life Expectancy",
    y = "GDP per Capita",
    size = "Population (100k)",
    color = "Continent"
  )
plot(gdp_exp)

# Step 3a. Group by function for continent and year 
# Group by continent and year and summarize the data
gapminder_continent <- gapminder_filtered %>%
  group_by(continent, year) %>%
  summarize(
    gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop),
    pop = sum(as.numeric(pop))
  )

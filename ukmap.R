require(tidyverse)
require(maps)

worldmap = map_data('world')

cities = read_csv("places.cesv")
rr = read_csv("ukinstitutions.csv", comment = "#")

m <- ggplot() + 
  geom_polygon(data = worldmap, 
               aes(x = long, y = lat, 
                   group = group), 
               fill = 'gray90', 
               color = 'black') + 
  coord_fixed(ratio = 1.3, 
              xlim = c(-10,3), 
              ylim = c(50, 59)) +
  ## theme_void() + 
  geom_point(data = cities,
             aes(x= long, y=lat))

ggplotly(m)

## https://bookdown.org/yann_ryan/r-for-newspaper-data/mapping-with-r-geocode-and-map-the-british-librarys-newspaper-collection.html



p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
   geom_point() + geom_smooth()
ggplotly(p)


library(ggplot2)
library(ggiraph)
data <- mtcars
data$carname <- row.names(data)

gg_point = ggplot(data = data) +
    geom_point_interactive(aes(x = wt, y = qsec, color = disp,
    tooltip = carname, data_id = carname)) + 
  theme_minimal()

girafe(ggobj = gg_point)

install.packages("leaflet")
require(leaflet)
m <- leaflet() %>% setView(lng = 0.1313, lat = 52.1951, zoom = 6)
m %>% addTiles()





library(htmltools)

df <- read.csv(textConnection(
"Name,Lat,Long
Samurai Noodle,47.597131,-122.327298
Kukai Ramen,47.6154,-122.327157
Tsukushinbo,47.59987,-122.326726"
))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~htmlEscape(Name),
             labelOptions = labelOptions(noHide = T))


leaflet(cities) %>% addTiles() %>%
  addMarkers(~long, ~lat, label = ~htmlEscape(institution),
             labelOptions = labelOptions(noHide = FALSE))


merged <- merge(x=rr, y=cities, by="Institution")
merged <- merged %>% mutate(label = sprintf("<a href=\"%s\">%s</a>",
                                            Reference, Institution))
leaflet(merged) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~label,
            options = popupOptions(closeButton = TRUE))

df = data.table(data_frame(a = c(rep("a",3), rep("b",3), rep("c",4)), b = 1:10, c = 3:12))
df1 = data.table(data_frame(a = c(rep("a",3), rep("b",3), rep("c",4)), b = 1:10, c = 3:12), d = 5:14)
codes =c("67028","92235","67228","67210","67145")


me = data[lname =="LEE" & fname =="PAUL" & city=="WILLIAMSVILLE"]
codes = unique(me$code)

fx1 = function(d){
  u = unique(d$npi)
  r = list();
  s = list();
  for (i in 1:length(u)) {
    q= data.table(filter(d, npi == u[i]))
    
    q$costPerProc = q$srvccnt * q$avgpmt # total cost per procedure
    
    
    q1  = q[, totalPatients := sum(uniquebene)] 
    q2  = q1[, totalPmt := sum(costPerProc), by =. (npi)]
    q3  = q2[, pmtPerPatient := totalPmt/totalPatients, by =. (npi)]
    q4 = q3[code %in% codes]
    retinaTotal = sum(q4$costPerProc)
    allTotal = sum(q3$costPerProc)
    #retinaStatus = ifelse(retinaTotal/allTotal > 0.7, "Y", "N")
    
    r[[i]] = ifelse(retinaTotal/allTotal > 0.7, "Y", "N")
    s[[i]] = c(status = r[[i]], key =u[i])
  }
  t = data.frame(do.call(rbind, s))
  t$val = as.character(t$status)
  t$key = as.character(t$key)
  
  return(t)
}


ans = fx1(data)

fx1(df1)

library(plotly)

blank_layer <- list(
  title = "",
  showgrid = F,
  showticklabels = F,
  zeroline = F)

p <- map_data("county") %>%
  filter(region == 'usa') %>%
  group_by(group) %>%
  plot_ly(
    x = ~long,
    y = ~lat,
    fillcolor = 'white',
    hoverinfo = "none") %>%
  add_polygons(
    line = list(color = 'black', width = 0.5)) %>%
  layout(
    xaxis = blank_layer,
    yaxis = blank_layer)



p


df <- read.csv("https://raw.githubusercontent.com/bcdunbar/datasets/master/californiaPopulation.csv")

cty = map_data("county")
cty$country = "usa"

cali <- cty %>%
  filter(country == 'usa')

geo <- list(
  scope = 'usa',
  showland = TRUE,
  landcolor = toRGB("gray95"),
  countrycolor = toRGB("gray80")
)

p <- cali %>%
  group_by(group) %>%
  plot_geo(
    x = ~long, y = ~lat, color = ~subregion, colors = c('#ffeda0','#f03b20'),
    text = ~subregion, hoverinfo = 'text') %>%
  add_polygons(line = list(width = 0.4)) %>%
  add_polygons(
    fillcolor = 'transparent',
    line = list(color = 'black', width = 0.5),
    showlegend = FALSE, hoverinfo = 'none'
  ) %>%
  layout(
    title = "California Population by County",
    geo = geo)

p




library("googleVis")
require(datasets)
states <- data.frame(state.name, state.x77)
GeoStates <- gvisGeoChart(states, "state.name", "Illiteracy",
                          options=list(region="US", 
                                       displayMode="regions", 
                                       resolution="provinces",
                                       width=600, height=400))
plot(GeoStates)



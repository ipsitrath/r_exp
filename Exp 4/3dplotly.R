setwd("F:\\Scripts\\github\\Exp 4")
d1 <- read.csv("data\\vgsales.csv", header = TRUE)
View(d1)
colnames(d1)
library(plotly)
library(plyr)

str(d1)
colnames(d1)

d2 <- d1[!(grepl(paste(c("N/A", "2020", "2017" ), collapse="|"), d1$Year)), ]

d2$Year <- factor(d2$Year)
d3 <- ddply(d2,"Year", summarise, America_Sales=sum(NA_Sales), Global_Sales=sum(Global_Sales))

p <- plot_ly(d3, x = ~Year, y = ~America_Sales, z = ~Global_Sales, type = 'scatter3d', mode = 'lines',
             line = list(color = 'tomato', width = 5))%>%
  layout(scene = list(xaxis = list(title = 'Year'),
                      yaxis = list(title = 'American Sales($)'),
                      zaxis = list(title = 'Global Sales($)')))
p

table(d2$Platform)
#d4 <- d2[(grepl(paste(c("PS4", "XB", "PSP" ), collapse="|"), d1$Platform)), ]

p <- plot_ly(d2, x = ~Year, y = ~EU_Sales, z = ~NA_Sales, color = ~Platform) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Year'),
                      yaxis = list(title = 'Europe Sales($)'),
                      zaxis = list(title = 'American Sales($)')))

p


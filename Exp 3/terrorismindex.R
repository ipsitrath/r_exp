d1 <- read.csv("data\\globalterrorismdb_0616dist.csv", header = TRUE) #unzip the data 

library(plotly)
library(dplyr)
library(ggplot2)
library(plyr)

t_india <- subset(d1, country_txt=="India")

freq1 <- data.frame(table(t_india$attacktype1_txt))

p <- plot_ly(freq1, x=~Var1, y=~Freq,type = "bar",
             marker = list(color = 'tomato',
                           line = list(color = 'whitesmoke')))%>% 
  layout(title="Types of Terrorist Incidents in India",
         yaxis=list(title="Count", showgrid=FALSE), xaxis=list(title="Attack Type"))

p

freq2 <- data.frame(table(t_india$iyear))
freq2 <- freq2[-(1:4),]

p <- plot_ly(freq2, x=~Var1, y=~Freq,color='red',type = "scatter", mode="line",
             marker = list(color = 'tomato'))%>%
  layout(title="Terrorist Incidents in India by year",
         yaxis=list(title="Frequency", showgrid=FALSE), xaxis=list(title="Year", showgrid=FALSE))
p

t_india$count <- 1
freq3 <- ddply(t_india, c("targtype1_txt"), summarise, fatality=sum(nkill, na.rm = TRUE), injury=sum(nwound, na.rm = TRUE), count=sum(count))
freq3 <- mutate(freq3, counp=round((count/sum(count))*100, 2))%>% 
  filter(counp>5)

freq3$text <- paste(freq3$targtype1_txt, freq3$counp,"%", sep = " ")


p <- plot_ly(freq3, x = ~fatality, y = ~injury, text = ~targtype1_txt, type = 'scatter', mode = 'markers',
            marker = list(size = ~count/44, opacity = 0.5, color = ~counp)) %>%
  layout(title = 'Terrorist Attack Targets in India',
         xaxis = list(title="Deaths", showgrid = FALSE, range = c(0, 7000)),
         yaxis = list(title="Injury", showgrid = FALSE, range = c(0, 8000)))%>%
  add_annotations(text = ~paste(text,"\n", fatality, "Deaths"), showarrow = TRUE,
                  font = list(size = 9))

p


freq4 <- ddply(t_india, c("provstate"), summarise, fatality=sum(nkill, na.rm = TRUE), injury=sum(nwound, na.rm = TRUE), Attacks=sum(count))

detach("package:plotly", unload=TRUE)


library(googleVis)
freq4$provstate <- as.character(freq4$provstate)
freq4$provstate <- as.factor(freq4$provstate)


stt <- gvisGeoChart(freq4,locationvar="provstate",
                    colorvar ="Attacks", hovervar= "fatality",
                    options =list(region = "IN",
                                  resolution = "provinces",
                                  width=1200, height=800, displayMode="region", colorAxis="{colors:['white', 'tomato']}"))
plot(stt)


d1$count <- 1
freq5 <- ddply(d1, c("country_txt"), summarise, fatality=sum(nkill, na.rm = TRUE), injury=sum(nwound, na.rm = TRUE), Attacks=sum(count))

stt1 <- gvisGeoChart(freq5,locationvar="country_txt",
                    colorvar ="Attacks", hovervar= "fatality",
                    options =list(width=1200, height=800, 
        displayMode="region", colorAxis="{colors:['white', 'orange']}"
        ))
plot(stt1)

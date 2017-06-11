setwd("F:\\Scripts\\github")
library(foreign)
asi <- read.dta("asi1214.dta")
#Imported the appended Annual Survey of Industries data(1998-99 to 2013-14)


asi <- subset(asi,!(asi$workersM > quantile(asi$workersM,
      probs=c(.01, .99),  na.rm = TRUE)[2] | asi$workersM <
      quantile(asi$workersM, probs=c(.01, .91),  
               na.rm = TRUE)[1]) ) 
asi <- subset(asi,!(asi$total_outputM > quantile(asi$total_outputM,
       probs=c(.01, .99),  na.rm = TRUE)[2] | asi$total_outputM <
       quantile(asi$total_outputM, probs=c(.01, .91),  
                               na.rm = TRUE)[1]) ) 
asi <- subset(asi,!(asi$fixed_capitalM > quantile(asi$fixed_capitalM,
       probs=c(.01, .99),  na.rm = TRUE)[2] | asi$fixed_capitalM <
       quantile(asi$fixed_capitalM, probs=c(.01, .91),  
                               na.rm = TRUE)[1]) ) 
asi <- subset(asi,!(asi$gvaM > quantile(asi$gvaM,
       probs=c(.01, .99),  na.rm = TRUE)[2] | asi$gvaM <
                      quantile(asi$gvaM, probs=c(.01, .91),  
                               na.rm = TRUE)[1]) ) 
asi <- subset(asi,!(asi$wageworkersM > quantile(asi$wageworkersM,
       probs=c(.01, .99),  na.rm = TRUE)[2] | asi$wageworkersM <
       quantile(asi$wageworkersM, probs=c(.01, .91),  
                               na.rm = TRUE)[1]) ) 

asi$state <- as.factor(asi$state)
asi$rural_urban <- as.factor(asi$rural_urban)
asi$year <- as.factor(asi$year)
x <- asi[grepl(paste(c("Bihar", "Gujarat","Maharashtra", "Punjab" ), collapse="|"), asi$state), ]

library(ggplot2)

qplot(state, workersM, color=factor(rural_urban),data = x, cex=I(1),
      xlab="States", ylab="Workers",
      main="Industrial Workers in Rural & Urban Areas", geom=c("jitter"))
qplot(state, workersM,data = x, cex=I(1),
      xlab="States", ylab="Workers",
      main="Industrial Workers", geom=c("jitter"))

# Now check the Workers vs Total Output. 
ggplot(data=x, aes(x = workersM, y = total_outputM)) +
  geom_point(aes(color=state)) +
  xlab("workers") + 
  ylab("total_output") +
  ggtitle("Output vs Workers")
library(car)
scatterplot(x$workersM, x$gvaM,xlab = "Workers", ylab = "Value Added", main="GVA vs Workers Regression Line")
scatterplot(x$workersM, x$gvaM,xlab = "Workers", ylab = "Wage", main="Wage vs Workers Regression Line")

y <- subset(x, select = c("state","year", "rural_urban", "fixed_capitalM", "gvaM","wageworkersM", "workersM", "total_outputM"))
library(data.table)
setnames(y, old=c("fixed_capitalM","gvaM", "wageworkersM", "workersM"), new=c("Capital", "GVA", "Wage", "Workers"))

y <- y[grepl(paste(c("Bihar", "Gujarat", "Punjab" ), collapse="|"), y$state), ]
library(GGally)
ggpairs(data =y,columns=4:7,
        title = "ASI Correlation Plot",
        upper = list(continuous = wrap("cor", size = 5)), 
        lower = list(continuous = "smooth"),
        mapping = aes(color=state)
)

library(plyr)
library(googleVis)
gv <- ddply(asi,c("state"), summarise, Output=mean(total_outputM) )

gv$state <- revalue(gv$state, c("Chattisgarh"="Chhattisgarh", "Arunachal Pradesh"="Arunachal Pradesh"))


stt <- gvisGeoChart(gv,locationvar="state",
                    colorvar ="Output",
                    options =list(region = "IN",
                                  resolution = "provinces",
                                  width=1200, height=650))
plot(stt)
print(stt, file="myGoogleVisChart.html")



asi <- read.dta("asi.dta")
asi$state <- as.factor(asi$state)

asi <- subset(asi,!(asi$mandays > quantile(asi$mandays, probs=c(.01, .99),  na.rm = TRUE)[2] | asi$mandays < quantile(asi$workers, probs=c(.01, .91),  na.rm = TRUE)[1]) ) 
asi <- subset(asi,!(asi$gva > quantile(asi$gva, probs=c(.01, .99),  na.rm = TRUE)[2] | asi$gva < quantile(asi$gva, probs=c(.01, .91),  na.rm = TRUE)[1]) ) 
asi <- subset(asi, !(year=="1999" |year=="2000"| year== "2014"))

asi$state <- revalue(asi$state, c("35"="Andaman & N. Island", 	"28"="Andhra Pradesh", 	"12"="Arunachal Pradesh", 	"18"="Assam", 	"10"="Bihar", 	"4"="Chandigarh (U.T.)", 	"22"="Chattisgarh", 	"26"="Dadra & Nagar Haveli", 	"25"="Daman & Diu", 	"7"="Delhi", 	"30"="Goa", 	"24"="Gujarat", 	"6"="Haryana", 	"2"="Himachal Pradesh", 	"1"="Jammu & Kashmir", 	"20"="Jharkhand", 	"29"="Karnataka", 	"32"="Kerala", 	"31"="Lakshadweep", 	"23"="Madhya Pradesh", 	"27"="Maharashtra", 	"14"="Manipur", 	"17"="Meghalaya", 	"15"="Mizoram", 	"13"="Nagaland", 	"21"="Odisha", 	"34"="Puducherry", 	"3"="Punjab", 	"8"="Rajasthan", 	"11"="Sikkim", 	"33"="Tamil Nadu", 	"16"="Tripura", 	"9"="Uttar Pradesh", 	"5"="Uttarakhand", 	"19"="West Bengal" ))

y <-ddply(asi, c("state","year"), summarise, m=mean(mandays), op=mean(gva) ) 
x <- y[grepl(paste(c("Bihar", "Gujarat", "Maharashtra","Punjab", "Delhi", "Odisha", "Tamil Nadu" ), collapse="|"), y$state), ]

qplot(year, op/m, data = x,color=factor(state),linetype=factor(state), cex=I(1.6),
      xlab="Year", ylab="Labor Productivity",
      main="Labor Productivity in Indian Formal Sector", geom="line")


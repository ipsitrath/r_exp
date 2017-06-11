
d1 <- read.csv("data\\movie_metadata.csv", header = TRUE)
View(d1)
str(d1)
library(dplyr)
d2 <- select(d1, num_critic_for_reviews, gross, num_voted_users,
             cast_total_facebook_likes, num_user_for_reviews,
             country, budget, imdb_score)
 
d2 <- subset(d2,!(d2$gross > quantile(d2$gross,
             probs=c(.01, .99),  na.rm = TRUE)[2] | d2$gross <
               quantile(d2$gross, probs=c(.01, .91),
                                na.rm = TRUE)[1]) )
d2 <- subset(d2,!(d2$budget > quantile(d2$budget,
                                      probs=c(.01, .99),  na.rm = TRUE)[2] | d2$budget <
                    quantile(d2$budget, probs=c(.01, .91),
                             na.rm = TRUE)[1]) )


x <- select(d2, gross, budget)

library(plotly)

d2 <- mutate(d2, category = cut(imdb_score,c(0,5,7,10), labels = c("bad(rating<5.0)", "average(5.0<rating<7.0)", "good(7.0<rating)")))

pal <- c("yellowgreen", "lavenderblush3", "steelblue4")
pal <- setNames(pal, c("bad(rating<5.0)", "average(5.0<rating<7.0)", "good(7.0<rating)"))
p <- plot_ly(data = d2, x = ~gross, 
             y = ~budget, type = 'scatter', color = ~category, 
             colors = pal, symbol = ~category, symbols = c("x", "o", "star"),
             mode = 'markers', marker = list(size=12))%>%
  layout(title="Scatter of Movie Budgets and Gross Earnings", xaxis=list(title="Gross Earnings($)"), yaxis=list(title="Movie Budget($)"))
p

# p <- plot_ly(data = d2, x = ~gross, 
#              y = ~budget, 
#              color = ~imdb_score, size= ~imdb_score)
# p

q <- d2 %>%
  group_by(category) %>%
  summarise(Average_Earnings=round(mean(gross, na.rm=TRUE)), Average_Budget=mean(budget, na.rm=TRUE))



p2 <- plot_ly(q, labels = ~category, values = ~Average_Earnings, type = 'pie')%>%
          layout(title="Average Gross Earnings of Movies According IMDB Ratings", showlegend=TRUE)
p2

# p3 <- plot_ly(q, labels = ~category, values = ~Average_Budget, type = 'pie')%>%
#   layout(title="Average Budget of Movies According IMDB Ratings", showlegend=TRUE)

d2 <- mutate(d2, returns=gross/budget)

s1 <-lm(returns~(imdb_score+num_voted_users+cast_total_facebook_likes), data = d2)

summary(s1)

library(ggplot2)

p <- ggplot(data = d2, aes(x = gross, y = budget)) +
  geom_point() +
  geom_smooth(aes(colour = category, fill = category)) + facet_wrap(~ category)+
  ggtitle("Gross Earnings Vs Budget 2") +
  labs(x="Gross Earnings", y="Budget")

ggplotly(p)


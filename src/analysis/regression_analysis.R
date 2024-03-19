# install and load the needed packages
library(readr)

# load the datasets
during_festival <- read.csv("src/data_prep/during_festival_data_cleaned.csv")
off_festival <- read.csv("src/data_prep/off_festival_data_cleaned.csv")
combined_price.x <- read.csv("src/data_prep/combined_price.x.csv")
combined_price.y <- read.csv("src/data_prep/combined_price.y.csv")

# estimate the mean of the prices during the festival and before/after
mean_price_during.x<- mean(during_festival$price.x, na.rm = TRUE)
mean_price_during.x

mean_price_during.y<- mean(during_festival$price.y, na.rm = TRUE)
mean_price_during.y

mean_price_off <- mean(off_festival$price, na.rm = TRUE)
mean_price_off

#estimate a linear regression with price and during and off festival
price_off_during.x <- lm(price ~ dataset, data = combined_price.x)
price_off_during.x

price_off_during.y <- lm(price~ dataset, data = combined_price.y)
price_off_during.y

# estimate a linear regression with price during and off the festival
price_off_festival <- lm(price ~ 1, data = off_festival)
summary(price_off_festival)

price.x_during_festival <- lm(price.x ~ 1, data = during_festival)
summary(price.x_during_festival)

price.y_during_festival <- lm(price.y ~ 1, data = during_festival)
summary(price.y_during_festival)


# estimate a linear regression with price and neighbourhood group, number of reviews, minimum nights and room type during the festival 
# the base line are entire home/apt and neighbourhood group Ciutat Vella 
everything_during_festival.x <- lm(price.x ~ number_of_reviews + minimum_nights.x + room_type +  neighbourhood_group, data = during_festival)
summary(everything_during_festival.x)

everything_during_festival.y <- lm(price.y ~ number_of_reviews + minimum_nights.y + room_type +  neighbourhood_group, data = during_festival)
summary(everything_during_festival.y)


# estimate the linear regression with price and minimum nights for off and during festival
# (minimum nights is the one usefull variable both of the datasets have in common)
minimum_nights_off_festival <- lm(price ~ minimum_nights, data = off_festival)
summary(minimum_nights_off_festival)

minimum_nights_during_festival.x <- lm(price.x ~ minimum_nights.x, data = during_festival)
summary(minimum_nights_during_festival.x)

minimum_nights_during_festival.y <- lm(price.y ~ minimum_nights.y, data = during_festival)
summary(minimum_nights_during_festival.y)

# save results (I will do this after figuring out the x and y thing)
# save(mean_price_during.x, mean_price_during.y, mean_price_off, file="./gen/analysis/output/model_results.RData")





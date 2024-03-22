# install and load the needed packages
library(readr)

# load the datasets
during_festival <- read.csv("../../src/data_prep/during_festival_data_cleaned.csv")
off_festival <- read.csv("../../src/data_prep/off_festival_data_cleaned.csv")
combined_price <- read.csv("../../src/data_prep/combined_price.csv")

# estimate the mean of the prices during the festival and before/after
mean_price_during<- mean(during_festival$price, na.rm = TRUE)
mean_price_during

mean_price_off <- mean(off_festival$price, na.rm = TRUE)
mean_price_off

# Calculate summary statistics of mean_price_during
min_value_during <- min(during_festival$price, na.rm = TRUE)
q1_value_during <- quantile(during_festival$price, probs = 0.25, na.rm = TRUE)
median_value_during <- median(during_festival$price, na.rm = TRUE)
mean_value_during <- mean(during_festival$price, na.rm = TRUE)
q3_value_during <- quantile(during_festival$price, probs = 0.75, na.rm = TRUE)
max_value_during <- max(during_festival$price, na.rm = TRUE)

# Calculate summary statistics of mean_price_off
min_value_off <- min(off_festival$price, na.rm = TRUE)
q1_value_off <- quantile(off_festival$price, probs = 0.25, na.rm = TRUE)
median_value_off <- median(off_festival$price, na.rm = TRUE)
mean_value_off <- mean(off_festival$price, na.rm = TRUE)
q3_value_off <- quantile(off_festival$price, probs = 0.75, na.rm = TRUE)
max_value_off <- max(off_festival$price, na.rm = TRUE)

# Convert percentiles to numerical values
q1_value_during <- as.numeric(q1_value_during)
q3_value_during <- as.numeric(q3_value_during)
q1_value_off <- as.numeric(q1_value_off)
q3_value_off <- as.numeric(q3_value_off)

# Create a data frame with summary statistics for mean_price_during and mean_price_off
summary_df_during_off <- data.frame(
  Variable = c("during", "off"),
  Mean = c(mean_value_during, mean_value_off),
  Median = c(median_value_during, median_value_off),
  Min = c(min_value_during, min_value_off),
  Max = c(max_value_during, max_value_off),
  Q1 = c(q1_value_during, q1_value_off),
  Q3 = c(q3_value_during, q3_value_off)
)


# estimate a linear regression with price and during and off festival
price_off_during <- lm(price~ dataset, data = combined_price)
summary(price_off_during)

# estimate a linear regression with price and neighbourhood group, number of reviews, minimum nights and room type during the festival 
# the base line are entire home/apt and neighbourhood group Ciutat Vella 
everything_during_festival <- lm(price ~ number_of_reviews + minimum_nights + room_type +  neighbourhood_group, data = during_festival)
summary(everything_during_festival)

# estimate the linear regression with price and minimum nights for off and during festival
# (minimum nights is the one usefull variable both of the datasets have in common)
minimum_nights_off_festival <- lm(price ~ minimum_nights, data = off_festival)
summary(minimum_nights_off_festival)

minimum_nights_during_festival <- lm(price ~ minimum_nights, data = during_festival)
summary(minimum_nights_during_festival)

save(mean_price_during,mean_price_off,price_off_during,summary_df_during_off,everything_during_festival,minimum_nights_off_festival,minimum_nights_during_festival,file="../../gen/output/model_results.RData")




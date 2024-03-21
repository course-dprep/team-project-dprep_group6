options(repos = "https://github.com/course-dprep/team-project-dprep_group6")

# Install and load necessary packages
install.packages(c("dplyr", "readr", "data.table", "tidyverse"))
library(dplyr)
library(readr)
library(data.table)
library(tidyverse)
install.packages("geosphere")

calendar <- fread('calendar.csv.gz')
listings <- read_csv('listings.csv')

#calendar[, date_fest := date=="2023-06-04" || date=="2023-06-03" || date=="2023-06-02" || date=="2023-06-01" || date=="2023-05-30" || date=="2023-05-29"]
calendar[, date_fest := date %in% c("2024-06-02", "2024-06-01", "2024-05-31", "2024-05-30", "2024-05-29")]
fest_cal = calendar[calendar$date %in% c("2024-06-02", "2024-06-01", "2024-05-31", "2024-05-30", "2024-05-29")]


#Merge listings and calendar
listings$id <- as.integer(listings$id)
listings_calendar<- fest_cal %>% left_join(listings, by=join_by(listing_id==id))

#PARC DEL FORUM LOCATION
# Latitude: 41° 24' 23.99" N --> 41.40666389
# Longitude: 2° 13' 8.52" E --> 2.21903333

coord <- cbind("longitude" = listings_calendar$longitude,
               "latitude" = listings_calendar$latitude)



str(coord)    # like data above, a matrix, not a data.frame
#>  num [1:57, 1:2] -2.14 -2.09 -2.12 -2.14 -2.11 ...
#>  - attr(*, "dimnames")=List of 2
#>   ..$ : NULL
#>   ..$ : chr [1:2] "longitude" "latitude"

# make a data.frame to hold both numeric and logical values
library(geosphere)
coord_df <- data.frame(coord = coord,
                       within_5km = geosphere::distHaversine(
                         coord,
                         c(2.21903333, 41.40666389)
                       ) / 1000 < 5, listings_calendar$listing_id)    # convert m to km, check < 5
str(coord_df)
#> 'data.frame':    57 obs. of  3 variables:
#>  $ longitude : num  -2.14 -2.09 -2.12 -2.14 -2.11 ...
#>  $ latitude  : num  57.2 57.2 57.1 57.1 57.1 ...
#>  $ within_5km: logi  TRUE TRUE TRUE TRUE TRUE TRUE ...

table(coord_df$within_5km)

#>
#> FALSE  TRUE
#>    13    44

# filter by the < 5km
close_to_the_festival <- coord_df %>% filter(within_5km == TRUE)

# merge close_to_the_festival with listings_calendar - information during the festival
## data set of the festival
during_festival <- left_join(close_to_the_festival, listings_calendar, by = join_by(listings_calendar.listing_id==listing_id)) 

# remove the dollar signs in front of the prices and convert the variable to a numeric
during_festival$price.x <- as.numeric(gsub("\\$", "", during_festival$price.x))


## create the data sets of 2 weeks before the festival
calendar[, date_fest := date %in% c("xxxx")]
weeks_prior <- calendar %>% filter (date >= as.Date("2024-05-15") & date <= as.Date("2024-05-28"))
## create the data set 2 weeks after the festival
weeks_after <- calendar %>% filter (date >= as.Date("2024-06-03") & date <= as.Date("2024-06-17"))

# Merge both data sets to have the comparison data
off_festival <- union(weeks_prior,weeks_after)

# remove the dollar signs in front of the prices and convert the variable to a numeric
off_festival$price <- as.numeric(gsub("\\$", "", off_festival$price))

# create a dataset with the prices from off and during festival for bothe price.x and price.y
during_festival_price.x <- rename(during_festival, price = price.x)

combined_price.x <- bind_rows(
  mutate(during_festival_price.x, dataset = "during_festival"),
  mutate(off_festival, dataset = "off_festival")
) %>%
  select(price, dataset)

during_festival_price.y <- rename(during_festival, price = price.y)

combined_price.y <- bind_rows(
  mutate(during_festival_price.y, dataset = "during_festival"),
  mutate(off_festival, dataset = "off_festival")
) %>%
  select(price, dataset)

# save the output
write_csv(during_festival, "during_festival_data_cleaned.csv")
write_csv(off_festival, "off_festival_data_cleaned.csv")
write_csv(combined_price.x, "combined_price.x.csv")
write_csv(combined_price.y, "combined_price.y.csv")

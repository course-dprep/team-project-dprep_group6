# Install and load necessary packages
install.packages(c("dplyr", "readr", "data.table", "tidyverse"))
library(dplyr)
library(readr)
library(data.table)
library(tidyverse)
install.packages('R.utils')
library(R.utils)
install.packages("geosphere")

# Download listings data
download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/visualisations/listings.csv', 'listings.csv')
# Read listings data into R
listings <- read_csv('listings.csv')

# Download calendar data (note: it's a gzipped file, so you need to unzip it)
download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/data/calendar.csv.gz', 'calendar.csv.gz')
# Unzip and read calendar data into R
calendar <- fread('calendar.csv.gz')

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

## create the data sets of 2 weeks before the festival
calendar[, date_fest := date %in% c("xxxx")]
weeks_prior <- calendar %>% filter (date >= as.Date("2024-05-15") & date <= as.Date("2024-05-28"))
## create the data set 2 weeks after the festival
weeks_after <- calendar %>% filter (date >= as.Date("2024-06-03") & date <= as.Date("2024-06-17"))

# Merge both data sets to have the comparisson data
off_festival <- union(weeks_prior,weeks_after)


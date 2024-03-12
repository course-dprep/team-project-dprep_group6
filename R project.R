#Install Packages
install.packages('dplyr')
library(dplyr)
install.packages("readr")
library(readr)
listings=read_csv("listings.csv")
library(data.table)
library(tidyverse)
  
#upload the files 
listings = download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/visualisations/listings.csv', 'listings.csv')
calendar = download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/data/calendar.csv.gz', 'calender.csv')
calendar=read_csv("calendar.csv")
setDT(calendar)
listings<- read_csv("listings.csv")
setDT(listings)
  
#calendar[, date_fest := date=="2023-06-04" || date=="2023-06-03" || date=="2023-06-02" || date=="2023-06-01" || date=="2023-05-30" || date=="2023-05-29"]
calendar[, date_fest := date %in% c("2024-06-02", "2024-06-01", "2024-05-31", "2024-05-30", "2024-05-29")]
fest_cal = calendar[calendar$date %in% c("2024-06-02", "2024-06-01", "2024-05-31", "2024-05-30", "2024-05-29")]

 
#Merge listings and calendar

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
coord_df <- data.frame(coord,
                       within_5km = geosphere::distHaversine(
                         coord,
                         c(2.21903333, 41.40666389)
                       ) / 1000 < 5)    # convert m to km, check < 5
str(coord_df)
#> 'data.frame':    57 obs. of  3 variables:
#>  $ longitude : num  -2.14 -2.09 -2.12 -2.14 -2.11 ...
#>  $ latitude  : num  57.2 57.2 57.1 57.1 57.1 ...
#>  $ within_5km: logi  TRUE TRUE TRUE TRUE TRUE TRUE ...

table(coord_df$within_5km)
#>
#> FALSE  TRUE
#>    13    44



#group
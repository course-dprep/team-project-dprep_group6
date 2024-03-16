#Install Packages
install.packages('dplyr')
library(dplyr)
install.packages("readr")
library(readr)
listings=read_csv("listings.csv")
library(data.table)
library(tidyverse)

listings = download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/visualisations/listings.csv', 'listings.csv')
calendar = download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/data/calendar.csv.gz', 'calender.csv')

#upload the files
calendar=read_csv("calendar.csv")
setDT(calendar)
listings<- read_csv("listings.csv")
setDT(listings)



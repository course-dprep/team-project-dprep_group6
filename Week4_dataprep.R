#Install Packages
install.packages('dplyr')
library(dplyr)
install.packages("readr")
library(readr)
listings=read_csv("listings.csv")
library(data.table)
library(tidyverse)

#upload the files
calendar=read_csv("calendar.csv")
setDT(calendar)
listings<- read_csv("listings.csv")
setDT(listings)


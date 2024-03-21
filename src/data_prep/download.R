options(repos = "https://github.com/course-dprep/team-project-dprep_group6")
# load packages
install.packages("R.utils")
library(R.utils)
library(readr)
library(data.table)

# Download listings data
download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/visualisations/listings.csv', 'listings.csv')
# Read listings data into R
listings <- read_csv('listings.csv')

# Download calendar data (note: it's a gzipped file, so you need to unzip it)
download.file('http://data.insideairbnb.com/spain/catalonia/barcelona/2023-12-13/data/calendar.csv.gz', 'calendar.csv.gz')
# Unzip and read calendar data into R
calendar <- fread('calendar.csv.gz')
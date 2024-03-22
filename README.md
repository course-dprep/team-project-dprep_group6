# What is the impact of Summer Festivals on Airbnb Listings

![Image](summerfestivals.jpg)

## Motivation
Summer festivals offer a fun and engaging experience that attracts more people every year, from all over the world. Factors like artist line up, type of activities or the city where the festival is located contribute to people traveling for these events. 
Our research has the goal of understanding how Airbnb prices fluctuate during festival season, since this information is crucial for both travelers and hosts. For travelers, such information can aid in budget planning and accommodation selection during festival seasons, potentially optimizing their overall experience. Additionally, for hosts, these insights can inform between strategic pricing decisions, maximizing revenue generation. 
For this research we will analyze the impact of a popular festival in Barcelona, “Primavera Sound” on the Airbnb apartments availability and prices.

**"Does the presence of a Summer Music Festival influence the prices of Airbnb listings in the respective city?"**

**"Is it possible to create a model that helps Airbnb hosts to define the pricings of their listings?"**

## Method and Results
The data was collected through the Inside Airbnb website (http://insideairbnb.com/get-the-data), for the city of Barcelona. The data was uploaded into RStudio, namely the CSV files of the listings and calendar.
Regression Analysis is the method used in this research, since it is a powerful tool to examine the relationship between the festival season (independent variable) and the Airbnb Listing prices (dependent variable). 

The influences on the price during the festival season was researched with the help of a linear regression, which revealed that the price is positively influenced by minimm nights and number of reviews. It was also shown that there was a significant price difference between the different types of room and the neighbourhood it was located in. Furthermore, the difference between the prices during the festival and normally was researched with a separate regression, which was shown to be approximately 13.23 euros higher during Primavera Sound compared to normally. 

### Variables

| Variables | Description |
|----------|----------|
| City   | City of the festival   |
| Dates    | The dates during the festival - 29 May to 02 June   |
| Price    | Listing prices   |
| Capacity    | Number of tenants   |
| Distance to the festival    | Distance in km from the apartment to the festival   |
| host_id    | The id number of the host   |
| Neighbourhood Group    | The neighbourhood group that the listing is located  |
| Room Type    | Whether the listing is a Hotel room, Private room, Shared room or Entire home/apt  |
| Minimum Nights    | The minimum amounts of nights the listing has to be rented  |
| Number of reviews    | The number of reviews the host currently has  |
| Latitude    | Latitude coordinate of the listing   |
| Longitude    | Longitude coordinate of the listing  |



## Repository Overview

###**src:** Includes source codes for data preparation and analysis
###**data:** Raw data
###**gen:** Analysis results, figures, and temporary files

## Running instructions
xxx

## More resources
xxx

## About
This repository is made in the scope of the Data Preparation and Workflow Management class led by Hannes Datta at Tilburg School of Economics and Management. It's part of the Marketing Analytics Master's program.

## Authors
Catarina Luís Ferreira

Zeynep Yardimci Karaca

Rebecca Keijzer 

Joachiem Swart

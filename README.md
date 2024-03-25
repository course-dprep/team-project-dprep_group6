# What is the impact of Summer Festivals on Airbnb Listings

![Image](https://support.musicgateway.com/wp-content/uploads/2023/04/rawImage-scaled.jpg)

## Motivation
Summer festivals offer a fun and engaging experience that attracts more people every year, from all over the world. Factors like artist line up, type of activities or the city where the festival is located contribute to people traveling for these events. 
Our research has the goal of understanding how Airbnb prices fluctuate during festival season, since this information is crucial for both travelers and hosts. For travelers, such information can aid in budget planning and accommodation selection during festival seasons, potentially optimizing their overall experience. Additionally, for hosts, these insights can inform between strategic pricing decisions, maximizing revenue generation. 
For this research we will analyze the impact of a popular festival in Barcelona, “Primavera Sound” on the Airbnb apartments availability and prices.

**"Does the presence of a Summer Music Festival influence the prices of Airbnb listings in the respective city?"**

**"Is it possible to create a model that helps Airbnb hosts to define the pricings of their listings?"**

## Method
The data was collected through the Inside Airbnb website (http://insideairbnb.com/get-the-data), for the city of Barcelona. The data of listings and calendar was uploaded into RStudio, using the download.file() function.
Using RMarkdown, it was possible to create some get relevant insights and statistics on the raw data, and further decide how the dataset was going to be cleaned and prepared for the analysis.
To clean and prepare the data for analysis the following steps were taken:
1. **Creation of a subset of calendar**, called ```fest_cal```, that consists of the calendar dataset during the days of the festival (29/05/2024 to 02/06/2024)
Regression Analysis is the method used in this research, since it is a powerful tool to examine the relationship between the festival season (independent variable) and the Airbnb Listing prices (dependent variable).
2. **Merge of the Listings and Calendar (festival) subsets**.
3. **Filter the new subset by the listings located within 5 kms of the festival**, this was done by using the ```library(geosphere)``` and using the respective coordinates. This created the main dataset of analysis ```during_festival```.
4. **Create the same subset for the comparison dataset**, in order to understand the price of the listings within 5 km of the festival, a subset containing the listings 2 weeks prior and after the festival was created.
5. **Save the outputs to a csv file**, now the data is cleaned and prepared for the analysis.
 

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

### Results

The influences on the price during the festival season was researched with the help of a linear regression, which revealed that the price is positively influenced by minimum nights and number of reviews, which was supported by low p-values. There are also significant price differences observed across the different neighborhoods and room types. While some dummy variables lack significance, indicating inconclusive interpretations, the overall analysis highlights the significant influence of minimum nights, number of reviews, and neighborhood characteristics on Airbnb listing prices during the festival. Furthermore, the difference between the prices during the festival and normally was researched with a separate linear regression, which was shown to be approximately 0.61 euros lower during Primavera Sound compared to the prices normally. This variable was also significant, which means that it has a notable impact on the price of the listings.


## Repository Overview

```{r}
|-- data
|-- gen
   |-- output
        |-- Deployment_data.RMD
        |-- Deployment_data.pdf
|-- src
   |-- analysis
        |-- regression_analysis.R
   |-- data_prep
        |-- clean.R
        |-- download.R
        |-- makefile
|-- .gitignore
|-- README.md
|-- makefile

```
## Running instructions

### Required software
For this research and to run this workflow, the following software needs to be ready to use:

+ **Git**: this allows to access the repository locally. For installation and more information check the [tutorial](https://tilburgsciencehub.com/topics/automation/version-control/start-git/git/) at [Tilburg Science Hub](https://tilburgsciencehub.com).
   
+ **R Studio**: the code that runs the project was created using RStudio. For installation and more information check the [tutorial](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/) at [Tilburg Science Hub](https://tilburgsciencehub.com).
   
+ **Make**: allows the workflow to run in a transparent and reproducible way. For installation and more information check the [tutorial](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make/) at [Tilburg Science Hub](https://tilburgsciencehub.com).

**Additionally**, the following packages were used in this project, so ensure that you have them installed. Please use install.packages("NAME_OF_PACKAGE") to install them, or use library("NAME_OF_PACKAGE") to load the packages:

```{r}
library(R.utils)
library(readr)
library(data.table)
library(dplyr)
library(readr)
library(data.table)
library(tidyverse)
library("geosphere")
```
### Getting Started

1. **Install Necessary Programs:** Check running instructions.
2. **Fork this Repository:** Replicate this repository to your personal GitHub account.
Instructions

### Running the Code
#### Executing the makefile
Executing the makefile is straighforward. This file will enable each code source to run in the right order, ultimately leading to the analysis results. After forking this repository, the following steps should be taken:
1. **Clone the repository:** Navigate to the desired directory where you want to clone the repository, open Git or the terminal/command prompt. and type:
```{r}
git clone https://github.com/{your username}/team-project-dprep_group6.git
```
2. **Set Working Directory:** Change your working directory to the cloned folder using:
```{r}
cd team-project-dprep_group6
```
3. **Execute the make command:** Type make and all the source code will be executed.
4. **See the Results:** In your local repository (in your computer), you can find the generated output with the regression results at:
```{r}
/team-project-dprep_group6/gen/output/Deployment_data.pdf
```
#### Running each source code file
You can also run the project in a "manual" way, by executing the following files in the specified order:
1. download.R
2. clean.R
3. regression_analysis.R

## About
This repository is made in the scope of the Data Preparation and Workflow Management class led by Hannes Datta at Tilburg School of Economics and Management. It's part of the Marketing Analytics Master's program.

## Authors
| Authors | GitHub username |
|----------|----------|
| Catarina Luís Ferreira   | catarinalsferreira   |
| Zeynep Yardimci Karaca    | zeynepyardimcikaraca   |
| Rebecca Keijzer| RebeccaKeijzer   |
| Joachiem Swart    | JCHswart |











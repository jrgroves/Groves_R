#This script is used to input, clean and prepare our UFO sighting data for use in analysis
#
#By: Jeremy Groves
#Date: November 5, 2025

rm(list = ls())

library(tidyverse)
library(sf)
library(tidycensus)

#Getting the Data####

  ufo <- read.csv("./Build/Input/scrubbed.csv", header = TRUE, as.is = TRUE)
  bridge <- read.csv("./Data/GEOID Bridge.csv", header = TRUE, as.is = TRUE)
  var <- c("B01002_001", "B01003_001")

for(i in seq(2009,2011,1)) {  
  acs <- get_acs(geography = "state",
                 variables = var,
                 year = i,
                 geometry = TRUE) %>%
    mutate(year = i)
  
  
  ifelse(i == 2009,
         ACS <- acs,
         ACS <- bind_rows(ACS, acs))
}

#Cleaning the Data
  
  working <- ufo %>%
    select(datetime, city, state, country, latitude, longitude) %>%
    filter(country == "us") %>%
    mutate(year = str_split_i(str_split_i(datetime, " ", 1), "/", 3)) %>%
    mutate(year = as.numeric(year)) %>%
    filter(year > 2008) |>
    count(year, state) |>
    rename("sightings" = "n")

  census <- ACS %>%
    select(GEOID, variable, year, estimate, geometry) %>%
    mutate(variable = case_when(variable == "B01002_001" ~ "median.age",
                                variable == "B01003_001" ~ "population",
                                TRUE ~ variable))  %>%
    pivot_wider(id_cols = c(GEOID, year, geometry), names_from = variable, values_from = estimate) %>%
    mutate(population = population / 100000)
  
  bridge <- bridge %>%
    mutate(GEOID = str_pad(as.character(GEOID),2, side = "left", pad = "0" ))
  
  core <- census %>%
    left_join(., bridge, by = "GEOID") %>%
    left_join(., working, by = c("state", "year")) %>%
    mutate(sight_per = sightings / population) %>%
    relocate(geometry, .after = sight_per)
  
  
  
  
  
  
  
  
  
  
  
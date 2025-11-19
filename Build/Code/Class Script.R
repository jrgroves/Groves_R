#This script is used to input, clean and prepare our UFO sighting data for use in analysis
#
#By: Jeremy Groves
#Date: November 5, 2025

rm(list = ls())

library(tidycensus)
library(sf)
library(tidycensus)

#Getting the Data####

ufo <- read.csv("./Build/Input/scrubbed.csv", header = TRUE, as.is = TRUE)

var <- c("B01002_001", "B01003_001")
states <- c(17, 18, 21)

acs <- get_acs(geography = "state",
               variables = var,
               state = states,
               year = 2010,
               geometry = TRUE)

#Cleaning the Data

working <- ufo %>%
  select(datetime, city, state, country, latitude, longitude) %>%
  filter(country == "us") %>%
  mutate(year = str_split_i(str_split_i(datetime, " ", 1), "/", 3)) %>%
  filter(state == "IN" | state == "IL" | state == "KY",
         year == 2010) %>%
  count(state)

census <- acs %>%
  select(!c(NAME, moe)) %>%
  mutate(variable = case_when(variable == "B01002_001" ~ "median.age",
                              variable == "B01003_001" ~ "population",
                              TRUE ~ variable),
         state = case_when(GEOID == 17 ~ "IL",
                           GEOID == 18 ~ "IN",
                           TRUE ~ "KY")) %>%
  pivot_wider(id_cols = c(GEOID, state, geometry), names_from = variable, values_from = estimate) %>%
  mutate(population = population / 100000)

core <- census %>%
  left_join(., working, by = "state")%>%
  mutate(sight_per = n / population)%>%
  relocate(geometry, .after = sight_per)



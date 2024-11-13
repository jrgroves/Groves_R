#This script is used to input, clearn and prepare our UFO sighting data for use in analysis
#
#By: Jeremy Groves
#Date: November 5, 2024

rm(list = ls())


library(tidycensus)
library(tidyverse)
library(gt)
library(gtsummary)
library(sf)


#Loading Data####
  ufo <- read.csv(file = "./Data/scrubbed.csv", header = TRUE, as.is = TRUE, sep = ",")
  
  cen.stat <- get_acs(geography = "state", 
                      variables = "B01003_001E", 
                      year = 2020,
                      survey = "acs5",
                      geometry = TRUE)
  

  st_abb <- read.csv(file = "./Data/st_abb.csv")
  #https://www.bls.gov/respondents/mwr/electronic-data-interchange/appendix-d-usps-state-abbreviations-and-fips-codes.htm
  
  
#Cleaning Data####

  ufo.us <- ufo %>%
    filter(country == "us") %>%
    select(-comments) %>%
    mutate(date = as.Date(str_split_i(datetime," ", 1), "%m/%d/%Y"),
           year = year(date),
           decade = year - year %% 10) %>%
    filter(decade > 1959) 
  
  cen.map <- cen.stat %>%
    filter(GEOID != "02",
           GEOID != "15",
           GEOID != "72") %>%
    select(-c(variable, estimate, moe)) %>%
    arrange(GEOID)
  
#Aggregating and Merging
  
  ufo.st <- ufo.us %>%
    count(state, decade) %>%
    mutate(Abbr = toupper(state)) %>%
    full_join(., st_abb, by = "Abbr") %>%
    filter(!is.na(n)) %>%
    rename("GEOID" = "Code") %>%
    mutate(GEOID = str_pad(as.character(GEOID), width = 2, side = "left", pad="0"))
  
  ufo.map <- cen.map %>%
    left_join(., ufo.st, by="GEOID" ) %>%
    mutate(decade = as.factor(decade),
           state = as.factor(state),
           ln_n = log(n))
  
  
  ggplot(ufo.map) +
    geom_boxplot(aes(x = decade, y = ln_n), color = "navy")  + 
    theme_bw()  + 
    labs(title = "Box Plot of UFO sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com",
         x = "Decade",
         y = "Natural Log of Annual Sightings")
  
  ggplot(subset(ufo.map, decade == 1990)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") 
  
  
  ggplot(subset(ufo.map, decade == 1990)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()) 
  
  
  ggplot(subset(ufo.map, decade == 1990)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()) +
    scale_fill_gradient2(low = "lightblue", high = "blue", na.value = NA, 
                         name = "LN(Sightings)",
                         limits = c(0, 9)) 
  ggplot(ufo.map) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()) +
    scale_fill_gradient2(low = "lightblue", high = "blue", na.value = "black", 
                         name = "LN(Sightings)",
                         limits = c(0, 9)) +
    facet_wrap( ~ decade)
              
  
  theme_gtsummary_compact()
    
  c <- ufo.map %>% 
      st_drop_geometry() %>%
      select(n, decade, State) %>%
    as_tibble() %>%
    rowwise() %>%
    slice(rep(1, n)) %>%
    select(-n) %>%
    tbl_summary(
        by = decade,
        statistic = list(all_categorical() ~ "{n}"), 
        label = NULL,
        missing = "no" )   %>%
      modify_header(label ~ "**State**") %>%
      remove_row_type(State, type = "header") %>%
    as_gt() %>%
    tab_header(title = md("**Table 1** Sightings by Decade for each State")) %>%
    gtsave("Table 1.png", path = "./Analysis/Output/")
  
  d<-ufo.map %>%
    st_drop_geometry() %>%
    select(decade, n) %>%
    tbl_summary(
      by = decade,
      type = all_continuous() ~ "continuous2",
      statistic = all_continuous() ~ c("{mean}",
                                       "{sum}",
                                       "{N_obs}"),
    ) %>%
    add_stat_label(label = n ~ c("Mean", "Total", "States")) %>%
    modify_header(all_stat_cols() ~ "**{level}**",
                  label ~ "")  %>%
    remove_row_type(n, type = "header") %>%
  as_gt() %>%
    tab_header(title = md("**Table 2** Summary of Sightings")) %>%
    gtsave("Table 2.png", path = "./Analysis/Output/")
  


                       
    

#This script is used to input, clean and prepare our UFO sighting data for use in analysis
#
#By: Jeremy Groves
#Date: November 5, 2024
#Updated: November 20, 2024

rm(list = ls())

library(tidycensus)
library(tidyverse)
library(sf)
library(stargazer)
library(sf)

#Loading Data####
  ufo <- read.csv(file = "./Data/scrubbed.csv", header = TRUE, as.is = TRUE, sep = ",")
 
    #from https://mattherman.info/blog/tidycensus-mult-year/
  years <- lst(2010, 2011, 2012)
  
  cen.stat <- map_dfr(   
    years,
    ~ get_acs(
      geography = "state",
      table = "B15002",
      year = .x,
      survey = "acs5",
      geometry = TRUE
    ),
    .id = "year"  
  ) %>%
    select(-moe) %>% 
    arrange(variable, NAME)
  
  st_abb <- read.csv(file = "./Data/st_abb.csv")
  #https://www.bls.gov/respondents/mwr/electronic-data-interchange/appendix-d-usps-state-abbreviations-and-fips-codes.htm
  
  
#Cleaning Data####

  ufo.us <- ufo %>%
    filter(country == "us") %>%
    select(-comments) %>%
    mutate(date = as.Date(str_split_i(datetime," ", 1), "%m/%d/%Y"),
           year = year(date)) %>%
    filter(year %in% years)

  cen.map <- cen.stat %>%
    filter(year == "2011",
           GEOID != "02",
           GEOID != "15",
           GEOID != "72",
           variable == "B15002_001") %>%
    select(-c(variable, estimate)) %>%
    arrange(GEOID)
  
  cen.stats <- cen.stat %>%
    st_drop_geometry() %>%
    mutate(variable = str_remove(variable, "15002_0")) %>%
    pivot_wider(id_cols = c("year", "GEOID", "NAME"), names_from = "variable",
                values_from = "estimate") %>%
    mutate(nohs = (B07+B08+B09+B10+B24+B25+B26+B27) / B01,
           hson = (B11+B28) / B01,
           smcol = (B12+B13+B29+B30) / B01,
           deg = (B14+B15+B31+B32) / B01,
           addeg = (B16+B17+B18+B33+B34+B35) / B01,
           tpop = log(B01),
           year = as.numeric(year)) %>%
    select(year, GEOID, nohs:tpop)
   
#Aggregating and Merging
  
  ufo.st <- ufo.us %>%
    count(state, year) %>%
    mutate(Abbr = toupper(state),
           year = as.numeric(year)) %>%
    full_join(., st_abb, by = "Abbr") %>%
    filter(!is.na(n)) %>%
    rename("GEOID" = "Code") %>%
    mutate(GEOID = str_pad(as.character(GEOID), width = 2, side = "left", pad="0"))
  
  ufo.core <- cen.stats %>%
    left_join(., ufo.st, by=c("GEOID", "year")) %>%
    mutate(year = as.factor(year),
           state = as.factor(state),
           ln_n = log(n)) %>%
    filter(!is.na(state))
  
  ufo.map <- cen.map %>%
    select(-year) %>%
    left_join(., ufo.core, by = "GEOID")
  

#Visualizations and Tables##### 

  ggplot(ufo.map) +
    geom_boxplot(aes(x = year, y = ln_n), color = "navy")  + 
    theme_bw()  + 
    labs(title = "Box Plot of UFO sightings by Year in the U.S.",
         caption = "Data obtained from Kaggle.com",
         x = "Year",
         y = "Natural Log of Annual Sightings")
  
  ggplot(subset(ufo.map, year == 2010)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings in the U.S.",
         caption = "Data obtained from Kaggle.com") 
  
  
  ggplot(subset(ufo.map, year == 2010)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()) 
 
  ggplot(ufo.map) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by year in the U.S.",
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
    facet_wrap( ~ year)
 
  stargazer(as.data.frame(ufo.core), 
            type = "latex", 
            out = "./Analysis/Output/Table1.txt")
  
  
  stargazer(as.data.frame(ufo.core), 
            type = "html", 
            out = "./Analysis/Output/Table1.html",
            title="Table 1: Summary Statistics",
            covariate.labels = c("No Highschool Degree", "Highschool Diploma","Some College",
                                 "Undergraduate Degree","Advanced Degree","LN of Total Population",
                                 "Sightings", "LN of Sightings"))
  
  
 
#Regression Analysis####
 
 mod1 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop, data = ufo.core)
 mod2 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop + factor(year), data = ufo.core)
 mod3 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop + factor(year) + factor(State), data = ufo.core)
  
c<- stargazer::stargazer(mod1, mod2, mod3,omit = ".State.",
                         type = "html",
                         out = "./Analysis/Output/Table2.html",
                         add.lines=list(c("State F.E.", "NO", "NO", "YES")),
                         dep.var.labels = "LN(Sightings)",
                         covariate.labels=c("No Highschool Degree", "Highschool Diploma","Some College",
                                            "Undergraduate Degree","Total Population", "2011 F.E.", "2012 F.E."))

library(jtools)
coef <- c("No Highschool Degree" = "nohs", "Highschool Diploma" = "hson","Some College" = "smcol",
          "Undergraduate Degree" = "deg","LN of Total Population" = "tpop", 
          "Fixed Effect: 2011" = "factor(year)2011",
          "Fixed Effect: 2012" = "factor(year)2012")

plot_summs(mod1, mod2, mod3, coefs = coef)

export_summs(mod1, mod2, mod3, coefs = coef,
             to.file = "docx", file.name = "./Analysis/Output/Reg.docx")

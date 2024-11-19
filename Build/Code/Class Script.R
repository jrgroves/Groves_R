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

dec <- load_variables(2000, "sf3")

#Loading Data####
  ufo <- read.csv(file = "./Data/scrubbed.csv", header = TRUE, as.is = TRUE, sep = ",")
 
  #from https://mattherman.info/blog/tidycensus-mult-year/
  years <- lst(2010, 2005)
  
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
           year = year(date),
           decade = year - year %% 10) %>%
    filter(decade > 1959)
  
      
  cen.map <- cen.stat %>%
    filter(year == "2020",
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
           tpop = B01,
           decade = as.character(year)) %>%
    select(decade, GEOID, nohs:tpop)
   
#Aggregating and Merging
  
  ufo.st <- ufo.us %>%
    count(state, decade) %>%
    mutate(Abbr = toupper(state),
           decade = as.character(decade)) %>%
    full_join(., st_abb, by = "Abbr") %>%
    filter(!is.na(n)) %>%
    rename("GEOID" = "Code") %>%
    mutate(GEOID = str_pad(as.character(GEOID), width = 2, side = "left", pad="0"))
  
  ufo.map <- cen.stats %>%
    left_join(., ufo.st, by=c("GEOID", "decade")) %>%
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
              
<<<<<<< HEAD
  theme_gtsummary_compact()

=======
  
  theme_gtsummary_compact()
>>>>>>> 2012ea911e7a0e5dfb4c001865e33f1e39c00d8f
    
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
  

<<<<<<< HEAD
#Regressions
  library(ipumsr)
  
  data_ext<- define_extract_nhgis(
    description = "ECON 691",
    time_series_tables =  list(
      tst_spec("A00", "state"),
      tst_spec("B57", "state"),
    )
  )
  
  ts<-submit_extract(data_ext)
  wait_for_extract(ts)
  filepath <- download_extract(ts)
  
  dat <- read_nhgis(filepath)
=======

>>>>>>> 2012ea911e7a0e5dfb4c001865e33f1e39c00d8f
                       
  dat2 <- dat %>%
    select(STATEFP, ends_with(c("1970", "1980", "1990", "2000", "2010", "105", "2020", "205"))) %>%
    filter(!is.na(STATEFP)) %>%
    pivot_longer(!STATEFP, names_to = "series", values_to = "estimate") %>%
    mutate(series = str_replace(series, "105", "2010"),
           series = str_replace(series, "205", "2020"),
           year = substr(series, 6, nchar(series)),
           series = substr(series, 1, 5)) %>%
    distinct(STATEFP, series, year, .keep_all = TRUE) %>%
    filter(!is.na(estimate)) %>%
    pivot_wider(id_cols = c(STATEFP, year), names_from = series, values_from = estimate) %>%
    mutate(und18 = rowSums(across(B57AA:B57AD)) / A00AA,
           over65 = rowSums(across(B57AP:B57AR)) / A00AA) %>%
    select(STATEFP, year, A00AA, und18:over65) %>%
    rename("TOTPOP" = "A00AA",
           "GEOID" = "STATEFP")

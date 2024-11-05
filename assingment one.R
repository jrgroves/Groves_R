#Assignment One

rm(list=ls())

library(tidyverse)
library(tidycensus)
library(ipumsr)

#Getting data from IPUMS API

    #set_ipums_api_key("paste-your-key-here", save = TRUE) #Sets your personal key and saves it
    
    tst <- get_metadata_nhgis("time_series_tables") #This gives you a list of the time series tables that you can get
    
    #data_names <- c("A00","A57","B57","B18","CL6","B69") #These are the tables we are using

    data_ext<- define_extract_nhgis(
                  description = "ECON 691",
                  time_series_tables =  list(
                      tst_spec("A00", "state"),
                      tst_spec("A57", "state"),
                      tst_spec("B57", "state"),
                      tst_spec("B18", "state"),
                      tst_spec("CL6", "state"),
                      tst_spec("BX3", "state")
                  )
                )
    
    ts<-submit_extract(data_ext)
    wait_for_extract(ts)
    filepath <- download_extract(ts)
    
    dat <- read_nhgis(filepath)

#Basic Clan of data
    
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
      select(-B18AE)  %>%
      mutate(und18 = rowSums(across(B57AA:B57AD)) / A00AA,
             over65 = rowSums(across(B57AP:B57AR)) / A00AA,
             white = B18AA / A00AA,
             black = B18AB / A00AA,
             asian = B18AD / A00AA,
             other = 1 - white - black - asian, 
             lessHS = (BX3AA + BX3AB + BX3AC + BX3AG + BX3AH + BX3AI) / A00AA,
             HSCOL = (BX3AD + BX3AJ) / A00AA,
             UNGRD = (BX3AE + BX3AK) / A00AA,
             ADVDG = (BX3AF + BX3AL) / A00AA,
             POV = CL6AA / A00AA) %>%
      select(STATEFP, year, A00AA, und18:POV) %>%
      rename("TOTPOP" = "A00AA",
             "GEOID" = "STATEFP")
    
#Obtain Census Map Data
    
    cen.stat <- get_acs(geography = "state", 
                        survey = "acs5",
                        variables = "B01003_001E", 
                        year = 2020,
                        geometry = TRUE)
    
    cen.map <- cen.stat %>%
      select(-c(variable, estimate, moe)) %>%
      filter(GEOID != "02",
             GEOID != "72",
             GEOID != "15") #This is still here because I am pulling all the states rather than a subset
    
#Join the data and Map it
    
    core <- cen.map %>%
      left_join(., dat2, by = "GEOID")   
    
    
    #Non-Race Variable
    
    ggplot(core) +
      geom_sf(aes(fill = und18)) +
      scale_fill_gradient2(low = "white", high = "blue", na.value = NA, 
                          name = "Under 18",
                          limits = c(0, .5)) +
      theme_bw()+
      theme(axis.ticks = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            legend.position = "bottom") +
      labs(title = "Percentage of Population Under the age of 18 Across the Decades") +
      facet_wrap(~ year)
    
    #Race Variable
    
    ggplot(core) +
      geom_sf(aes(fill = white)) +
      scale_fill_gradient2(low = "white", high = "blue", na.value = NA, 
                           name = "Population White",
                           limits = c(0, 1)) +
      theme_bw()+
      theme(axis.ticks = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            legend.position = "bottom") +
      labs(title = "Percentage of Population Identified as White Across the Decades") +
      facet_wrap(~ year)
    
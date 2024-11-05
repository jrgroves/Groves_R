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
                      tst_spec("B69", "state")
                  )
                )
    
    ts<-submit_extract(data_ext)
    wait_for_extract(ts)
    filepath <- download_extract(ts)
    
    dat <- read_nhgis(filepath)

#Basic Clan of data
    
    dat2 <- dat %>%
      select(STATEFP, ends_with(c("1970", "1980", "1990", "2000", "2010", "105"))) %>%
      filter(!is.na(STATEFP)) %>%
      pivot_longer(!STATEFP, names_to = "series", values_to = "estimate") %>%
      mutate(series = str_replace(series, "105", "2010"),
             year = substr(series, 6, nchar(series)),
             series = substr(series, 1, 5)) %>%
      distinct(STATEFP, series, year, .keep_all = TRUE) %>%
      filter(!is.na(estimate)) %>%
      pivot_wider(id_cols = c(STATEFP, year), names_from = series, values_from = estimate) %>%
      select(-B18AE)
    
    %>%
      mutate(und18 = rowSums(across(B57AA:B57AD)) / A00AA,
             over65 = rowSums(across(B57AP:B57AR)) / A00AA,
             white = B18AA / A00AA,
             black = B18AB / A00AA,
             asian = B18AD / A00AA,
             other = 1 - white - black - asian, 
             lessHS = (BW7AA + BW7AB) / A00AA,
             HSGED = BW7AC / A00AA,
             smCOL = BW7AD / A00AA,
             Deg = BW7AE / A00AA)
    
    
    
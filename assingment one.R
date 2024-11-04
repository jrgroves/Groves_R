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
    downloadable_extract<-wait_for_extract(ts)
    filepath <- download_extract(downloadable_extract)
    
    dat <- read_nhgis(filepath)

#Basic Clan of data
    
    dat2 <- dat %>%
      select(GISJOIN, STATEFP, ends_with(c("1970", "1980", "1990", "2000", "2010", "2020"))) %>%
      filter(!is.na(STATEFP))
    
---
title: Assignment One - ECON 691 - Groves
---

For this assignment you will obtain and clean data for your assigned decade from IPUMS via API and then merge this with Census Tiger Files using the Census API and create a Map showing the variation of one of the key variables that you create in this assignment. When you cloned this repository you should have acquired a script file called "Assignment_One.R" and a "README.md" file. Your grade will be based on the correct manipulation of the script file and the output produced by the *plot()* command that should appear at the end of your script. You will also be graded on the quality of the code that you write and for covering the basics (like saving your final data in the right place).

# Getting to know your decade
You have each been assigned a decade and so now you will need the demographic data for the 48 continental U.S. states for that decade. Since we are dealing with decades, we will utilize data from the U.S. Decennial Census and since some of you have decades prior to 2000, that rules out the use of the census API (*tidycensus*). An alternative data source for the U.S. Census and many other surveys, demographics, and GIS data is [IPUMS.org](). They have a collection of "projects" that deal with several different types and scopes of data and the project we will focus on is the NHGIS project for "National Historic Geographic Information Systems" project. Like the census, they too have an API and there is a package that allows us to (somewhat) easily interact with the API through `R` and you need to get that installed on your machine.

> 1. Install in whatever method you choose, the package *ipumsr*. It will be obvious if you do not, because nothing else will work.

## Using the *ipumsr* package

The use of the *ipumsr* package to access the API is not quickly picked up so I have added the code that you need to run in the script that you received with this assignment. Before you can do that, however, just like with the census API, you need to obtain a key and install that within your `R` environment. You will see a line near the top of the script for installing the key which is currently commented out. You need to obtain your key by first [registering for a free IMPUS.org account](https://uma.pop.umn.edu/ihgis/user/new). Once you are registered, you need to apply for an [API key](https://account.ipums.org/api_keys), and then copy and paste that key somewhere you can save it (in a text editor and then save it as a text file) and also in the appropriate place in the script. To install the key into your `R Studio` environment, run that single line of code from the script editor.

Next you will want to ensure you load the *ipumsr* and *tidyverse* packages into our working environment and then type the following code into the console of `R Studio`.

```R
 tst <- get_metadata_nhgis("time_series_tables")
```

This will create an object named **tst** which is a mixture of a dataframe with a list (available through *tidyverse*) that contains all of the time series datasets that are available from the NHGIS project. In the console, run the *head()* command on this object and you should see:

```R
  name  description                       geographic_integration sequence time_series      years    geog_levels
  <chr> <chr>                             <chr>                     <dbl> <list>           <list>   <list>     
1 A00   Total Population                  Nominal                    100. <tibble [1 × 3]> <tibble> <tibble>   
2 AV0   Total Population                  Nominal                    100. <tibble [1 × 3]> <tibble> <tibble>   
3 B78   Total Population                  Nominal                    100. <tibble [1 × 3]> <tibble> <tibble>   
4 CL8   Total Population                  Standardized to 2010       100. <tibble [1 × 3]> <tibble> <tibble>   
5 A57   Persons by Urban/Rural Status [4] Nominal                    101. <tibble [4 × 3]> <tibble> <tibble>   
6 A59   Persons by Urban/Rural Status [4] Nominal                    101. <tibble [4 × 3]> <tibble> <tibble>
```

Breaking this down, we see the time series name, which is what we will use to get it from IPUMS, a description, a couple of internal items, and then a set of lists that tell us the specific time series (or data) in each time series, the years for which data exists, and the levels of geography we can get. Also of importance for us is the row number on the left-side. 

We are interested in the total population for each state so clearly we want to start with the first object here. We will use the name "A00" to tell the API what series we want, but first we need to ensure it has the years we need. To see this, type the following command into the console: `tst$years[[1]]`. Since the years vector is a list, we use the "[[.]]" to navigate within a list and the input here is the row number. So this command is telling `R` to show us the first list in the vector of lists named "years" within the object **tst**. Since the output is truncated prior to getting to the years we are interested in, take the suggestion of `R Studio` and instead type: `print(n = 25, tst$years[[1]])' which will display the first 25 rows of this list. We see near the end we have the decades from 1970 on just as we needed`.

> 2. What is the code you would use to find the levels of geography for which population is available? Place this code in the script between line X and Y.

The last piece of information we need from this is to know what data (rows) are in each time series. To actually see how this works, type `print(n=25, tst$time_series[[5]])` and see what you get. We see from our output above that row five of the object **tst** is the "Persons by Urban/Rural Status" data and when we run the command we just typed we get:

```R
1 AA    Persons: Urban                                                     1
2 AB    Persons: Urban--Inside urbanized areas                             2
3 AC    Persons: Urban--Outside urbanized areas (in urban clusters)        3
4 AD    Persons: Rural                                                     4
```

This tells me that within this time series there are four sub-measures that measure (1) the number of persons living in an urban area, (2) number of persons inside the urban core, (3) number of persons in the suburbs, and (4) the number of persons in rural areas. More importantly, we see that the code "AA" will denote the first measure, "AB" the second, and so forth. You will will find this output for every variable we will be using in the "README.txt" file for this repository.
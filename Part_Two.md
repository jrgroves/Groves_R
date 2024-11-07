
# Getting Data

The core of any empirical research project is the data, and depending on your project and level of analysis, obtaining that data can be easy or hard. In microeconomics analysis, the easier the data is to obtain, the less ripe that avenue of research is likely to be. More often than not, the data you want is not going to be a simple point-and-click away. You'll need to find creative means to put the data together, so we'll look at various methods for obtaining data.

Additionally, it is more than likely that you will be bringing in some of the data from elsewhere, and so we need to learn how to read data into our `R environment` for analysis. Finally, we will likely need to join data from various sources to get the full dataset needed for a correct analysis.

Another important factor to keep in mind is the need for you or anyone else to be able to reproduce any project. In terms of obtaining, cleaning, and merging datasets, we should keep the data we bring into our analysis as raw as possible and do any manipulation and merging within `R` via a script. This not only preserves the original copy of the data but also ensures we have a written record, via the script, of what we did and how we got the data we eventually used.

## Delimited Files

The best way to store raw data is in an independent form such as a delimited file, also known as delimiter-separated value, which is a text version of a file with some special character, commonly a "tab" or a "comma" used to separate elements of an observation with each observation being on a single line. Data kept in propriety form will add a barrier to reproduction, especially if that program is no longer widely available whereas data in simple text of delineated form can always be read. The most common form of data is saved as a .csv file which is a text file where each "column" of data is separated by a comma. In this case you can simply use the *read.csv()* command to read the data into the global environment of `R`. As a project for our examples and assignments we will be utilizing data which tracts UFO sighting across the global from about 1910 which I obtained from the kaggle website[^1]. Using the command below will read the .csv file into the environment and saved to the object "ufo".

[^1]: https://www.kaggle.com/datasets/NUFORC/ufo-sightings?resource=download 

```R
ufo <- read.csv(file = "./Data/scrubbed.csv", header = TRUE, as.is = TRUE, sep = ",")
```

Before breaking down this command, there is one note we should make; there is an alternative version called *read.csv2()*. The difference is that the command above treats commas as separators and periods as decimals whereas the latter assumes that periods are the separators while commas are used as decimals. Now diving into the command we see first we list the location of the file and filename we want to read. Again we notice the use of the period to indicate the current working directory. Next we set the option "header" to TRUE to indicate that the first row of the data are column headers and thus should be used as the column names in the resulting dataframe. Next we tell `R` to read the file as it is formatted meaning that characters are read as character and numbers are read as numeric. Finally, we have the option "sep" which sets the separator for the delineated file. The default is the comma, however, we can also use other options such as the bar "|". Running this command creates the object **ufo** and assign the data from the file "scrubbed.csv".  

`R` is an object-based language and the most common form of an object is a vector. This is what we created with our first script we wrote when we created the object **A**. The thing about vectors, however, is that they must be constructed of a single type of data meaning that we can not mix numerical and character data within the same vector (unless we translate the numerical data to a character type). You either still have the A in your environment or you can replace it by opening the file "First.R" and then placing your cursor in the editor window on the line that assigns the object **A** and clicking the "Run" button at the top of the editor window. Once this is done, type `is(A)` into the console and you will see 

```R
> is(A)
[1] "character"           "vector"              "data.frameRowLabels" "SuperClassMethod"
```

The key information here is that this is a "character" type and that A is a vector. We can add to this vector using the code `A[2]<-"Goodbye"` and now if we type **A** into the console we see we have both "Hello world!" and "Goodbye". We have a vector with two pieces of data, both of which are characters, and we can access them using the brackets and numbers just like with matrix vectors. Now type `A[3] <- 50` and hit enter and you see see that "50" is not listed in the environment as part of the vector object **A**. Finally, type `A[3]/5` and see what happens; you should get an error message. This is because a vector can only be of one type of data and when we entered 50 into a vector that is already made up on character types, R automatically assumed we meant the character 50, not the number 50. 

Now type `B <- 50` and then type `B[1]`. You should get a read out in the console of 50 without quotation marks as quotations is a visual cue that the output is character not numeric. Now type `B[1]/5` and you should get 10. To see why, use the *is()* command to determine what object **B** is. You should see if it a numeric vector.

> What do you think will happen if you try to add the phrase "Over the Hill" to object B?

Typically, as is the case of our **ufo** object, we will need something with both numerical and character data along with other types and classes. To contain this, we need something else called a dataframe. Using the *is()* command we see that our object **ufo** is a dataframe made up of vectors. You can think of this as a matrix type element constructed of column vectors where each column vector contains data of a similar type. Another way to think of it is like an Excel spreadsheet. Because the object is a dataframe or a set of vectors, each vector or column of our dataframe has a name by which we can access and manipulate that vector. To get a list of names we simply use the command *names()* and input our dataframe (or other object) as the argument. 

```R
> names(ufo)
 [1] "datetime"             "city"                 "state"                "country"             
 [5] "shape"                "duration..seconds."   "duration..hours.min." "comments"            
 [9] "date.posted"          "latitude"             "longitude"
```
We see that our dataframe contains information about the date and time of the sighting, the city, state, and country of the sighting, the shape of the object seen, how long it was visible in both seconds and hours, some comments about the sighting, the date the information was posted in the main dataset and finally the latitude and longitude of the sighting location. 

> NOTE: DO NOT use spaces in names of objects or vectors within a dataframe. Either use camelBack (capitalization of each word with no spaces), periods, or underscores. While it is possible to use spaces, it can create major complications and more often than not will lead to errors in running your code and confusion in reading your code.

To see our dataframe we can access it in a few ways. The worse way would be to simply type in **ufo** into the console. The method we use should be dictated by the goal. If we are simply checking to make sure all is well with the data, we can use the *head()* or *tail()* command. Using this for any object will give you the first six rows of the dataframe or last six rows, respectively. This gives us a feel for our data. If we want to see the entire dataframe, we can use the command *view()* which will open a spreadsheet like tab in our editor window space in which we can scroll through the entire dataframe. We can only view this, however, we can not edit anything. We can open a special editing window, but remember, we want to track all of our edits so we will avoid doing that. 

To get some practice with what we have done so far, use the green plus in the upper-left side of the `R Studio` window and choose "R Script" to create a new script. In the fresh tab that opens in the editor, type of the code to clear the environment and then read in the "scrubbed.csv" file into the environment as the object **ufo**. Once you complete this, save it as "setup" using the blue disk in the editor. Try to do it yourself, but the code is below to help.

<strong>Example: Scripting the X Files</strong>

```R
    rm(list = ls())
    ufo <- read.csv(file = "./Data/scrubbed.csv", header = TRUE, as.is = TRUE)
```  


## API Downloads
Another means of obtaining data, especially commonly sourced data, is to use an Application Programming Interface (API) command. An API is an interface between two programs to exchange information.[^2] The most common type of API is a REST API which uses commands such as *get()*, *put()*, and *delete()*, to transfer data via HTTP protocols. Each different API will have different requirements to setup communications; however, most use some sort of key and then a means of sending the *get()* command to obtain data. 

[^2]: https://aws.amazon.com/what-is/api/#:~:text=API%20stands%20for%20Application%20Programming,software%20with%20a%20distinct%20function.

For our work, we will learn to access the U.S. Census API which allows us to code downloads of data from the decennial census and the American Community Survey (ACS). This is such a common occurrence, that there is a package written to simplify the communication between our `R` environment and the Census servers, called *tidycensus*.[^3] The code below is an example of what we would use to download data from the 2020 five-year data file from the ACS server.

[^3]: https://statsandr.com/blog/web-scraping-in-r/

### Working with Census Data via API

Specifically the census data that we are going to working with is the ACS or American Community Survey. This is data collected by the Census every year and is used to fill in the gaps between the full 10-year census carried out. In short, they do sample surveys of areas and utilize statistics to infer the population level statistics and then report them, at various geographic levels, along with the margin of error. While the data is collected every year, the more detailed the geographic unit being reported, the more survey years that are merged and reported. For example, State and National data are released every year; however, census tract or census block group data is reported every year but the data is a five-year moving average. Additionally, data source is that is already linked to Geographic Information System (GIS) data so we can also use these files to draw maps as a means of visualizing the data or use geography as the necessary common element to merge data from different sources. 

This will also give us a opportunity to start working with packages which are add-on libraries or packages for the base `R` that really give `R` its power. These are created by other users and can commonly be found and installed from either `GitHub` or the Comprehensive R Archive Network (CRAN). What is good about obtaining a package from CRAN over GitHub is that the former ensures that the package operates within the current version of `R` and adds a since of security. That said, obtaining a package from `GitHub` is not unheard of and should not be instantly ruled out. Utilizing any package requires two key steps: installing it on your local devise and loading it into the `R` environment. Everything we had done so far is included in what is called "base R" but that is very limited. There are two ways to install a package onto your local machine: via the command line and via `R Studio`. We will do both. 

For a command line install, we use the command *install.packages()* and then input the name of the package, in quotations, as the argument. So in your console type `install.packages("tidycensus")` and hit enter. You will either get some red text or a list of CRAN archive mirrors from which to choose. If the latter, then make a choice (preferably within the US since that is where we are located) and hit enter. If the former, ignore the text "WARNING: Rtools is required..." because we will not be creating any packages ourselves so we do not need this additional package. The rest of the text should tell you from where the package is being downloaded and where it is being installed. Finally it should tell you the package was unpacked successfully and the MD5 sums check out indicating it is not corrupted. The alternative method is to move you mouse to the menu across the top of `R Studio` to "TOOLS --> INSTALL PACKAGES...". In the window that opens, type "tidycensus" in the blank spot. The top option is either a CRAN location or local package and the lower option is where to install it. This should be in the local directory for our library we set up in our previous lecture. If you do this, you will see a similar output as we did using the command line. 

The next task is to load this library into the current environment so we can use its commands. One command we will use is *get_acs()* and notice if you type it in the console now, you get an error stating that `R` can not find this command. The command to load an package is *library()* with the package name (not in quotations) as the argument. Since we are keeping track of what we are going, open the script "setup", if not still open, and go to the top. Add a few empty lines under the command `rm(list = ls())` and in one of those, add the command `library(tidycensus)` and then save the file. Now source the script to run the entire thing. In the environment tab you should see your object **ufo** and nothing else. To verify that the library was loaded, use the *get_acs()* command again and notice the different error message. 

> NOTE: The clean environment command MUST be at the top of the script and everything, including loading packages, must come after, otherwise they too will be removed. The clear environment does exactly that: it wipes EVERYTHING except base `R` from the current R memory.

Every time we access the Census API, like any other, we will have to identify ourselves with our key. You should have received and saved an email from the U.S. Census with this key in it. While we could add the key to the *get()* command every time we use it, a better alternative is to simply install the key into our permanent R environment much the same way we changed the location of our package library. Fortunately for us, however, the creators of *tidycensus* created a function (or command) to do this for us. To utilize this, type the following into the console (because we only need do this once) and replace the text 'key' with the key you received (but keep the quotations because you are entering as a character). If this is the first time, set the install option to TRUE and the overwrite to FALSE. If you just want to temporarily change the key (for whatever reason), you would reverse those option settings. 

```R
census_api_key("key", overwrite = FALSE, install = TRUE)
```

The syntax of the *tidycensus* package is based on an API call and you can choose from two different sources at this time: "acs" and "decennial". The former is what we will use and the latter is the data from the 10-year population census. The ACS data only goes back to about 2001 (depending on the level you are looking for) and the decennial API only have 1990, 2000, 2010, and some 2020 data. The basic command we will be using is:
```R

acs <- get_acs(geography = "county",	#defines geography level of data 
               variables = vars,	    #specifics the data we want 
               state = 17,	          #denotes the specific state 
               year = 2021,	         #denotes the year
               geometry = TRUE)	     #downloads the TIGER shape file data  
```

The command `get_acs` is the command to pull data from the ACS API and then we have to fill in the necessary elements to help the software find our data. The first is `geography` and this denotes what level of analysis we want. What we put here will dictate which of the surveys (1-Year of 5-Year) the API will pull from. Next we have our `variables` and we will return to that momentarily. Notice, however, that rather than a character string, we have an object here because we have defined an object previously that gives a list of the variables we want. We do this for simplicity and to limit out calls to the API. Next up we have our `state` and notice that we have a number, not a name or an object. Every geographic level of analysis that the census (and most every other federal data source created) as a unique identifier called FIPS Code. The FIPS stands for Federal Information Processing System and the code can be from two to (I think) thirteen characters long with the longer codes referencing more fine level data. For example, DeKalb County has a FIPS code of 017037 with the first three numbers indicating the state (Illinois and the leading zero is usually dropped) and the next three indicate the county (DeKalb County). If we looked at finer levels within the county, we would see additional values added to this code to identify them. Based on this information, we can see that we are looking for the state of Illinois by using its FIPS code of 17. Next we have the `year` and this indicates what year were want the data from. We are asking for data from 2021 and, except for the 1-Year data files, this is the most recent that has been released at this point. Since we will be pulling from the 5-Year data files, we know that the data is from the surveyed dating from 2021, 2020, 2019, 2018, and 2017. Finally we have a command `geometry` and it is a logical argument set to "TRUE". This will pull the necessary data to create polygons for each county. If we only want the data, we can set to this FALSE, but since we want to visualize the data we will keep it set to TRUE.

> NOTE: A comment about what is *NOT* here. For example, we have no entry for which `county` we want and this is because we want all counties within our state. If we only wanted a subset of counties, we could either create a character vector with the FIPS codes for the counties we want or listed their names (however, FIPS code ensure fewer errors). Another case where we might need to designate a specific county is if we choose "block group" as our geography level. Block Groups are a unit comprise of several census blocks and when one combines several block groups, one gets the census tract. For example, inside of DeKalb County, there are twenty-one census tracts composed of sixty block groups each. The FIPS code for block group 4 within census tract 9 of DeKalb County is 170370009004. Breaking this down, we have "17" as the state, "037" as the county, "0009" as the census tract and "004" as the block group. If we were to simply replace "county" with "block group" in the above code, we would download the entire set of block groups for the entire state of Illinois (a dataset with 9,691 observations).

### Variables and the Census  

The U.S. Census has data on several different aspects of American life, but they can mainly be broken down into demographic characteristics (items about the people in the population) and housing characteristics (items about the structures in the built environment). Finding the "name" of the data that you want is not necessarily the easiest thing to do, but there are a few tools to help you. One is to use the [Census website data center](https://data.census.gov/table/) and use this to search for your data. Another is built into the *tidycensus* package which allows us to create an object with the names and ids for all of the data series available for any given year and any given survey, along with the smallest geography reported. To crate such an object, use the command below in the console. 
```R
acs <- load_variables(year = 2021, dataset = "acs5")
```

Using the *head()* command we get:

```R
> head(acs)
# A tibble: 6 × 4
  name        label                                   concept                  geography
  <chr>       <chr>                                   <chr>                    <chr>    
1 B01001A_001 Estimate!!Total:                        SEX BY AGE (WHITE ALONE) tract    
2 B01001A_002 Estimate!!Total:!!Male:                 SEX BY AGE (WHITE ALONE) tract    
3 B01001A_003 Estimate!!Total:!!Male:!!Under 5 years  SEX BY AGE (WHITE ALONE) tract    
4 B01001A_004 Estimate!!Total:!!Male:!!5 to 9 years   SEX BY AGE (WHITE ALONE) tract    
5 B01001A_005 Estimate!!Total:!!Male:!!10 to 14 years SEX BY AGE (WHITE ALONE) tract    
6 B01001A_006 Estimate!!Total:!!Male:!!15 to 17 years SEX BY AGE (WHITE ALONE) tract
```

We can again, use the command *view()* and then hit CTRL+F to open the "find" task in the viewer and type in "Education" to highlight the different variables measuring education attainment. Our goal is to find the name that we will use to get the required data for our purposes. To get a feel for using this command, however, copy the following code block. Before you do that, use the viewer and finding tool to figure out what dataset we are getting with this code.

```R
cen.stat <- get_acs(geography = "state", 
                   variables = "B01003_001E", 
                   year = 2020,
                   survey = "acs5",
                   geometry = TRUE)
```
Finally, for a bit of fun, type `plot(cen.stat$geometry)` and hit enter. What happens?

## Web Scrape

Another, and more complicated, means of obtaining data is through web scraping. This is the action of utilization of the fact that website are nothing but code that is translated by your browser into a visual form. As a result, there are methods of coping the `html` code into a program, such as `R`, and then filtering the code for the information you are looking for. We are not going to do an example of this given the complexity, but there are several sources of tutorials that can be found by searching for web scraping in `R`.[^3] 

# Cleaning Data

When we get data, in whatever form, it is never going to be in the exact form that we need leading us to to clean and massage the data into a form that we can use. The most comprehensive package for doing this in `R` is the package *tidyverse*[^1]. Another nice element of *tidyverse* is that we can "pipe" commands which makes our script both more readable and easier to write. An example of a piped code line is shown below for you to copy and run in your console.

[^1]: https://www.tidyverse.org/ 

## Tidy-ing things up

Let's start with our *setup.R* script and use the source command to entire we are up-to-date. We have an object called **ufo** which we know contains information on the sightings of UFOs globally. Our long range goal is to do the following:

- Limit the data to only the continental U.S.
- Aggregate the data to the level of decade while maintaining the year of the sighting as well.
- Be able to link the data to State level census population characteristics.
- Be able to create a map of the continental U.S. depicting the occurrences in a given decade by year.
- Keep our file size as small as possible.

With those goals in mind, we will look at what we have in the data. Again, using the *head()* command, the first thing that sticks out is the fact that we do not need the data recording information about the sightings (although that could be an interesting source of information such as looking for key or common words or phrases--and there is a package for that). This means we will want to remove this column. We also see that the recorded date of the sighting is combined with the time and so we need to the year out of that vector and turn it into something useful. Finally, we see that there is latitude and longitude so we need to figure out how to get that into a form that is also useful. The code that will do most of this work is in the block below and you should copy this below the point in the script where we read in our data.

```R
ufo.us <- ufo %>%
  filter(country == "us") %>%
  select(-comments) %>%
  mutate(date = as.Date(str_split_i(datetime," ", 1), "%m/%d/%Y"),
         year = year(date),
         decade = year - year %% 10) %>%
  filter(decade > 1959)
```
## We will return after these brief comments
At this point, our code is starting to get a bit complex and so we need to make sure we remind ourselves of what we are doing and keep ourselves organized. To do this in a script, we add comments which is text that we can read in the script, but which `R` completely ignores. Just like it is important to have good file organization in a project, it is also vital to have good script organization and notation. Remember, we are trying to keep readability and reproduction in mind. To that end, we will add some comments to our script by adding text proceeded with the \#. 

The hashtag (\#) is the indication to `R` to ignore what comes next on the current line as it is for humans only. We can use comments to title our script, remind us what it does, list any scripts that should be run prior to the current script, keep notes for ourselves and co-authors about key element in the script, and even create collapsible sub-groupings within a script. The first thing we will add is header information which should include what the current script does, the author, the creation date, and a description and date for any subsequent updates or changes. Add the following lines to your script at the top of the page, either before or after the clear command.

> NOTE: We can place this information before the clear command because it is not used in the computation or even read by the program and thus is never put into the memory so cannot be cleared out.

 ```R
#This script is used to input, clean and prepare our UFO sighting data for use in analysis
#
#By: *Your Name*
#Date: *Today's Date*
```

Next, we will divide our script up into sections. The first section we will title Loading Data and within that section we will load any external data. The next section we will title CLearning the Data and we will include the code block from above in that section. Your exercise is to input these titles as comments in the appropriate places. The answer is below.

<strong>Exercise: Tracking our Path</strong>

  ```R
#Loading Data#####

#Cleaning the Data####
```

What you likely did not include, because you did not know, is the set of five hash marks after the comment. Notice that when you type this, you will notice a "drop down arrow" appear on the far left side by the line numbers of the editor. Clicking this will collapse all the code either to the end of the script or the start of the next section.

## Returning to our chores

Now if we run the script we will quickly find that we fail because of an error. Can you tell me why we have the error and what to do to fix it?
<details>
  <summary>Exercise: The Error of our Ways</summary>
  The error occurs because we are using commands native to the *tidyverse* package, but we have not either installed or loaded the the package into environment.

  The solution is to first install the package via one of the two methods we learned (either using the menu method or the *install_packages()* command) and then add the code line `library(tidyverse)' at the top of the script with our previous library loads. 
</details>

Once we accomplish that solution, when we run the code we get a new object named **ufo.us** that is smaller than our original version. Using the *head()* command we see we have accomplished several of our goals. To better understand this, however, let's break the code down, line-by-line. As a reminder, the code was:

```R
ufo.us <- ufo %>%
  filter(country == "us") %>%
  select(-comments) %>%
  mutate(date = as.Date(str_split_i(datetime," ", 1), "%m/%d/%Y"),
         year = year(date),
         decade = year - year %% 10) %>%
  filter(decade > 1959)
```

The first line is our assignment of our soon-to-be modified dataframe **ufo** to the new object **ufo.us** followed by the string `%>%`. This is the pipe symbol and can be thought of as an alternative to a function in that we are going to be running a series of commands on the dataframe assuming the above line has been completed. One of the key benefits is that we do not have to keep writing the dataframe name as the piped code assumes it is the same core dataframe used in the assignment line. 

The second line of code filters the dataframe to keep only the values where the country is designated as being within the United States. The next line allows us to select which columns we wish to keep in the dataframe. Notice, however, that we use the syntax "-comments" meaning "everything but comments". This syntax is an alternative to writing all of the columns we want to keep and is useful when we want to keep all but a few columns. If we have more than one column we wanted to drop, we could combine then using the *c()* command. Alternatively we could have replace the "-" with "!" which is the code to indicate "negate" or "not" so we would be telling `R` to select "not comments". Now, after removing the comments column, we want to create a column that tells me the decade in which the sighting occurred. The *tidyverse* package is in reality a "universe" of packages that have been combined into a single package to do various things. For example, the package *ggplot2* will allow us to create and customize graphics while the package *stringr* allow us to perform several key operations on character strings. Another package included is called *Luberdate* which helps us to use and manipulate dates by essentially creating a new class of objects that are dates. In other words, if we create the date as a date and then try to determine the number of days between October 1 and December 25, we would get the correct number of days accounting for the fact that October has 31 days while November only has 30. 

This line is also an example of a nested code line where we perform several actions on a single object in the same line and we read nested code from the inside out, similar to the orders of operations in math. Starting with the command *str_split_i()* which splits strings of characters based on some pattern. The string we want to manipulate is the "datetime" column. To see our goal, type the code `head(ufo$datetime)` command in your terminal to see the first six rows of this column. 

> NOTE: rather than using the `head(ufo)` to get the head of the entire dataframe, we use the "$" to denote the specific column within the dataframe we want to see. This is one way to refer to a specific dataframe column. An alternative is to use the numerical location of the column we wish to view. Since the "datetime" column is the first column of the dataframe, we could reference it with `head(ufo[,1])` where the brackets denote the "[row, column]" location and a missing value instructs `R` to return all of that row or column.

We see that the data column contains a date and time together, but we really only want the date. Fortunately for us, the two pieces of information are separated by a space and so we can split the string based on that element or pattern and that is what the second argument of the *str_split_i()* command is telling `R`[^2]. Finally, this is a special version of the command because we only care about a subset of the string, specifically the first part of the split, and this is what the third option does for us. This leaves us with a date but it is still in the form or a character string and we want to be able to treat it as a date so we can, for example, order by date or translate to this a decade. One approach would be to split the string again. How would you write the code to pull out the year from the date using the *str_split_i()* command?

[^2]: When manipulating and analyzing strings, we can more precision using a type of coding referred to as Regular Expressions. More information can be found at https://r4ds.hadley.nz/regexps.

<strong>Exercise: Continuing to excise the year</strong>
  ```R
  str_split_i(str_split_i(datetime, " ", 1), "\", 3)
  ```

We will use an alternative approach of turning the character string resulting from our split into an object of the class "date" by using the *as.Date()* command. This command has to main parts: the string identification and the format of the string. We have already told the command to use the first element of the split string of the "datetime" column and we now need to tell `R` how the date is formatted in this character. Specifically it is in month ("%m"), day ("%d%"), four-digit year ("%Y%) with slashes ("\\") divisions. If we had text for the month we would use either "%B" if the full month is written out or "%b%" for the three letter abbreviation and if it was a two-digit year, we use "%y". Finally, this is nested in the *mutate()* command which is native to the *tidyverse* packages and is used to create new data columns in a dataframe. 

Once we get the date of the sighting, we want to get the year from that date and then assign that year to the correct decade. We could do this as nested code again, but remember that we want to also have the year of the sighting within that decade so we will use *mutate()* to create two new data columns. Rather than end the mutate command and type it again, we simply place a comma at the end of the line and hit return. `R` will typically treat commas and pluses as indicators that the code line is continuing and ignore the cartage return. A nice feature of `R Studio` is how it automatically indents the next row of text to line up with the start of the previous start of the mutate command to help with readability. Here we use another of the *Luberdate* commands to pull the year from the date that we just defined and then follow that up with a final mutate command to create a new columns called "decade" which creates the decade by subtracting from the year, the remainder from the year divided by 10. The "%%" tells `R` to use the Modulo Operator which is the mathematical operation of returning the remainder from a division problem.[^3] Finally we want to filter the dataframe once more to include only sightings that have occurred since the 1960's.

[^3]: https://en.wikipedia.org/wiki/Modulo 

<strong> Exercise: Cleaning up the census </strong>
  
Let us practice what we have learned about pipped commands and data cleaning. When you used the census API to create the object **cen.stat** you also pulled down the data necessary to create a map of the United States. To create this map, use the following code: `plot(cen.stat$geometry)`. Notice that beyond the continental U.S., we get an odd looking image because we have the Alaskan island on the far right and also have the Hawaiian Islands and Puerto Rico. Your exercise is to write and run a code that will create a dataframe that we can map only the centennial U.S. with. The new dataframe should be named **cen.map**, contain only the columns GEOID, NAME, and geometry. To check your work, use the command *plot(cen.map)*.
<details>
<summary>Answer</summary>
  First we look up on Google the FIPS code for the three territories we want to remove and see that Alaska is '02', Hawaii is '15' and Puerto Rico is '72'. We then use the following code.
    
```R

    cen.map <- cen.stat %>%
      filter(GEOID != "02",
             GEOID != "15",
             GEOID != "72") %>%
      select(-c(variable, estimate, moe)) %>%
      arrange(GEOID)
	  
```
</details>

## Creating "new" Data

Most of the time in your research, you will have "parts" of the data that you need, but it will be at the wrong aggregation level or not be connected into a single database. This is another advantage of learning coding and how to think about data. Let's say we need to take our ufo siting data and we need to show how the number of sightings has changed, by state, since the 1970's and then we need to visualize that in a form that is easily digestible by a non-economics audience. To complete this project, we need to first determine what it is that we need, think about where to get that, and then what we might need to do to the data to bring it all together. 

We know that we have the state listed in our **ufo** object so we can use that to aggregate, assuming they are all correct, and then we know that we can draw a map with our census dataframe. A couple of obstacles we need to overcome are that the state names in our two datasets are not formatted correctly and we need to figure out how to draw different maps for each decade. Let's start by aggregating our data.

### Data Grouping and Aggregation

My first step would be a quick Google search for how to count occurrences of a variable in `R` and I would likely find that the answer is in the `count()` command in *tidyverse*. Looking up the information for this command I see that I can accomplish my goal with the following two lines of code:

```R
	ufo.st <- ufo.us %>%
		count(state, decade)
```

After running this, I get a new dataframe named **ufo.st** that contains only three vectors: state, decade, and n with the last vector being the number of times each state code was found in the data during each decade. Now I need to bridge this to the census map data. I could mannually enter the two letter abbreviation for each state and the FIPS code, or I could see if someone had done it already and quick Google search shows that the BLS[^4] has a nice table that does do this. The problem is that the table is not downloadable so I am going to have to copy and paste. Since I am using a table, I am going to first try to paste the table into Excel and since that does work, I will make this a three column table rather than six, remove the extra header row at the top of the table, and make sure the table names are sufficiently simple. While I could save this as an Excel file and read that into `R`, I would prefer to keep the data in as raw a form as possible, so I will save this as a simple **.csv** file and then put in it my project directory under the **Data** folder as the file **st_abb.csv**.

[^4]: https://www.bls.gov/respondents/mwr/electronic-data-interchange/appendix-d-usps-state-abbreviations-and-fips-codes.htm

If I was more comfortable with the web scraping coding in `R`, I could have just as easily written a quick code to scrape this table from the BLS website directly and used that table rather than copy and pasting through Excel. This would have been the alternative if the copy and paste did not work or if the table was rather complex. Since it was a simple table, we do it this way; however, we will cite the table location in a comment in our code. With this, I can always go back and add this coding or at least will know where the data came from. Above that citation, I will write the code to pull in the data into a dataframe called **st_abb** and to keep with my organization, I will add this information under the Loading Data section of the script.

Unfortunately for us, the state code in the abbreviation bridge and the UFO data are in different cases. This is quickly resolved with a command in the *tidyverse* package called **toupper()** which will change all the characters in a given vector to uppercase. We will tact this onto our pipped code that aggergates our data using the line `mutate(Abbr = toupper(state))`

Why did we create this vector with the name "Abbr"? The simple answer is that using this name means our data is matched with the target vector in the **st_abb** dataframe making our join that much easier. Since we are unsure if the data is "correct" in the **ufo** dataframe, we will do a full join to verify everything matches up correctly. Add the line `full_join(., st_abb, by = "Abbr")` and then run the pipped code (assuming we have already read in the abbreviation bridge file. 

We then run a `summary()` command on our new data and see we have a single 'NA' and so a quick view of the data indicates that this is for the Virgin Islands so we know we can remove this using `filter(!is.na(n))`. Also in the viewer, we can verify that everything seemed to find a match, so we are good so far. 

In the census data we know the FIPS code is named GEOID so we can rename that variable in our new dataframe by adding the command `rename("GEOID" = "Code")` and then going the census maps to the **ufo** data using this common element. This is where care is important because if we try to do this, we will get an error and even solving that error may not allow us to arrive at the correct dataframe. 

<strong>Question: Why will the two dataframes not join on the GEOID vector?</strong>

<details>
<summary>Answer:</summary> 
	They are different types. The GEOID in the **cen.map** dataframe is character while it is numeric in the new **ufo.st** dataframe. Additionally, the GEOID in the census data is "padded". 
</details>

The best way to fix this problem is to add another mutate command into our **ufo.st** pipped code to change the vector type of "GEOID" and then pad it with zeros. We can do this with the nested command `mutate(GEOID = str_pad(as.character(GEOID), width = 2, side = "left", pad="0"))` and follow this up with a line to remove our unwanted GEOIDs [` filter(GEOID != "02", GEOID != "72", GEOID != "15")`].

If we now try to join, the data will join, but we will have to add an additional line of code to maintain the sf object of **cen.map**. The more direct way to preserve that object type is to join *onto* to the sf object so write the script to complete a left join (keeping the information in **cen.map**) on GEOID.

```R 
ufo.map <- cen.map %>%
  left_join(., ufo.st, by="GEOID" )
```
### Data Visualization

We now have a rather large dataframe that contains information about the number of UFO sightings in each state across each decade from 1960 to 2010. We need to convey this information to our client or as part of our research project and running the `summary(ufo.map)` command will not show us much. This is where thoughtful data visualization skills are important. We can convey information in one of two primary ways: a table or an image. Within the *tidyverse* package is the package *ggplot2* which allows for the creation and detailed modification of several key data visualization objects. The first we will work with is a box-plot graph.

A box-plot graph shows information about the interquartile range, median, and outliers, and the code is pretty straightforward. Before we draw the graph, however, we are going to want to group on some of our variables and that is facilitated if we change the vector from character or numeric to a factor. This is also helpful when running regressions because, at least in the basic regression syntax, `R` knows to drop a reference group and you can use the factor command to set your desired reference group. As such, add the code below to the end of the code that creates the dataframe **ufo.map**.

```R
 %>%
    mutate(decade = as.factor(decade),
           state = as.factor(state))
```
Next we will add the code block below to create our box-plot graph looking at the change in sightings over the decades. We see the first line calls the `ggplot()` command and tells it the dataframe we will be working with. We can populate this command line with several things or nothing, we just need to know that this will set whatever we put in here as the "global" and apply to ALL subcommands in this sequence. Since we know we are using only one dataframe, we will add it here and then close the line with a `+` sign. 

Next we define the "geom" that we want the package to create. This is the type of image we want to make. You have seen this before with the `geom_sf()` command we used to create the map earlier. Here the geom is the `geom_boxplot()` and within this command we see the command `aes()` which stands are asthetics and it defines the key elements of the graph such as what is on the x-axis and the y-axis. Run this and see what you get.

```R
  ggplot(ufo.map) +
    geom_boxplot(aes(x = decade, y = n))
```
> Exercise
> Create a new box plot where we see the summary for each state rather than each decade
> <details>
>	<summary>Answer</summary>
> 	`Replace 'x = decade' with 'x = state'`
> </details>

We see from our Box Plots that the data is very different across the decades and this could be for a number of reasons. To solve this problem, let us add a new command in the `mutate()` command in creating the **ufo.map** object and create the natural log of the number of sightings. We can then re-run our box plot and we see something much more in line with expectations. Now we can use the advantages of the *ggplot2* package to clean this data up a bit. Copy of the code below and run to see what you get.

```R
 ggplot(ufo.map) +
    geom_boxplot(aes(x = decade, y = ln_n), color = "navy") + 
    theme_bw() + 
    labs(title = "Box Plot of UFO sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    xlab("Decade") +
    ylab("Natural Log of Annual Sightings")
  
  ggplot(ufo.map) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") +
    scale_fill_gradient2(low = "white", high = "blue", na.value = NA, 
                         name = "LN(Sightings)",
                         limits = c(0, 9)) +
    theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank()) +
    facet_wrap( ~ decade)
```




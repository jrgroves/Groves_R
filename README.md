# Download and Install
The first thing you need to do is to download some software that we will be using for the course. Please note that I should be able to help with installation on PCs, but less so with Apple devices.
## Text Editor
   This is not an absolute requirement because most operating system have a built in text editor. That said, I have found Notepad ++ to be quite useful because it will allow you to write text in just about any language (html, markdown, plain, etc.) and will recognize the format. There are also lots of plugins that you can add depending on what you do.  
   [Download Notepad++](https://notepad-plus-plus.org/downloads/)
## Git
   The next program we will download is Git. This is a version control software and is used to help keep track of changes that are made when you are writing a paper or writing code for a program or project. The idea behind version control is like a library or a journal where you can store key elements in the cloud and then update when you make made changes that you want to keep. Another key feature is that it keeps a record of each time you submit changes so you can go back, or revert, to any previous version of a project.  
   [Download Git](https://gitforwindows.org/)
## R Core
   The next thing you will need is to install the core R program. R is a free programing language that you can use for pretty much anything similar to Python. The core R program has many capabilities, however, the real power comes from the packages or "libraries" that you can add to the software. These are created by other users and are typically specialized for specific tasks ranging from web scraping to simple regressions.  
   [Download Core R for Windows](https://cran.r-project.org/bin/windows/base/)  
   [Download Core R for iOS](https://cran.r-project.org/bin/macosx/)
## R Studio
   The last thing we will download is going to be R Studio and it is going to be our workhorse. In short, it is a graphical user interface (GUI) that allows us to access Core R, libraries we download, version control, and many other aspects of a project all in one place. It is even possible to write an entire paper within R Studio and, most importantly, it is free.  
   [Download R Studio](https://posit.co/download/rstudio-desktop/) *Scroll down for various operating system downloads.*

## U.S. Census API Key
   We will be using a service of the U.S. Census Bureau known as an API and this requires obtaining an API Key. This is free and simply a means of keeping tabs on who is accessing the database for what use. To obtain a key, go to the [Census Key Website](https://api.census.gov/data/key_signup.html) and fill in your name, email address (really should use your z-id email address) and agree to the terms of service. Your key will now be sent to you in your email account. Make sure to save this email, because we will be using it in class.
# Setup and Configuration
Now that everything is installed, open your RStudio program and you should see a screen that looks something like this:
![[Pasted image 20251031124157.png]]
While not necessary, we will do just about everything we need to do to get setup in the RStudio interface. Specifically we will set up our GIT identification and set up our working directory structure.
## GIT Identification
To use `GIT`, you need to identify yourself so that when we commit changes, we can know *who* made those changes. We will do this using the RStudio terminal which is a command line based shell. Other options are to use `GIT Bash` which you installed when you installed GIT on your machine, or your operating systems own terminal or command line system. For us, notice in the top left window of RStudio we see three tabs: Console, Terminal, and Background Jobs.  You will need to click on Terminal to access the shell program. Once that window has popped up, you are given the command prompt where you need to input the two lines of command. Use your own name and email address that corresponds to your GitHub account.

```bash
git config --global user.name "Jeremy R. Groves"
git config --global user.email "jgroves@niu.edu"
```
This will now tag all of your `GIT` work with your name and email so that we can make sure we know who has submitted what changes.
## R-Studio and Git/GitHub
Next we want to link `R Studio` with `Git` and allow it to access GitHub securely. We do not have to use `R Studio` to utilize the feature of Git or GitHub because we can use the command line prompts (Git Bash) for that as well. Since `RStudio` provides a standard means of interacting with `Git`, we will continue to use this. With `RStudio` still open, go to the menu across the top of the screen and locate `TOOLS --> GLOBAL OPTIONS` and a smaller screen will open. Along the left side, click on the part that states `GIT/SVN` and then make sure the box at the top is checked and then in the area below "Git Executable" you need to navigate to the `git.exe` file. On a PC, it will be located at `C:/Program Files/Git/bin/git.exe`. You can either type this address in or you can navigate to it via the **Browse** button. Once this box is filled in, click **Apply** and then **Okay**.

![[Pasted image 20251031125617.png]]

Next, we need to allow GitHub (our cloud version) and `R Studio` to talk to each other securely and for that we need a personal passkey. Fortunately someone wrote a library and program in `R` for just that purpose. Since we are not going to download the full library with these commands in them, we can use the `usethis::` command prefix and then use the command `create_github_token()`. To run the necessary code, choose the Console option of the three tab in the left-side window of `RStudio` and type each of the lines of code below following each with the ENTER key.

```R
install.packages("usethis")
usethis::create_github_token()
```

After the second command, GitHub should open on your browser and ask you to log in. Once you do that, you should see the following screen.

![[Pasted image 20251031125925.png]]

You can name your passkey whatever you want and then click on the drop-down menu and choose at least 90 Days (this will get us through the class). Scroll to the bottom and click **Generate Token** and you will get a sting of letters and numbers. This is Hexadecimal text and make sure to copy this and then paste it either in a Word file or a text file because once you close this window, you will NEVER get this token back. If you lose it; however, you can just generate a new one and use it. Once you have copied the code somewhere else, go back to `RStudio` and then type the following in the console.

```R
gitcreds::gitcreds_set()
```

You should see a set of options and you should choose `2` and then when it asks for the token, paste the hexadecimal code you copied and press enter. This will save the passkey in the R system files and you will only need to do this again if your code expires or, sometimes, when you update R.  
## R Library Setup (optional)
`R` is a solid program for data analysis; however, most of its power comes in its ability to use libraries. These are add-ons created by other users that expand what the program can do or simplify the way a script is written. Most of these packages are located at the CRAN website; however, others can be found on GitHub. To use them, they must first be downloaded and then installed into `R`. Another aspect of how `R` works is that when the base `R` is updated and you install the new version, it DOES NOT overwrite the previous version, rather it installs the new version along side the older version. The reason for this is that some of the libraries fall out of use and are not updated for new `R` versions and so having an older version allows users to access those tools. The tradeoff to this system is that the libraries are installed in the version specific folder so when you update `R`, you must also reinstall all libraries. Since we do not typically run into the version problem, it becomes helpful to place all of your libraries into one common directory and then just update where `R` looks for the library files.  

To make this change, we first need to find the `Rprofile.R` file on your computers. For PC users you can find this file at `C:/Program Files/R/*current install*/library/base/R`. Navigate here using your file explorer program and then find the file `Rprofile.R` and right-click and choose to edit with **Notepad++** or other text editor. When it opens, scroll all the way down to the bottom and then add the following text. 

```R
#My Stuff
myPaths <- c("C:/Users/.../Documents/R/userLibrary", .libPaths())
.libPaths(myPaths)
```

Within this code, the command `.libPaths()` holds the location of where `R` looks for library files when you use the `library()` command in your script. This code updates that object by adding the user defined library location. My listing this one first, it also designates our user defined library as the default location when we install libraries for `R` to use. By placing this command in the `Rprofile.R` script, which is a script `R` runs on start up, we are always updating this variable every time we start up `R`. 
## Installing and Using Libraries
Now lets go ahead and install a couple of libraries by opening `R Studio` and looking in the window on the left side and making sure you are in the Console tab. This is where you can run "command line" code to `R` without a script. While not ideal for working on projects, it is fine for quick set-ups or function calls. 

You have actually already done this when you installed the *usethis* package above. This time, however, we will install one of the power-house packages we will be using *tidyverse*.  *Tidyverse* is a package which is a collection of several packages that make getting, cleaning, manipulating, and visualizing data of various types (numbers, character strings, dates, etc.) much easier and intuitive. Try to install this package on your own, but if you struggle, here is the code.

```R
install.packages("tidyverse")
```
## Project Management and GitHub
Whether you are by yourself, working with a team, or, more to your cases, working with an advisor, having an effective "project" setup will help you organize your thoughts and ideas and provide an much easier way to interact with an advisor or co-author. While `RStudio` has a built-in project system, we are going use this in conjunction with `GitHub` to ensure there is always a copy of our information we can get to if needed. This is ideal if you are working across multiple devices and locations. 

Organization also helps you work with others and remember what you did and why when you revisit a project either an hour or a year after you started it. Organization also helps you should you need to prove or verify your work either to a professor or a journal when you submit for publication. This later issue, that of reproducibility, is becoming even more important given the number of cases of academic misconduct being uncovered, even among Nobel Prize winners. We are going to organize our project in `RStudio` and then back it up in a `GitHub` Repository for both protection and for easier remote access by ourselves or co-workers. We start the process in reverse however.
### Create Repository on GitHub
A Repository is a place on the GitHub cloud where you can keep relevant files for any given project. You have each setup a profile on `GitHub` and are all part of the GitHub Classroom environment for this class. Use this URL link (https://classroom.github.com/a/aYMYVjZ6Go) to get to the `Groves R` Repo to check it out and clone a local copy in your `GitHub` account. From your own `GitHub` account, go to this repository and copy the URL line in the browser window or using the down-arrow of the green CODE button in `GitHub`. 
### Create Project in R-Studio
As mentioned, `RStudio` has a system built into it that acts as a means for keeping information and data on a project together called *PROJECTS*. We can create a project on our computer only, or we can link it to a GitHub or similar type repository. Creating projects, however, is of little use if we do not know where we left them so I recommend that you create a **Projects** directory in your systems **My Documents** folder (or its Apple equivalent)

Next we will return to the drop-down arrow in the upper-right corner of our `RStudio` windows that says **PROJECT(none)**. Click on this and choose "New Project". A small screen will open on your computer and you need to click the Version Control banner and then click on the Git banner.  
<p align="center">
  <img src="https://github.com/jrgroves/ECON691/assets/52717006/64332c4b-b877-40b7-bc5b-a5c91569ecc3"/>
</p>

The window that is now open is asking for the URL from the repository that you created on `GitHub` which you can get by simply navigating to the repository in your web browser and copy the URL from the location bar at the top of the browser. Once copied, you can paste in the URL space and that will typically auto populate the Project Name dialog box below it. The third box is were it will live on your computer and if not already showing your **Projects** directory, click the browse button and navigate to that directory. Once you are there and click open, click the "Create Project" button on the screen.  

<p align="center">
  <img src="https://github.com/jrgroves/ECON691/assets/52717006/6a2e5628-6035-4016-9ab1-997a0459726a"/>
</p>

Once you hit "Create Project" it will appear that `RStudio` reloads and we will be ready to start working. The other action you will notice is that a copy of the `Groves R` repo that you cloned to your `GitHub` account is now going to be copied, or cloned, to your device. You can verify this by looking at the *Files* tab in the lower-right side of `RStudio` and notice that it now switches to a newly created directory within your **Projects** directory with the same name as your repo on GitHub and sets the working directory in `R` to that location. To verify this, type the `getwd()` in the console and see what is reported.  The last thing you should notice that is different is that there is now a new tab in the upper-right window of `RStudio` called *Git*. Under this tab is one way we can interact with both `Git` and GitHub.
### Directory Setup
You will now have a project directory on your computer's hard drive that has a backup on the GitHub cloud. You can access the files on your computer using the *Files* tab in `R Stuido` or via your OS. Aside from keeping track of your work, the organization of your work is also important and so we will set up a directory structure that is both simple and understandable by an outside observer. Within your main project directory you need to create three new sub-directories called: Data, Build, and Analysis. You can also include others such as "Paper" for any documents for the final essay you will create or "Archive" which I will use if I decide to go in a completely different direction in coding my product. Within both the "Build" and "Analysis" directory, you want to create the directories: Code and Output. Using this framework will not only help with organization, but accessing data and scripts just got significantly easier.
## Commit-Push-Pull
### Create
Version control allows us to keep track of changes both by us and anyone else that has permission to access our repository. It does not, however, keep track of all of our key strokes and it can only track what we tell it to track and it takes a "snapshot" only when we tell it to. Whenever we create or modify a file, version control, or in this case `Git`, will recognize that it is different than what is currently in the repository, but that is the extent of what it will do on its own. We we complete our modifications and want to update what we have on our main or branch, we must first "stage" the files. 

We can stage as many files as we want and we can think of "staging" as placing our newly changed files in an envelop that we are going to "mail" to our repo. To actually submit the changes so that version control will commit them to "memory", we have to commit them. When we commit a set of changes, we have the option to add a comment to our commit to tell ourselves or others what we changed in this part that is being committed. Once we commit, version control creates a new "version" of the project using those files and creates a history which contains the older versions of our project prior to those changes that were committed.

To practice this in our example, we are going to create a text file to tract what we do each day in class. In `RStudio`, use the `FILE--->New File--->Markdown File` and this will split the left-side of your screen as the Editor is opened. The Console will slide to the bottom and you will be able to edit documents and scripts in the upper frame. Type something in this empty markdown file.
### Commit
Once that is completed, click on the disk icon and save the file as **Tracking** and you can simply save it in your current directory (which should be your project directory). Once the file is saved, go to the upper-right window and click on the GIT tab. You will see a list of files there that you can choose to "stage" so look for the newly created **Tracking** file. You should see an empty checkbox and two yellow squares to the left of the file name. Once you click the checkbox, the two yellow will become one green with the letter 'A' in the box. This means the file is "staged." If you had modified a file already part of the repository, you would see the empty checkbox and a blue square indicating it has been modified and not committed. 

We want to commit our Tracking file to the repository so after we click the checkbox and see the green box, we click on the COMMIT button near the top of this GIT tab. That will open a new window and all we want to is type something the upper-right window. This is our commit message to remind us later what we committed this time. Type something like "initial commit" and then click the COMMIT button. A status window will pop up and you can click CLOSE once it is finished. You can then exit out of the other window that is open (where you put your commit message) and return to the GIT tab. 
### Push
At this point, the file is committed to the version of our repository on your device, but not at `GitHub`. You can verify this by looking at the repo in your browser. Returning to `RStudio` and the GIT tab, you will see a button that says ***PUSH***. Click this and the version of the repository on your device will be "pushed" up to the cloud. Once the status windows indicates it is finish, return to your browser and refresh and you should now see your Tracking file in your directory online. Congratulations, you just pushed your first commit and push to the cloud.

To verify this, go to the repository on GitHub through your browser, make sure to refresh you web view and you should now see the **Tracking.md** in your GitHub Repository.

### Pull
Still in your browser, click on the **Tracking.md** folder and then click on the pen icon in the upper-left of the screen. Once you do that, we are going to add something to the **Tracking.md** file to simulate having someone else working on this project and making a change. Under what you have already written, create a sub-heading (or Heading 2) and then under that, place your name and something else such as your desired field. Once completed, click on the ***Commit changes...*** button in the upper-left of the screen. Just as in `R Studio` we see a screen that summarizes what we just did in a suggested commit message and an option to add to this. We will just accept what is here and click the ***Commit changes*** button. 

When we return to the main page we will see that the **Tracking.md** file is listed to have been altered "now" and if we view it, we see the new additions. Turning to `R Studio`, however, we see that the new material is NOT present in our **Tracking.md** file stored locally. To resolve this, we need to *PULL* the data down from the cloud onto our device and we do that with the corresponding button in the Git tab. If the file is still open in our editor we may need to close it, but when we view or reopen the file after a successful pull, we will now see our updated material. 

# Getting Started with R
## Script Setup
While we may try out commands in our source space, we want to track everything we do in our scripts. Furthermore, we want to ensure that we know what each of our scripts do and we set them up and note them so that anyone can come along behind us and replicate what we do. As with most things, organization is the key. 

To see what we are going to do here, copy a new script by using `FILE--->New File--->R Script`
sequence which will open a blank script page in your editor. A script should be divided up into about three different parts: Information; Load up; and Work. In the information section we want to add a comment at the top of the script explaining what we are designing this script to do. Next we want to include our name and a creation data and a placeholder for updates that we may perform on this script as our project evolves. All of this should be in comment form so every line needs a hashtag (`#`) starting the line. 

Next we will load up our session. This is where we will load any data we need and install libraries for this script. Before that, however, we want to make sure we are starting with a clean slate so I always open all my scripts with the command `rm(list = ls())` which will clear the environment of everything that could be a fragment from previous projects. You should note that this clears EVERYTHING in the active memory for `R` so any unsaved data, function, or libraries will be removed from the active memory. 

After this, we can add our libraries. There are a few ways to do this, however, the simplest is to just use the `library()` command with the desired library in the command. For our purposes, we want to load the *tidyverse* library. Following our libraries, we want to load any data that we will be using in our analysis and so we need to go out and get some. 
## Getting Data Into R
The core of any empirical research project is the data, and depending on your project and level of analysis, obtaining that data can be easy or hard. In microeconomics analysis, the easier the data is to obtain, the less ripe that avenue of research is likely to be. More often than not, the data you want is not going to be a simple point-and-click away. You'll need to find creative means to put the data together, so we'll look at various methods for obtaining data.

Additionally, it is more than likely that you will be bringing in some of the data from elsewhere, and so we need to learn how to read data into our `R environment` for analysis. Finally, we will likely need to join data from various sources to get the full dataset needed for a correct analysis.

Another important factor to keep in mind is the need for you or anyone else to be able to reproduce any project. In terms of obtaining, cleaning, and merging datasets, we should keep the data we bring into our analysis as raw as possible and do any manipulation and merging within `R` via a script. This not only preserves the original copy of the data but also ensures we have a written record, via the script, of what we did and how we got the data we eventually used.
### Delimited Files
The best way to store raw data is in an independent form such as a delimited file, also known as delimiter-separated value, which is a text version of a file with some special character, commonly a "tab" or a "comma" used to separate elements of an observation with each observation being on a single line. Data kept in propriety form will add a barrier to reproduction, especially if that program is no longer widely available whereas data in simple text of delineated form can always be read. The most common form of data is saved as a .csv file which is a text file where each "column" of data is separated by a comma. In this case you can simply use the *read.csv()* command to read the data into the global environment of `R`. 

As a project for our introduction to `R`, we will look at gasoline consumption versus the consumption of cotton in the United States. To get the first part of our data, we will visit the U.S. Energy Information Administration's website and find the [Weekly U.S. Product Supplied of Finished Motor Gasoline](https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=PET&s=WGFUPUS2&f=W).  On this page, just above the graph, you will see a download button. Push this and choose "Download Data" and direct the pop-up window to your "./Data/" folder and save the data. You can choose a smaller file name if you wish and for our purpose we will call the file gas.csv.

In our script, after our libraries are loaded, we want to load our data and so we will use the following command line.
```R
gas <- read.csv(file = "./Data/gas.csv", header = TRUE, as.is = TRUE, sep = ",")
```
Before breaking down this command, note that there is a alternative command, *read.csv2()* which treats periods are the separators while commas are used as decimals in accordance with European standards. 

When working with commands such as this, we include in the parathesis a set of controls for the command. Some are optional and some are required. In this case, the first option we set is the location of the file and filename we want to read. Notice the use of the period to indicate that we are in our current working directory which should be the project directory. This is key because if I were to clone your repository and try to run this on my device, it will work just fine if you code your file location "relative" to your current project directory. If you try to code the location using the exact location, it would most likely be different than where I would have put the project and so we have problems. Using this period is a way to code all location "relative" to whatever the current device has set as the working directory. 

Next we set the option "header" to TRUE to indicate that the first row of the data are column headers and thus should be used as the column names in the resulting dataframe. Next we tell `R` to read the file as it is formatted meaning that characters are read as character and numbers are read as numeric. Finally, we have the option "sep" which sets the separator for the delineated file. The default is the comma, however, we can also use other options such as the bar "|". Running this command creates the object **gas** and assign the data from the file "gas.csv".  

>[!Language Lesson]
You may have encountered an error message, however, most likely the data loaded and you can see the object **gas** in the Environment. This data, however, is completely useless to you and you may not even know it. Take a closer look and notice that there are 1858 observations but only 1 variable.
>
`R` is an object-based language and the most common form of an object is a vector. To see what we mean, type `A <- "Hello world!"` in the console and push Enter. This creates the *object* called **A** and as assigned it the value "Hello world!". The thing about vectors, however, is that they must be constructed of a single type of data meaning that we can not mix numerical and character data within the same vector (unless we translate the numerical data to a character type). To see what we mean, type `is(A)` into the console and you will see 
>
>```R
> is(A)
[1] "character"           "vector"              "data.frameRowLabels" "SuperClassMethod"
>```
>
The key information here is that this is a "character" type and that **A** is a vector. We can add to this vector using the code `A[2]<-"Goodbye"` and now if we type **A** into the console we see we have both "Hello world!" and "Goodbye". We have a vector with two pieces of data, both of which are characters, and we can access them using the brackets and numbers just like with matrix vectors. Now type `A[3] <- 50` and hit enter and you see see that "50" is now listed in the environment as part of the vector object **A**. Finally, type `A[3]/5` and see what happens; you should get an error message. This is because a vector can only be of one type of data and when we entered 50 into a vector that is already made up on character types, `R` automatically assumed we meant the character 50, not the number 50. 
>
Now type `B <- 50` and then type `B[1]`. You should get a read out in the console of 50 without quotation marks as quotations is a visual cue that the output is character not numeric. Now type `B[1]/5` and you should get 10. To see why, use the *is()* command to determine what object **B** is. You should see if it a numeric vector.
>
If we need data that contains both numerical and character vectors, we can collect the different vectors in to a dataframe. A dataframe can contain any number of different vectors types but they must have be the same size and each vector must contain the same type of data. While not a precise comparison, you can think of a dataframe as an Excel spreadsheet.

In our case with our **gas** dataframe, we would like to see what it looks like to ensure we have imported the right data so we can use the `head()` command with the dataframe name listed as the option. Doing this we see we might have a problem because where we would expect to see vectors with column names and data, we see a string of letters and words and no real organizational structure. To see why, left-click the gas.csv file int he Files tab and click "View File" which will open a view of the file in the editor pane. We notice that while we would expect the first row to be headers denoting the data columns, we instead have several lines of text. This is not uncommon, especially with government data, and we can avoid pulling this data in using the `skip =` option in our `read.csv()` command.

```R
gas <- read.csv(file = "./Data/gas.csv", header = TRUE, as.is = TRUE, sep = ",", skip = 4)
```

Running this command gives us a new version of the **gas** object (note that you were not asked if you wanted to replace it, it just does so) that has 1854 observations and 2 variables. Using our `head()` command shows us the data is mostly in the expected form now with the exception of the extremely long column names. If we look at our view of gas.csv in the editor pane, we see that the labels contained spaces whereas in the console the spaces are replaced with periods. This is because spaces are not allowed in column names or in object names. 

>[!NOTE]
>DO NOT use spaces in names of objects or vectors within a dataframe. Either use camelBack (capitalization of each word with no spaces), periods, or underscores. While it is possible to use spaces, it can create major complications and more often than not will lead to errors in running your code and confusion in reading your code.

To see our dataframe we can access it in a few ways. The worse way would be to simply type in **gas** into the console. The method we use should be dictated by the goal. If we are simply checking to make sure all is well with the data, we can use the `head()` or `tail()` command. Using this for any object will give you the first six rows of the dataframe or last six rows, respectively. This gives us a feel for our data. If we want to see the entire dataframe, we can use the command `view()` which will open a spreadsheet like tab in our editor window space in which we can scroll through the entire dataframe. We can only view this, however, we can not edit anything. We can open a special editing window, but remember, we want to track all of our edits so we will avoid doing that. 
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

The syntax of the *tidycensus* package is based on an API call and you can choose from two different sources at this time: "acs" and "decennial". The former is what we will use and the latter is the data from the 10-year population census. The ACS data only goes back to about 2001 (depending on the level you are looking for) and the decennial API only have 1990, 2000, 2010, and some 2020 data. The basic command we will be using is:    [[Census API for R]]
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

Another, and more complicated, means of obtaining data is through web scraping. This is the action of utilization of the fact that website are nothing but code that is translated by your browser into a visual form. As a result, there are methods of coping the `html` code into a program, such as `R`, and then filtering the code for the information you are looking for. We are not going to do an example of this given the complexity, but there are several sources of tutorials that can be found by searching for web scraping in `R`. 

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
### We will return after these brief comments
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

Once we get the date of the sighting, we want to get the year from that date and then assign that year to the correct decade. We could do this as nested code again, but remember that we want to also have the year of the sighting within that decade so we will use *mutate()* to create two new data columns. Rather than end the mutate command and type it again, we simply place a comma at the end of the line and hit return. `R` will typically treat commas and pluses as indicators that the code line is continuing and ignore the cartage return. A nice feature of `R Studio` is how it automatically indents the next row of text to line up with the start of the previous start of the mutate command to help with readability. Here we use another of the *Luberdate* commands to pull the year from the date that we just defined and then follow that up with a final mutate command to create a new columns called "decade" which creates the decade by subtracting from the year, the remainder from the year divided by 10. The "\%\%" tells `R` to use the Modulo Operator which is the mathematical operation of returning the remainder from a division problem.[^3] Finally we want to filter the dataframe once more to include only sightings that have occurred since the 1960's.

[^3]: https://en.wikipedia.org/wiki/Modulo 

<strong> Exercise: Cleaning up the census </strong>
  
Let us practice what we have learned about pipped commands and data cleaning. When you used the census API to create the object **cen.stat** you also pulled down the data necessary to create a map of the United States. To create this map, use the following code: `plot(cen.stat$geometry)`. Notice that beyond the continental U.S., we get an odd looking image because we have the Alaskan island on the far right and also have the Hawaiian Islands and Puerto Rico. Your exercise is to write and run a code that will create a dataframe that we can map only the centennial U.S. with. The new dataframe should be named **cen.map**, contain only the columns GEOID, NAME, and geometry. To check your work, use the command *plot(cen.map)*.

<strong>Answer</strong>
  First we look up on Google the FIPS code for the three territories we want to remove and see that Alaska is '02', Hawaii is '15' and Puerto Rico is '72'. We then use the following code.
    
```R

    cen.map <- cen.stat %>%
      filter(GEOID != "02",
             GEOID != "15",
             GEOID != "72") %>%
      select(-c(variable, estimate, moe)) %>%
      arrange(GEOID)
	  
```
# Creating "new" Data

Most of the time in your research, you will have "parts" of the data that you need, but it will be at the wrong aggregation level or not be connected into a single database. This is another advantage of learning coding and how to think about data. Let's say we need to take our UFO siting data and we need to show how the number of sightings has changed, by state, since the 1970's and then we need to visualize that in a form that is easily digestible by a non-economics audience. To complete this project, we need to first determine what it is that we need, think about where to get that, and then what we might need to do to the data to bring it all together. 

We know that we have the state listed in our **ufo** object so we can use that to aggregate, assuming they are all correct, and then we know that we can draw a map with our census dataframe. A couple of obstacles we need to overcome are that the state names in our two datasets are not formatted correctly and we need to figure out how to draw different maps for each decade. Let's start by aggregating our data.

### Data Grouping and Aggregation
My first step would be a quick Google search for how to count occurrences of a variable in `R` and I would likely find that the answer is in the `count()` command in *tidyverse*. Looking up the information for this command I see that I can accomplish my goal with the following two lines of code:

```R
	ufo.st <- ufo.us %>%
		count(state, decade)
```

After running this, I get a new dataframe named **ufo.st** that contains only three vectors: state, decade, and n with the last vector being the number of times each state code was found in the data during each decade. Now I need to bridge this to the census map data. I could manually enter the two letter abbreviation for each state and the FIPS code, or I could see if someone had done it already and quick Google search shows that the BLS has a nice table that does do this. The problem is that the table is not downloadable so I am going to have to copy and paste. Since I am using a table, I am going to first try to paste the table into Excel and since that does work, I will make this a three column table rather than six, remove the extra header row at the top of the table, and make sure the table names are sufficiently simple. While I could save this as an Excel file and read that into `R`, I would prefer to keep the data in as raw a form as possible, so I will save this as a simple **.csv** file and then put in it my project directory under the **Data** folder as the file **st_abb.csv**.

If I was more comfortable with the web scraping coding in `R`, I could have just as easily written a quick code to scrape this table from the BLS website directly and used that table rather than copy and pasting through Excel. This would have been the alternative if the copy and paste did not work or if the table was rather complex. Since it was a simple table, we do it this; however, we will cite the table location in a comment in our code. With this, I can always go back and add this coding or at least will know where the data came from. Under that citation, I will write the code to pull in the data into a dataframe called **st_abb**

Unfortunately for us, the state code in the abbreviation bridge and the UFO data are in different cases. This is quickly resolved with a command in the *tidyverse* package called **to_upper()** which will change all the characters in a given vector to uppercase. We will tact this onto our pipped code that aggergates our data using the line `mutate(Abbr = to_upper(state))`

Why did we create this vector with the name "Abbr"? The simple answer is that using this name means our data is matched with the target vector in the **st_abb** dataframe making our join that much easier. Since we are unsure if the data is "correct" in the **ufo** dataframe, we will do a full join to verify everything matches up correctly. Add the line `full_join(., st_abb, by = "Abbr")` and then run the pipped code (assuming we have already read in the abbreviation bridge file. 

We then run a `summary()` command on our new data and see we have a single 'NA' and so a quick view of the data indicates that this is for the Virgin Islands so we know we can remove this using `filter(!is.na(n))`. Also in the viewer, we can verify that everything seemed to find a match, so we are good so far. 

In the census data we know the FIPS code is named GEOID so we can rename that variable in our new dataframe by adding the command `rename("GEOID" = "Code")` and then going the census maps to the **ufo** data using this common element. This is where care is important because if we try to do this, we will get an error and even solving that error may not allow us to arrive at the correct dataframe. 

<strong>Question: Why will the two dataframes not join on the GEOID vector?</strong>

<strong>Answer: They are different types. The GEOID in the **cen.map** dataframe is character while it is numeric in the new **ufo.st** dataframe. Additionally, the GEOID in the census data is "padded". </strong>

The best way to fix this problem is to add another mutate command into our **ufo.st** pipped code to change the vector type of "GEOID" and then pad it with zeros. We can do this with the nested command `mutate(GEOID = str_pad(as.character(GEOID), width = 2, side = "left", pad="0"))` and follow this up with a line to remove our unwanted GEOIDs [` filter(GEOID != "02", GEOID != "72", GEOID != "15")`].

If we now try to join, the data will join, but we will have to add an additional line of code to maintain the sf object of **cen.map**. The more direct way to preserve that object type is to join *onto* to the sf object so write the script to complete a left join (keeping the information in **cen.map**) on GEOID.

```R 
ufo.map <- cen.map %>%
  left_join(., ufo.st, by="GEOID" )
```
### Factors
Some variable are identifiers such as "male" and "female" or an individual's age. These are the variables we are most likely to create indicator dummy variables for or want to easily split the data according to those groupings. `R` allows us to identify these special variables without changing the class or type of variable by denoting them as a `factor()`. We do, however, need to show a little caution when dealing with factors because if we start removing factors, such as deleting all the males from a dataframe, we can cause `R` to throw errors. Since we are mostly at the end of our data creation, we will not worry too much about this unless we start running into errors. 

To turn a variable into a factor type, we simply use the command `as.factor(x)` and this will automatically turn the variable into a factor and the levels of the factor will be based on the unique observations within that vector. The levels of a factor are the "bins" or "ids" of the categories into which the data will be split. For example, if we had a vector of only two types of genders, the levels would be "male" and "female".  Using a factor then allows us a bit more flexibility when creating tables, plotting or graphing, and in regressions. In the case of regression, if we use a factor, we do not need to manually create the identifier dummy variables, we can simply exploit the factor vector type. Additionally, `R` will choose our reference category automatically unless we define it otherwise. Again, using the case of the vector gender, if we added the command `factor(gender)` in our regression, we might either see the coefficient for female or male, but not both. If we want to explicitly define the reference category, we can do so using the `relevel()` command with the `ref=` option where we set the desired reference category with that option. To define male as the reference category for the gender vector, we would use `relevel(gender, ref = "male")`. 

In our dataframe, we have two vectors we can image, at this point, should be factors: the vector identifying the decade of the sighting and the state the sighting occurred. At this point, we do not care about the reference category we will just let `R` decide.

# Data Visualization
Aside from using words, we can sometimes let our data tell a story by itself. Sometimes this compliments the story we are telling while other times it is a way to quickly convey information. Additionally, data visualization can be a way to build trust with the reader by allowing them to get a feel for our data. There are two key packages that we are going to be using *gt* (stands for grammar of tables) and *ggplot2* (part of the *tidyverse*).

## Graphs and Plots
One way to convey information is via graphics and plots. The two key elements that you want to keep in mind when developing a graph or image is clarity and the ability to read the image in black and white. While there are services that you can summit data to in order to get a graph, it is always best if you can create it in your code because that way, if your data changes, your graphics will change as well. The clarity aspect means that the image should not rely (too much) on text to explain to the reader what you are showing them outside of the table, a ledged, and maybe a small text description. The need for readability in black and white (greyscale) because most journals are still based on paper printing, even if they have online version. If they allow color, turning a clearly readable greyscale image into a color image is rather easy.

When dealing in graphics we also need to learn a little about color theory. Do not use colors that are hard to see and, if projecting is expected (presentations), then DO NOT use yellow or other light colors. Also make sure that the colors you are using ADD to the story rather than detract. For example, red generally implies "hot" or "bad" while blue or green generally imply "good", "cool", or "growth".

The *ggplot2* package is extremely powerful in its ability to customize and stack images. For example, we could graph several different data in a scatter plot or line graph form by overlaying the scatterplot and the line graph separately. The *ggplot*2 packages does this using *geom*s. Each graph type has its own geom and within that geom, we can set the *aesthetics* which include, at a minimum, the variables on the x- and y-axis.

### Box-Whisker Plot
We want to visualize how the sightings have changed across the decades and we also want to get a sense for outliers because we suspect we will have some. To accomplish this, we will create a box-whisker plot of our data b.y decade which shows the interquartile range, median values, and outliers, and we will use our **ufo.map** object to create this. 
  
```R
ggplot(ufo.map) +
    geom_boxplot(aes(x = decade, y = n), color = "navy") + 
    theme_bw() 
```

Breaking down this code we see the first line is calling the `ggplot()` function and we can place any "global" objects or options here. Typically we simply put the dataframe if we will be using only one dataframe, or else we can simply leave it blank. 

It is also important to note that while ggplot as a similar stacked structure to the piped code we have been using, we do not use the `%>%`, but rather `+` at the end of line.  

The next line of code defines our first (and only in this case) geom that we will be using. You can look up each geom in either the help or online to find specific options. With geoms, the first element in the command is setting the aesthetics with the `aes()` command. This is where we define what is on the x- and y-axis and any fills or colors that are meant to convey information. So in our image we want the x-axis to list the decade and the y-axis to measure the quantity of sightings. Next, we add options to change elements of the boxplot specifically. Here we change the lines in the image to navy blue to add a bit of color. We can also change things like line types or line thicknesses.

>NOTE: If were define the "color" inside the `aes()` command, we would be assignment the color to a variable because we are using a color to convey information. By using the "color" outside the `aes()` command, we are simply changing the color of an object without that color meaning anything.

If we run the code without the last `+` we will get the basic boxplot of this data and we quickly notice that we have a scale problem. To resolve this, we will go back up our code and add a line to our `mutate()` command to create a new vector with the natural log of the sightings and see if that helps. Specifically we will add the code `ln_n = log(n)` since in `R`, the `log()` operator creates the natural log or $ln()$ of a value. 

We can use `CRTL+Enter` to recreate the **ufo.map** dataframe and then change the `n` in the `aes()` command line to `ln_n` and rerun the `ggplot()` command and we get a much more usable image. 

Now we want to "clean up" the image. Specifically we want to:
- Get rid of the gray background
- Rename the axis labels to actually convey meaning
- Add a title and a footnote with the source of our data

Changing the plot area which is made up of the background, axis-tick lines and outer boarder, just to name a few, are generally handled with the `theme()` command. We can change each specific element or we can use some canned themes built into *ggplot*. For fun, try the following: `theme_dark()` and `theme_void()`. For us, we will use `theme_bw()`. 

Next we want to change the labels and we can do this with one command: `labs`. A web search will tell you the various labels that we can create with this, but the ones we will use are: "title", "caption", "x", and "y" as shown in the code block below.

```R
    labs(title = "Box Plot of UFO sightings by Decade in the U.S.",
         subtitle = "Data obtained from Kaggle.com",
         x = "Decade",
         y = "Natural Log of Annual Sightings")
```

Adding this to our `ggplot()` command and running produces a nice display of the sightings of UFOs in the US across the decades.
### Maps
We can also display this information by map since we have our data as an *sf* object. There are several geoms we can use to create plots or maps, but the `geom_sf()` is going to be the easiest since that is the form our data has taken. What will be different is that when we set up the `aes()` for this command, we do not need to specific anything because the `geom_sf()` knows that the "x and y" values are expressed in the geometry vector appended to the dataframe.  What we will specific, however, is how to fill in our states. Specifically we want to have the color of our states to demonstrate the number of sightings (or the natural log of sightings) in states for a given decade. We start with the code block below:
```R
 ggplot(subset(ufo.map, decade == 1990)) +
    geom_sf(aes(fill = ln_n)) +
    labs(title = "Natural Log of UFO Sightings by Decade in the U.S.",
         caption = "Data obtained from Kaggle.com") 
```
Notice that we use the command `subset()` when we define our dataframe because we want to show only the number of sightings in a given decade. We will discuss how to show a map with all the decades shortly.

Looking at what is produced we see a few issues. First, the tick marks on the x- and y-axis do not really mean anything and the gray background also is useless. Secondly, the legend needs a better name and the layout of the colors are just wrong because the largest values are lighter when we would expect them to be darker. Fortunately we can modify all of these items inside ggplot and will start with the plot area issues since they are the simplest. The code block is below and you can see we use the `theme()` command to change the layout (location of legend) and to turn off certain parts (`element_blank()`).
```R
 theme_bw()+
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          legend.position = "bottom",
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
		  ```

Changing the color of a fill can be complicated so expect there to be some trial and error when you do this on your own for your own work. The first thing we need to ask is if the data is discrete or continuous. If the former, you will difference commands than if the latter. Furthermore, different commands allow you to control more items and specifics. We are going to use the command in the code block below:
```R
    scale_fill_gradient2(low = "lightblue", high = "blue", na.value = NA, 
                         name = "LN(Sightings)",
                         limits = c(0, 9)) +
```
The first line redefines the color layout with the low values taking a value of a lighter blue and continuum will work toward a darker blue.  Secondly, we name the legend and then, finally, we set the limits. We do this because when we do maps for multiple decades, the scale will automatically set based on only that data and we want to ensure a constant scale so we can compare. 

The final element we want to address is creating a map for each decade. One approach would be to copy our code for each of the six decades and change the titles and logic text in the `subset()` command, but this creates a great deal of repeated elements that just clutters up the space. Instead we are going to use the `facet_wrap()` command.  This command, along with a sister command `facet_grid()` allows for multiple version of a graph to be plotted together as a single image. The `facet_grid()` command would typically be used in Macroeconomics when an author plots a serious of impulse response graphs. We will just be varying over one variable; "decade", so we use the `facet_wrap(~ decade)` with the "Tilda" (\~) being used to indicate "across" and then the vector decades.  Also note that since we want all of the decades now, we need to remove the `subset()` command from the first line of our `ggplot()` command. 
```R
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
    scale_fill_gradient2(low = "lightblue", high = "blue", na.value = NA, 
                         name = "LN(Sightings)",
                         limits = c(0, 9)) +
    facet_wrap( ~ decade)
```

## Summary Statistics / Tables
Every empirical analysis **MUST** contain a table of summary statistics of the data that is going to be analyzed. You can so statistics of the data before cleaning, but this should be used to simply support a story, the summary statistics is an essential element for the analysis to give the reader a sense of what your data is saying. Another key element with the summary statistics, or any other table, is the ability to export that table into a format that matches with however you are writing your paper. For example, if you are writing in LaTeX, you need to be able to export the table in that format. If you are using something like WORD, you may be able to output the table, if set up correctly, as an image that can be pasted; however, most editor will eventually want a editable version of the table so this leaves us with either a text export or html. 

### A Simple Approach
To create simple and quick tables of summary statistics and regression results (for most models), we can use the package *stargazer* [https://cran.r-project.org/web/packages/stargazer/vignettes/stargazer.pdf]. What is nice about this package is it allows some customization, will output in either text, HTML, or LaTeX formats, and, most importantly, can "guess" as to what type of table you want. 

We are going to create a simple summary statistics table using our new **ufo.core** object which you should be able to create using the *Class_Regression.R* script from the repository. The general form of the stargazer function is:
```R
stargazer(data, type = c("text", "html", "latex"), out = "output file name",
		 covariate.label = c(COVARIATE LABELS))
```

So for our uses at this time, lets create an HTML version of the table so we can see what we are working with. Use the command:
```R
stargazer(as.data.frame(ufo.core), type = "html", out = "./Analsysi/Output/Table1.html")
```
If we look at our FILES tab in `R Studio` we can navigate to the Analysis and Output folders and see the file we just created. Click on this and choose "View in Browser" and we will see the layout. If we would rather have an `LaTeX` version of the file, we can simply replace the "html" option with "latex" option and replace the file extension with ".txt" 

Now when we click on that new file, we will see the table formatted in our viewer. The file we saved, however, can be opened in any text editor and we will get what we see in the console output in `R Studio` which is the correct `LaTeX` code for the table. 

To clean up this table a bit, we can add some customization to it. The code block is below:
```R
  stargazer(as.data.frame(ufo.core), 
            type = "html", 
            out = "./Analysis/Output/Table1.html",
            title="Table 1: Summary Statistics",
            covariate.labels = c("No Highschool Degree", "Highschool Diploma",
				            "Some College", "Undergraduate Degree","Advanced Degree",
				            "LN of Total Population","Sightings", "LN of Sightings"))
```

The `title = ` option allows us to give the table a title, and the `covariate.labels =` allows us to replace the vector labels with more readable text. 
### A Complicated (yet highly customizable) Approach
While it takes a bit to get used to, myself included, we can create a more detailed and customizable table  using the packages *gt* and *gtsummary*.  One reason we might consider this is because the *stargazer* package does not necessarily work for all tables whereas, with some work and Google searcher, the *gt* suite can produce nearly anything. The first table we will create is a summary statistics table and the first "hack" is to make sure that there is nothing in the dataframe you are using other than what you want in the table. For example, the first table we will make will show us the mean and total sightings by decade across all states. The code block is below:
```R
  d<-ufo.map %>%
    st_drop_geometry() %>%
    select(decade, n) %>%
    tbl_summary(
      by = decade,
      type = all_continuous() ~ "continuous2",
      statistic = all_continuous() ~ c("{mean}",
                                       "{sum}",
                                       "{N_obs}")
    ) %>%
    add_stat_label(label = n ~ c("Mean", "Total", "States")) %>%
    modify_header(all_stat_cols() ~ "**{level}**",
                  label ~ "")  %>%
    remove_row_type(n, type = "header") %>%
  as_gt() %>%
    tab_header(title = md("**Table 2** Summary of Sightings")) %>%
    gtsave("Table 2.png", path = "./Analysis/Output/")
```

There is a lot to dissect in this so lets take it line by line:
1) This line we are creating a new dataframe based on our **ufo.map** object
2) We are removing the geometry from the *sf* object
3) We are keeping only what we want in our table. Specifically we want the decade and the sightings in each state. Since we do not care about the state names, we remove those.
4) This is where we start creating our table. Since it is a summary table we use the command `tbl_summary()`. When we do regression tables, we will use `tbl_reggresion()`.
	a) We define our "by" variable here
	b) This is a figment of the program as we need to define a "type" because we are going to be creating a table with statistics on different rows rather than in different columns.
	c) We are defining the statistics we want to use. Since all of our data is continuous, we use the `all_continuous()` command and then list the different statistics we want.  If we different types of variables (indicators, logical, etc.), we could define different statistics to display for those.

Let's stop here and run this to see what we get. In the corresponding output we see that we would like to make the following changes:
- Remove the "Characteristic" label
- Remove the N=48 under the dates
- Remove the wasted row with the "n"
- Rename the "Sum" and "No. Obs." rows
- Add a title to the table
- Export it into something useful

The remaining commands in our code block do just that. The `add_stat_label` allows us to rename the labels for the statistics presented for our vector "n".  Next we see the `modify_header` command which allows use to modify the top row of the table. Here we remove the "N=" by stating we only want the "level" of the factor to be listed. Quickly note the use of markdown here. That is another advantage of the *gt* package is that is allows the use of markdown to format text. The second option in this command removes the "label" of the header which was "Characteristics".  Next, we remove the header row for the "n" vector. Now run this part of the code and see how things have changed.

To add the table title and export the title, we need to convert it to a *gt* object using the `as_gt()` command. After that, we can use the commands within the *gt* package to customize further. The `tab_header` command can be used to create titles, subtitles, and footnotes and the `gtsave()` command is what helps us get the table out of `R` and into something else we can use. 

# Regression Analysis

Finally we want to run a regression looking at how various factors we have collected about states may impact, if at all, the number of sightings of UFOs. With regressions, we will be making sure our data is in the right format, looking at the command for running a simple linear regressions, and then how to display and convey the results. 

Simple linear regressions can be carried out using the command `lm(y~X, data)` where the first option is  the expression of the regressions model and the second gives the dataframe the data is located in.  When creating a regressions, we want to make sure to assign the results to an object so we can revisit them later and call on them when we create out tables. We are going to run the three models in the code block below:
```R
 mod1 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop, data = ufo.core)
 mod2 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop + factor(year), data = ufo.core)
 mod3 <- lm(ln_n ~ nohs + hson + smcol + deg + tpop + factor(year) + factor(State), data = ufo.core)
```

You can see in the second model we add year fixed effects by using the `factor()` command and then do the same thing in the third model with states. The only need here is that the variable needs to have distinct levels and cannot be continuous. We could have created the summary variables themselves, but that would have complicated our code. 

Looking in our environment tab we see these three new objects and notice that they are lists. This is where the regression results and other necessary information are held. We can see the entire results by using the command `summary()`. Doing so yields the following output in the console.

```R
Call:
lm(formula = ln_n ~ nohs + hson + smcol + deg + tpop, data = ufo.core)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.30680 -0.28473 -0.02163  0.25006  1.54566 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) -13.23831    1.50852  -8.776 3.95e-15 ***
nohs        -10.32743    4.74525  -2.176  0.03112 *  
hson          3.53486    1.28571   2.749  0.00672 ** 
smcol         6.72622    1.33816   5.026 1.43e-06 ***
deg           2.27399    3.00561   0.757  0.45051    
tpop          1.02255    0.04208  24.300  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.4663 on 147 degrees of freedom
Multiple R-squared:  0.8183,	Adjusted R-squared:  0.8122 
F-statistic: 132.4 on 5 and 147 DF,  p-value: < 2.2e-16
```

The problem with this output is that it is not very helpful if we need to put this in a paper or look at various models together. This is where the *stargazer* package comes in. If we a similar command to that above replacing the dataframe with the model results, we see we can get a nice table output with our results. 
```R
stargazer(mod1, mod2, mod3,omit = ".State.",
                         type = "html",
                         out = "./Analysis/Output/Table2.html",
                         add.lines=list(c("State F.E.", "NO", "NO", "YES")),
                         dep.var.labels = "LN(Sightings)",
			             covariate.labels=c("No Highschool Degree", "Highschool Diploma","Some College","Undergraduate Degree","Total Population", "2011 F.E.","2012 F.E."))

```

With this we can see all three of our models together in one single table. One new element is the use of the `omit = ` option. This is written in what is called *Regular Expression* and is a way of referring to text. The period is essentially a wildcard meaning anything can come before or after the word STATE, but that we want to omit anything with the work STATE in it. This removes all of the state fixed effects from our model. The second new element is the addition of the line that indicates which model has or does not have state fixed effects. Similar to `LaTeX` typesetting, we need an entry for the column of labels, and then for each of the data columns. 

An alternative to *stargazer* is the *jtools* package. With this we define our coefficients labels that we want to show and then we can use the `plot_summs()` command to get a nice plot of the coefficients and then the command `export_summs()` to export the tables into various forms. The nice thing about this version of the table export is that you can export it as a `*.docx` document and open it in Word. The code is below.

```R
library(jtools)
coef <- c("No Highschool Degree" = "nohs", "Highschool Diploma" = "hson","Some College" = "smcol",
          "Undergraduate Degree" = "deg","LN of Total Population" = "tpop", 
          "Fixed Effect: 2011" = "factor(year)2011",
          "Fixed Effect: 2012" = "factor(year)2012")

plot_summs(mod1, mod2, mod3, coefs = coef)

export_summs(mod1, mod2, mod3, coefs = coef,
             to.file = "docx", file.name = "./Analysis/Output/Reg.docx")
```


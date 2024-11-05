# Economics 691
Here you will find the course material and data that you will need for the Version Control and R parts of Economics 691 taught by Dr. Groves. Below you will find a set of links for the class to follow along as we work through the material together. 

## Download and Install
The first thing you need to do is to download some software that we will be using for the course. Please note that I should be able to help with installation on PCs, but less so with Apple devices.
1. Text Editor

   This is not an absolute requirement because most operating system have a built in text editor. That said, I have found Notepad ++ to be quite useful because it will allow you to write text in just about any language (html, markdown, plain, etc.) and will recongize the format. There are also lots of plugins that you can add depending on what you do.  
   [Download Notepad++](https://notepad-plus-plus.org/downloads/)

2. R Core

   The next thing you will need is to install the core R program. R is a free programing language that you can use for pretty much anything and is along the lines of Python. The core R program has many capabilities, however, the real power comes from the packages or "libraries" that you can add to the software. Thes are created by other users and are typically specialized for specific tasks ranging from web scraping to simple regressions.  
   [Download Core R for Windows](https://cran.r-project.org/bin/windows/base/)  
   [Download Core R for iOS](https://cran.r-project.org/bin/macosx/)

3. Git

   The next program we will download is Git. This is a version control software and is used to help keep track of changes that are made when you are writting a paper or writing code for a program or project. The idea behind version control is like a library where you can store the main information on the cloud and then update what is there when you have made changes that you want to keep. Another key feature is that it keeps a record of each time you submit changes so you can go back, or revert, to any previous version of a project.  
   [Download Git](https://gitforwindows.org/)

4. R Studio

   The last thing we will download is going to be R Studio and it is going to be our workhorse. In short, it is a graphical user interface (GUI) that allows us to access Core R, libraries we download, version control, and many other aspects of a project all in one place. It is even possible to write an entire paper within R Studio and, most importantly, it is free.  
   [Download R Studio](https://posit.co/download/rstudio-desktop/) *Scroll down for various operating system downloads.*

5. U.S. Census API Key

   We will be using a service of the U.S. Census Bureau known as an API and this requires obtaining an API Key. This is free and simply a means of keeping tabs on who is accessing the database for what use. To obtain a key, go to the [Census Key Website](https://api.census.gov/data/key_signup.html) and fill in your name, email address (really should use your z-id email address) and agree to the terms of service. Your key will now be sent to you in your email account. Make sure to save this email, because we will be using it in class.


## Setup and Configuration
Now that we have the programs installed using the default options, we need to make some configuration changes and setup some options within the software. 

### GIT Identification
The first thing we need to do is to identify yourself to `GIT` show that when we commit changes, we can know *who* made those changes. We will do this using `GIT Bash` which is the command line or shell version of `GIT` (similar to what we did in an early Tech Taco Tuesday). If you look at the set of files installed when you installed GIT on your machine, one option will be `GIT Bash`. Once that window has popped up, you are given the command prompt where you need to input the two lines of command. Use your own name and email address that corresponds to your GitHub account.

```bash
git config --global user.name "Jeremy R. Groves"
git config --global user.email "jgroves@niu.edu"
```
This will now tag all of your `GIT` work with your name and email so that we can make sure we know who has submitted what changes.

### R Library Setup
`R` is a solid program for data analysis; however, most of its power comes in its ability to use libraries. These are add-ons created by other users that expand what the program can do or simplify the way a script is written. Most of these packages are located at the CRAN website; however, others can be found on GitHub. To use them, they must first be downlaoded and then installed into `R`. Another aspect of how `R` works is that when the base `R` is updated and you install the new version, it DOES NOT overwrite the previous version, rather it installs the new version along side the older version. The reason for this is that some of the libraries fall out of use and are not updated for new `R` versions and so having an older version allows users to access those tools. The tradeoff to this system is that the libraries are installed in the version specific folder so when you update `R`, you must also reinstall all libraries. Since we do not typically run into the version problem, it becomes helpful to place all of your libraries into one common directory and then just update where `R` looks for the library files.  

To make this change, we first need to find the `Rprofile.R` file on your computers. For PC users you can find this file at `C:/Program Files/R/*current install*/library/base/R`. Navigate here using your file explorer program and then find the file Rprofile.R and right-click and choose to edit with Notepad++ or other text editor. When it opens, scroll all the way down to the bottom and then add the following text.  

```R
#My Stuff
myPaths <- c("C:/Users/HP/Documents/R/userLibrary", .libPaths())
.libPaths(myPaths)
```

Within this code, the command `.libPaths()` holds the location of where `R` looks for library files when you use the `library()` command in your script. This code updates that object by adding the user defined library location. My listing this one first, it also designates our user defined library as the default location when we install libraries for `R` to use. By placing this command in the `Rprofile.R` script, which is a script `R` runs on start up, we are always updating this variable everytime we start up `R`. 

Now lets go ahead and install a couple of libraries by opening `R Studio` and looking in the window on the left side. At the cop should be three tabs: "Console", "Terminal", and "Background Jobs". The console, which is the default, is the communications channel with `R` where we can input individual commands and see the otuput and is the most commonly used tab for us. To install our first package, we will use the base-R command `install_packages()` and the package we will install is *usethis*. To complete the task, enter the command `install_packages("usethis")` at the carrot-prompt in the console and hit enter. It may ask you to choose a CRAN site and you should just need to enter the number for your choice. Different CRAN sites will have different archieves of past versions, but all will have the most recent version of any given package. You will see some feedback in the console showing you that `R` is donwloading the package and installing it in your library file. Note that this simply installs it on your system, to use it in `R` we will still need to load it into the environment and we will do that later.

Another nice package we will use frequently is the *tidyverse* package which is a collection of several packages that make getting, clearning, manipulating, and visualizing data of various types (numbers, character strings, dates, ect.) much easier and intuitive. How do you think you would install this package?

<details>
  <summary> Answer </summary>
  
```R 
install_packages("tidyverse")
```
</details>

### R-Studio and Git/GitHub
Next we want to link `R Studio` with `Git` and allow it to access GitHub. We will discuss `R Studio` more later, but it is basically a Graphic User Interface (GUI) that combines several data tools and allows use to more easily interact with `R` which is a command-line based program. We do not have to use `R Studio` to utilize the feature of Git or GitHub because we can use the command line prompts (Git Bash) for that as well. Since `R Studio` provides a standard means of interacting with `R`, especially for novice users, we will continue to use this. With `R Studio` still open, go to the menu across the top of the screen and locate `TOOLS --> GLOBAL OPTIONS` and a smaller screen will open. Along the left side, click on the part that states `GIT/SVN` and then make sure the box at the top is checked and then in the area below "Git Executable" you need to navigate to the `git.exe` file. On a PC, it will be located at `C:/Program Files/Git/bin/git.exe`. You can either type this address in or you can naviagate to it via the Browse button. Once this box is filled in, click Apply and then Okay.

<p align="center">
  <img src="https://github.com/jrgroves/ECON691/assets/52717006/668fbf18-bb98-414e-9b94-d79e1ea9aa00"/>
</p>

Next, we need to allow GitHub and `R Studio` to talk to each other securely and for that we need a personal passkey. Fortunately someone wrote a library and program in `R` for just that purpose. Since we are not going to download the full library with these commands in them, we can use the `usethis::` command prefix and then use the command `create_github_token()`. 

```R
usethis::create_github_token()
```

This should open up GitHub on your browser and ask you to log in. Once you do that, name your passkey whatever you want and then click on the drop-down menu and choose at least 90 Days. Scroll to the bottom and click Generate Token and you will get a sting of letters and numbers. This is Hexadecimal text and make sure to copy this and then paste it either in a Word file or a text file because once you close this window, you will NEVER get this token back. If you lose it; however, you can just generate a new one and use it. Once you have copied the code somewhere else, go back to R-Studio and then type the following in the console.

```R
gitcreds::gitcreds_set()
```

You should see a set of options and you should choose `2` and then when it asks for the token, paste the hexadecimal code you copied and press enter. This will save the passkey in the R system files and you will only need to do this again if your code expires or, sometimes, when you update R.  

## Brief Tour

`R Studio` is a GUI, or Graphic User Interface, and allows us to access a command-line type program such as `R` in a more familure windows-esk environment. When you first open `R Studio` you will typically see the screen split into two panels with a long window on the left and another split-panel on the right.

<p align="center">
  <img src="https://github.com/user-attachments/assets/dc5e7e76-d5f0-40aa-9913-1de3d301d3d9"/>
</p>

The left panel is our Console and this is what `R` is reporting. You can use this to enter single commands to `R` and then see the output from `R`. One of the key elements in this screen is the version located at the top of the print out. On the right side we have two panels, each with a variety of tabs. The upper-right panel is typically showing the *Environment* for `R`. This shows that "exists" in `R` in terms of objects or functions. With a fresh start such as this, the environment is barren and so `R` can not perform any analysis or do much because there is nothing to do anything to. Other tab of interest to us is the *History* tab. This allows us to access a log of all commands issued to `R` in our session.

The lower-right panel acts as a auxiliary system that contains a file explorer, graphic viewer, and help screen. Again there are a set of tabs and the standard default is usally the *Files* tab. This is just like your file management system on your computer or windows explorer on a PC. The default location is typically the *Documents* folder on your system, but to see, we can go to the Console side and type the command `getwd()` which tells us the current working directory. Quickly notice thas as you started typing the console, `R Studio` tried to guess what you wanted in order to speed things up. This can be both a benefit and a curse so be aware and wary of it. Whatever the output shows, that is what is showing in the default view of the *Files* tab. 

If you click on the *Plots* tab, you will see a blank screen. This tabs shows us any visualizations that we create in `R`. Remember that `R` is a command-line type language so it is text based and visualizations do not get "printed" in the output. Rather `R` saves the "code" for a visulization and then either saves it as an external file (.png, .jpeg, etc.) or just keeps the code in the environment. You need a seperate program to translate the code into something visual and that is what the *Plot* tab does for us. Next is the *Packages* tab which shows all of the packages you have installed in your library and allows you to manage them here if you wish. We will not use this. The more useful tab is the next one labeled *Help*. We can input any command in the textbox in the upper-right cornor of this tab and `R` will search through all of the packages and base `R` on our system and give us information and examples of that code. To see an exammple, type in the `getwd` command and see what help shows us. The last two tabs are used if you are doing `LaTeX` or `R Markdown` in `R Studio` which we do not have time to get into. 

Across the top of the screen we see the standard "windows" type file system with our usual suspects: *File* and *Edit* all the way to *Help*. For our purposes we will mostly use the *Files* and the *Tools* command blocks. If you look to the far right along the top, you will see a drop-down arrow with the phrase **Project: (None)**. We will revisit that in a bit. Instead, click on the *Files* with your mouse and move down to the *New Files* item. This opens us a list of all the different types of files we can create within `R Studio` and you can see there is quite a bit which is why `R Studio` is so versitile. We will just lick the top choice of an *R Script*. When you click this the console window will shrink and slide down with a new window opening on the top-left side. This is, for all intense and purposes, a text editor and is where we will type our "script" that we want to run in the `R` environment. In this window, you will notice some icons across the top of the tab. The disk is to save the file and the *Run* icon will run the line the curser is located on whereas the *Source* icon will run the entire script. If we open additional scripts, they will show up in this window under different tabs along with any data views we use. 


# Project Management and GitHub

Whether you are by yourself, working with a team, or, more to your cases, working with an advisor, having an effective "project" setup will help you organize your thoughts and ideas and provide an much easier way to interact with an advisor or co-author. While `R Studio` has a built-in project system, we are going use this in conjunction with `GitHub` to ensure there is a copy of our information we can always get to if needed. Organization also helps you work with others and remember what you did and why when you revisit a project either an hour or a year after you started it. Organization also helps you should you need to prove or verify your work either to a professor or a journal when you submit for publication. This later issue, that of reproducability, is becoming even more important given the number of cases of academic misconduct being uncovered, even among Nobel Prize winners. We are going to organize our project in `R Studio` and then back it up in a GitHub Repository for both protection and for easier remote access by ourselves or co-workers. We start the process in reverse however.

## Create Repository on GitHub

A Repository is a place on the GitHub cloud where you can keep relevant files for any given project. You have each setup a profile on `GitHub` and are all part of the GitHUb Classroom environment for this class. Go there and check out the "Groves_R" assignment to clone a local copy of the repository for this class. Now go to [GitHub](www.github.com), log into your account, and find the new local repository for the Groves_R assignment on the left-side menu and click it. To ensure you are doing this correctly, you should see a message in the README.TXT file that indicates this is the Repository for the in-class work for the Introduction to R part of Economics 691. 

## Create Project in R-Studio

As mentioned, `R Studio` has a system built into it that acts as a means for keeping information and data on a project together called *PROJECTS*. We can create a project on our computer only, or we can link it to a GitHub or similar type repository. Creating projects, however, is of little use if we do not know where we left them so we are going to use the File Explore feature in `R Studio` to create a **Projects** directory somewhere on our computer. To do this, navigate to the *Files* tab in the lower-right screen in `R Studio` and navigate to where you want your **Projects** directory to be located. Once there, click on the *New Folder* icon across the type of the *Files* tab and create a **Projects** directory.

Next we will return to that drop-down arrow in the upper-right corner that says **PROJECT(none)**. Click on this and choose "New Project". A small screen will open on your computer and you need to click the Version Control banner and then click on the Git banner.  

<p align="center">
  <img src="https://github.com/jrgroves/ECON691/assets/52717006/64332c4b-b877-40b7-bc5b-a5c91569ecc3"/>
</p>

The window that is now open is asking for the URL from the repository that you created on `GitHub` which you can get by simply navigating to the repository in your web browser and copy the URL from the location bar at the top of the browser. Once copied, you can paste in the URL space and that will typically auto populate the Project Name dialog box below it. The third box is were it will live on your computer and if not already showing your **Projects** directory, click the browse button and navigate to that directory. Once you are there and click open, click the "Create Project" button on the screen.  

<p align="center">
  <img src="https://github.com/jrgroves/ECON691/assets/52717006/6a2e5628-6035-4016-9ab1-997a0459726a"/>
</p>

Once you hit "Create Project" it will appear that `R Studio` reloads and we will be ready to start working. The other thing this action does is "clones" the repository at that URL you listed and populates your computer with anything located in that reponsitory. You can verify this by looking at the *Files* tab and notice that it now switches to a newly created directory within your **Projects** directory with the same name as your repo on GitHub and sets the working directory in `R` to that location. To verify this, type the `getwd()` in the console and see what is reported.  The last thing you should notice that is different is that there is now a new tab in the upper-right window of `R Studio` called *Git*. Under this tab is one way we can interact with both `Git` and GitHub.

## Your First Push
Version control allows us to keep track of changes both by us and anyone else that has permission to access our repository. It does not, however, keep track of all of our key strokes and it can only track what we tell it to track and it takes a "snapshot" only when we tell it to. Whenever we create or modify a file, version control, or in this `Git` will recongize that it is different than what is currently in the repository, but that is the extent of what it will do on its own. We we complete our modifictaions and want to update what we have on our main or branch, we must first "stage" the files. 

We can stage as many files as we want and we can think of "staging" as placing our newly changed files in an envelop that we are going to "mail" to our repo. To actually submit the changes so that version control will commit them to "memory", we have to commit them. When we commit a set of changes, we have the option to add a comment to our commit to tell ourselves or others what we changed in this part that is being committed. Once we commit, version control creates a new "version" of the project using those files and creates a history which contains the older versions of our project prior to those changes that were committed. To summarize the process using an example, lets say we have a some sort of project that is out in the world, such as a software program. Overtime we decide we need to add features, remove obsolute features, or fix errors, but we do not want to mess up what we have that works. This is where creating a "branch" comes into play. A branch starts with a copy of what we currently have "out in the world" and we can "check out" the program, make changes, and then commit those changes to the branch. Let's say our changes are going to take a month to finish; we would want to commit our work each day or couple of hours so we do not loose anything, but by committing it via version control, if we every realize we were going in the wrong direction, we can always recover some previous version. Only after we have made all of our changes and run the branch program to test it, will we merge our branch back to our main which then replaces the original program with the new version while still keeping a historical version of the original. 

To pratice this in our example, we are going to modify our README.md file inside of `R Studio`. The easiest way to do this is to double-lick on the *README.md* file in the file manger and notice that a new screen opens at the top of the left-side of `R Studio` and you should see the following:

```bash 
# Groves_R
This is the in-class work for the Introduction to R in Economics 691. You will need to copy of the location or URL of this repository which you will find in the address bar of the browser.
```
Using what you recall from previous classes on markdown, add a sub-heading with your last name and then a line under that indicating in some way that this is you copy of the class repository and then save this new file using the disk icon in the upper-left of the editor window. If you get lost or do not recall, an example is below.
<details>
  <summary> Example: Push and Pull #1 </summary>
  
```bash

# Groves_R
This is the in-class work for the Introduction to R in Economics 691. You will need to copy of the location or URL of this repository which you will find in the address bar of the browser.

## Groves_R
This is my own personal copy of the main repository for the Introduction to R in Economics 691 taught by the balding guy!
```
</details>

We will notice when we save this file that we get some action in the *Git* tab in the upper-right "enviornment" window. You should now see the "README.md" file in the window with a blue square to the left of the file name with a white "M" in the box. This indicates that a file that is part of the repository has been modified but has not yet been staged or commited. To verify this, return to the web browser and look at the "README.md" file and notice your new line is not present. The same would be true if we look at the local repository on your computer; however, the local version of the "README.md" file saved to your computer would have changed. To get this change to the local repository, we need to stage and then commit the change. If you click on the empty box in front of the "README.md" file you will see the blue box shift to the left side indicating that it is now staged and ready to commit. To "commit" this file we click on the *Commit* icon which will then open a new window. In this new window, we will see three smaller panels. The upper-left shows us all the files that are staged, the upper-right is going to be where we can add our comment, and the lower panel is a "comparison" or "dif" that shows us additions, deletions, and what remains unchanged bewteen the stagged file and the one in the previous commit. 

You should see the original text in gray and your new addition highlighted in green. Had we deleted something from the what was originally opened, we would see that highlighted in red. We will add the comment "Added our personal touch" to the comment box and then click on the *Commit* button. What this has done is taken a snapshot of everything we had stagged and "committed" it to the local repository. Switch over to your web browser and refresh your `GitHub` reponsitory for our project and notice that nothing changed! This is because our commit ONLY added our changes to the version control tracking files on our local computer. If we want to send these changes, along with updating the files in our repository, we have to "Push" them up to the cloud. If you return to `R Studio` you will notice in the *Git* tab an icon that says "Push" and by licking this, it will send our version control file and copies of the updated files in our project that we had committed, to the cloud. Now return to the web browser, refresh, and notice the "README.md" file has changed.

## Your First Pull

Since you do not have a co-author on this project, we need to simulate someone making a change to the files on the repo. To simulate this, go to the main page of the responsitory on your web browser and notice the structure already cloned there includes a directory called "Data." For our purposes this is going to be home to all of our raw data from which we will work and that we obtained elsewhere. If you click here you will see a single ".csv" file that we will use in our work and assignments already present. Returning to the home directory by clicking the link at the top next to the branh ID, click on the "Add file" button and create a new file. File organization is also extrememly important and so we will start setting up our project directory here on the web version of our repository. Generally we want to keep our work local, but this is a way to simulate a co-author or advisor making a change. Where you place the name of file type the following: ``Build\Code\First.R``. This is going to create a new directory, a sub-directory, and a new file called "First" and it will create it as an `R script` file. Copy the code from the box below into the open editor and then commit the changes. You do not have enter a commit comment, but something like "first commit" would be fine. 

```R
rm(list=ls())
A <- "Hello world!"
A
```
You have created a new script file and placed it in the directory structure **Build --> Code** which is where we will hold all of our code that we use to clean and construct the core dataset for our project. Switch over to `R Studio` and look in the *Files* tab in the auxilary window, navigate to and double-click "First.R". You can't can you? This is because the only place the changes are held are on the cloud and possibly a co-author's local system. You need to get the updated version of the project down to your local system and you do that my pulling it from the repository. Above the directory window in the environment panel of `R Studio` under the **git** tab you will see a button with a down arrow and the work "pull". CLick that.

Now you will see the new directory **BUILD** and if you double-click that you will see the **Code** directory and in there you will find your "First.R" file. Click this and it will open in your editory window. What this code will do is the following:

- The first line will completely clear the environment. The *rm()* command will remove anything within its arguement (inside the parenthesis) and the text `list = ls()` is using the *ls()* command to list everything in the environment (because the argument space is left to the default by leaving it empty).
- The second line assigns the character string "Hello world!" to the object **A**. `R` is an object based language and so anything that `R` uses must be assigned a unique name and that "thing" can be any number of types of objects or classes. What we have here is a string. Notice that we use the syntax "<-" to assign the character string to the object **A**. This is because the syntax "=" indicates an equality and that is not what we are doing, we are assigning.
- The third line then recalls the object **A** and the output is printed in the console. We can now refer to the character string "Hello world!" by its object assignment.

To run this script, we "source" the script. We can do this two ways: via the editor and via the console. With the editor we only need click the button labled "Source" in the upper-right side of the editor. This will run the script and "echo" each step in the console meaning it will print each line of code (up to some limit). You should see the following in your console after you click on the button.

```R
> rm(list=ls())

> A <- "Hello world!"

> A
[1] "Hello world!"
```

A second way is to source the script directly in the console which is basically what the button did for us. If you look at your output, at the top you will see `source("~/Projects/Groves_R/Build/Code/First.R", echo=TRUE)`. What the *source()* command does is runs the file that is listed in its arguement and, in this case, the option "echo" is set equal to TRUE which means it is "turned on" so we see each line of output. We also see that in the file name we have to list the exact location of the file and in that text we see the tilda symbol (\~). This represents the main path that is currently saved in the R profile. You can find this by using the command *path.expand('~')*. While this is fine, it is not good to use this if you are going to be working with others because their computer structure may not be the same as yours. 

To enhance the reproducability of any path that we use, we want to instead refer to the current workind directory which we can find using the command *getwd()*. The advantage of using projects in `R Studio` is that the working directory is set for us as the location of this particular project so what you should see is the main path from above along with the location of where you decided to place your projects on your local computer followed by the name of the project. We can access this in our code by using the period syntax. Therefore, to run our script, we can instead type `source("./Build/Code/First.R")` in the console. Notice when we hit return, nothing happens really. This is because the default option for "echo" in the *source()* command is set to FALSE or "off". However, something did happen because if we now type `A` in the console and hit enter, you will see your message.

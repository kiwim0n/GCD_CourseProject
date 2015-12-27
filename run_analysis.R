# run_analysis.R
# Written by: Kirsten Petersen, 12/27/2015
# Source: https://github.com/kiwim0n/GCD_CourseProject
#
# This R script takes a dataset of accelerometer and gyroscope measurements
# from test subjects participating in various activities.
# 
# NOTE: the script assumes you have downloaded the data set and unzipped it into
# the working directory, where the run_analysis.R script is also located.
# The data can be downloaded here: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You can set the working directory in R with the setwd() command like this:
# setwd("/Users/nuthouse/Documents/Coursera/Getting Cleaning Data/Course Project")
#
# The script produces an output file, tidy_output.txt, which contains a summary
# of means of all mean and standard deviations measures by test subject and 
# activity.

# Set file locations for data set to import
filetestsubject <- "./UCI HAR Dataset/test/subject_test.txt" 
filetestx <- ".//UCI HAR Dataset/test/X_test.txt"
filetesty <- ".//UCI HAR Dataset/test/y_test.txt"
filetrainsubject <- "./UCI HAR Dataset/train/subject_train.txt" 
filetrainx <- ".//UCI HAR Dataset/train/X_train.txt"
filetrainy <- ".//UCI HAR Dataset/train/y_train.txt"
filefeatures <- ".//UCI HAR Dataset/features.txt" 

# Read in data from data set
print("Reading data sets (this may take a few minutes)...")
testsubject <- read.table(filetestsubject) 
testx <- read.table(filetestx)
testy <- read.table(filetesty)
trainsubject <- read.table(filetrainsubject) 
trainx <- read.table(filetrainx)
trainy <- read.table(filetrainy)

# Stitch columns from the data sets into data frames
testdata <- cbind(testsubject,testy,testx)
traindata <- cbind(trainsubject,trainy,trainx)

# Stitch test and train data together
print("Combining data sets...")
fulldata <- rbind(testdata,traindata)

# Read in the variable names from the features file
print("Setting column names...")
mycolnamesdata <- read.table(filefeatures) 

# Create a character string of variable names and prepend "subject" and "activity"
mycolnames <- c("subject","activity",as.character(mycolnamesdata[,2]))

# The variable names include characters that are not valid in column names; 
# use make.names() to make them valid and use names() to set column names.
# Note: unique=TRUE is critical because otherwise you get duplicate names.
mycolnamesnew <- make.names(mycolnames, unique = TRUE)
names(fulldata)=mycolnamesnew

# Using grep, create a subset of names that match the selection we want
# We only want to select variables for standard deviation and mean
mypattern <- "std\\.|mean\\.|activity|subject"
mycolnamessubset <- grep(pattern=mypattern,mycolnamesnew,value=TRUE)

# Subset the full dataset, selecting only variables for standard deviation 
# and mean
selectdata <- select(fulldata,one_of(mycolnamessubset))

# Rename the activities with descriptions
# It would be better to read in activity_labels.txt, rather than
# having this part hard-coded in, but this manual method does work.
selectdata$activity[selectdata$activity == "1"] <- "Walking"
selectdata$activity[selectdata$activity == "2"] <- "Walking Upstairs"
selectdata$activity[selectdata$activity == "3"] <- "Walking Downstairs"
selectdata$activity[selectdata$activity == "4"] <- "Sitting"
selectdata$activity[selectdata$activity == "5"] <- "Standing"
selectdata$activity[selectdata$activity == "6"] <- "Laying"

# Unfortunately, I did not have time to rename the variable names to
# something more readable. Ideally abbreviations such as "mag" would be spelled
# out, and duplicated dots would be removed.

# Make the data tidy
# First, melt the data so we can summarize by subject and activity
df_melt <- melt(selectdata,id =c("subject","activity"))

# Find the mean of all values by subject and activity
mytidydata <- dcast(df_melt,subject+activity~variable,mean)

# Print output
write.table(mytidydata, "./tidy_output.txt", row.names=FALSE)


setwd("/Users/nuthouse/Documents/Coursera/Getting Cleaning Data/Course Project") 

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
mypattern <- "std\\.|mean\\.|activity|subject"
mycolnamessubset <- grep(pattern=mypattern,mycolnamesnew,value=TRUE)

# Subset the full dataset 
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




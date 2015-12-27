name of script: run_analysis.R

## Description of the dataset

The original data set can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A description of the dataset can be found here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

There is also a README.txt file with the dataset, explaining how the data was generated.

The data is a set of accelerometer and gyroscope measurements from 30 test subjects participating in 6 activities, such as walking and standing. The data was initially broken up into a "train" set and a "test" set, each with the same measurements.

The measured variables are called "features" in the data set and are described in the features.txt file.

## Usage

The script assumes that the dataset will be unzipped into the working directory, the same directory that the run_analysis.R script is located in.

To run the script, type the following in R:

> source("run_analysis.R")

## Steps in the script described

### Reading in the files

The data in the dataset is laid out a bit strangely. There are 2,947 lines in subject_test.txt, y_test.txt, and X_test.txt. The script stitches these three files together into one data frame. There are 7,352 lines in subject_train.txt, y_train.txt, and X_train.txt. 

> subject_test.txt - lists the numeric IDs for each test subject
> y_test.txt - lists the numeric IDs for each activity
> X_test.txt - lists measurements for 561 variables for each observation 

> subject_train.txt - lists the numeric IDs for each training subject
> y_train.txt - lists the numeric IDs for each activity
> X_train.txt - lists measurements for 561 variables for each observation

The script first reads in each of these files.

Next, the script uses cbind() to stitch together the test data into one data frame with 563 columns and 2,947 rows.

Then we use cbind() to stitch together the training data into one data frame with 563 columns and 7,352 rows.

### Setting Column/Variable Names

The script reads the features.txt file to map the variables to their names. We create a character vector from these names, prepending "subject" and "activity" for the first two columns.

The make.names() function is called on the column names to remove characters that are invalid in column names, and unique=TRUE is used to avoid duplicate column names.

The column names are set using the names() function.

There were 66 variables that matched the selection.

### Subset the dataset, taking only standard deviation and mean data

Refering to the features_info.txt file included with the dataset, we see that "std" indicates standard deviation, and "mean" indicates mean values. I decided to exclude "mean frequency" values as that is not really a measure of mean, but rather a description of mean.

The grep() function was used to create a subset of names that match the selection we want, which is anything with "std." or "mean." in the variable name.

### Subsetting the data

The select() function with one_of() was used to subset only variables containing "std." or "mean." in the name. The "subject" and "activity" columns were also retained for later summarization.

### Naming the activities

The script manually sets the activity names based on the information given in the activity_labels.txt file.

### Make the data tidy

Finally, the script uses melt to set the "subject" and "activity" variables as indexes.

This allows us to use dcast to summarize the data by subject and activity, printing the mean values for all standard deviation and mean variables for each subject+activity combination.

There are 30 subjects and 6 activities, so the final tidy output of mytidydata is 180 rows.

## Files

run_analysis.R - script that parses the data and summarizes means of standard deviation and mean variables for each subject and activity.

activity_labels.txt - contains the mapping of activity IDs to descriptive names.

features_info.txt - describes the variable names.

features.txt - contains the mapping of variable IDs to descriptive names.

README.txt - provides more data on how the data were generated.

test/subject_test.txt - the subject ID column of the test data.

test/X_test.txt - the test data for all 561 variables.

test/y_test.txt - the activity ID column for the test data.

train/subject_train.txt - the subject ID column of the train data.

train/X_train.txt - the train data for all 561 variables.

train/y_train.txt - the activity ID column for the train data.


## Variables



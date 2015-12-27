---
title: Getting & Cleaning Data Course Project - Readme
---

This R script *run_analysis.R* takes a dataset of accelerometer and gyroscope measurements from test subjects participating in various activities. The script cleans up the data and then outputs a tidy data set that displays means (averages) of all mean and standard deviation variables by test subject and activity.

The script assumes you have downloaded the dataset and unzipped it to the working directory, where the run_analysis.R script is also located.

The data can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Details about the data set can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You will need the following packages installed:

> dplyr
> data.table
> reshape2

To run the script, type the following in R or RStudio:
> source("run_analysis.R")

To view the full dataset, type:
> fulldata

To view the dataset containing only standard deviation and mean data, type:
> selectdata

To view the tidy data set, type:
> mytidydata

> Or, view the tidy_output.txt file in the working directory.   




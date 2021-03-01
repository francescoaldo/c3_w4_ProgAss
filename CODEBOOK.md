---
title: "CODEBOOK"
author: "Francesco Aldo Tucci"
date: "3/1/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Codebook for Getting and Cleaning Data Course Project 

The run_analysis.R script performs the necessary steps to format and adapt the 
data for the 5 steps required as per the Course Project's Instructions. 

DATA DOWNLOAD 

The data set was correctly downloaded from the link provided and extracted under the folder called UCI HAR Dataset (see setwd() argument). 

ASSIGN DOWNLOADED DATA 

features <- features.txt : 561 rows, 2 columns 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ (see the features_info.txt file for
additional info). 

activity_labels <- activity_labels.txt : 6 rows, 2 columns 
Lists the (names of the) activities performed when the corresponding measurements were taken, together with the corresponding codes. 

subject_test <- test/subject_test.txt : 2947 rows, 1 column 
Lists the numbers ("id") of the 9/30 volunteer test subjects being observed 

subject_train <- test/subject_train.txt : 7352 rows, 1 column 
Lists the numbers ("id") of the 21/30 volunteer train subjects being observed 

x_test <- test/X_test.txt : 2947 rows (obs), 561 columns (variables) 
Contains recorded features of test data 

x_train <- test/X_train.txt : 7352 rows (obs), 561 columns (variables)
Contains recorded features of train data 

y_test <- test/y_test.txt : 2947 rows (obs), 1 columns (variable) 
Contains recorded features (activities' codes) for test data 

y_train <- test/y_train.txt : 7352 rows (obs), 1 columns (variable)
Contains recorded features (activities' codes) for train data 

Note the consistency between the number of rows in train and test data,  respectively 

MERGING TEST & TRAIN DATA IN ONE DATA SET 

Xdata (10299 rows, 561 columns): created by "merging" ("appending" in STATA language) x_train and x_test using rbind() function 

Ydata (10299 rows, 1 column): created by "merging" ("appending" in STATA language) y_train and y_test using rbind() function 

subject_all (10299 rows, 1 column): created by "merging" ("appending" in STATA language) subject_train and subject_test using rbind() function 

merged.data (10299 rows, 563 column): created by merging Subject, Y and X using cbind() function 

EXTRACT ONLY MEAN & STD MEASUREMENTS 

tidy.dataset (10299 rows, 88 columns): created by subsetting merged.data, selecting only the columns 'subject', 'code' and the ones corresponding to  measurements on the mean and standard deviation (std) for each measurement 

DESCRIPTIVE ACTIVITY NAMES 

The codes (integer) in the 'code' column of  tidy.dataset has been replaced with the corresponding activity label taken from second column of the activity_labels object 

DESCRIPTIVE VARIABLE (i.e. MEASUREMENTS) NAMES 

The 'code' column in tidy.dataset has been renamed into 'activity' 

Changes in variables names: 

All Acc in col. names replaced with 'Accelerometer' 
All Gyro in col. names replaced with 'Gyroscope' 
All BodyBody in col. names replaced with 'Body' 
All Mag in col. names replaced with 'Magnitude' 
All columns starting with character f: f in col. name replaced with 'Frequency' 
All columns starting with character t: t in col. name replaced with 'Time' 

FINAL STEP: FROM TIDY DATA, CREATE INDEPENDENT SET OF DATA 

THIS final.dataset CONTAINS AVERAGES FOR EACH MEASUREMENT, SUBJECT AND ACTIVITY 

final.dataset (180 rows, 88 columns): created by first grouping by the "dimensions" of interest, so to speak (i.e. subject and activity), and then  taking the meas of each variable (column) for each activity and each subject grouped as such. Please see the comment to the command on this. 

EXPORT final.dataset INTO .txt FILE NAMED "c3_w4_FinalTidyData" 

PLEASE NOTE THAT FILE NAME IN run_analysis.R ALSO CONTAINS FILE PATH 
                    (you should get rid of it!) 

PLEASE SEE COMMENTS IN THE run_analysis.R FILE FOR ADDITIONAL DETAILS 



```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

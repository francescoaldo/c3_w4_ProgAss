setwd("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset") 
library(dplyr) 

# source('~/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/c3_w4_ProgAss_Get_Data.R') 

## DISCLAIMER 

# This Assignment relies heavily on the content presented during the course as 
# well as additional references listed at the end. 
# Any decision on how to proceed and present my work was especially done with 
# references [1] and [3] in mind. 

# Let's merge the data "step-by-step", starting from the subjects, with row bind: 
subject_all <- rbind(subject_train, subject_test) 
# Let's get a look at the data 
str(subject_all) 
head(subject_all, 3) 
tail(subject_all, 3) 
table(subject_all) # this will give us the number of observation per subject 

# x-files (pun intended) contains measurements; y-files, labels 
Xdata <- rbind(x_train, x_test) 
Ydata <- rbind(y_train, y_test) 
# We similarly perform some exploratory commands such as 
# str(Xdata) ; summary(Xdata) 
# However, we omit them --long output! 

## STEP 1 

# Let's put the data together  
merged.data <- cbind(subject_all, Xdata, Ydata) 
class(merged.data) 
dim(merged.data) # it's a 10,299 x 563 data frame 
# Call colnames(merged.data) to see the names of all 563 variables 

# To select only the data we are interested in, let's use --well-- the select() 
# function from the dplyr package 
# (as shown in Week 3 lecture on dyplr Basic Tools) 

# Aim: select all variables (col.s) containing "mean" or "std" in their name 
# (accounting for possible upper case letter, see e.g. colnames(merged.data)[559]; 
# we can use the contains() f. with its default argument ignore.case = TRUE) 

## STEP 2 

# First assign the merged data set to the tidy one we want to create; 
# then actually get started with the tidying 
# NOTE: we need the subject, code, mean and std variables! 
tidy.dataset <- merged.data %>% select(subject, code, 
                                       contains("mean"), 
                                       contains("std") 
                                       ) 

# A quick-and-dirty way to see whether data look like how we expected them to 
class(tidy.dataset) 
dim(tidy.dataset) # it's now a 10,299 x 88 data frame 
# str(tidy.dataset) 
# summary(tidy.dataset) 

# The second column in our (soon to be) tidy data is "code", i.e. the code 
# identifying the activity performed: 
# colnames(tidy.dataset)[2] 
# Let's make it clear we're talking about activities, and label them accordingly 
# But first... 

## STEP 3 

# We want to use descriptive activity names to name the activities in the data set 
# We can use the labels already provided in the 'activity_labels' data set! 
# We need to match the code in the rows and get the values from col.2 ('activity') 
tidy.dataset$code <- activity_labels[tidy.dataset$code, 2] 
# Also, notice that calling class(tidy.dataset[,2]) returns as "integer" 
names(tidy.dataset)[2] = "activity"  
# We can check by calling colnames(tidy.dataset)[2] again 

## STEP 4 

# Let's give clear, meaningful (albeit long) variable names by substituting... 
# For this, we'll make use of the gsub() function 
names(tidy.dataset)<-gsub("Acc", "Accelerometer", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("Gyro", "Gyroscope", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("BodyBody", "Body", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("Mag", "Magnitude", names(tidy.dataset)) 
# Let's use the regular expression special symbol to get all names starting with t and f  
names(tidy.dataset)<-gsub("^t", "Time", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("^f", "Frequency", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("tBody", "TimeBody", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("-mean()", "Mean", names(tidy.dataset), ignore.case = TRUE) 
names(tidy.dataset)<-gsub("-std()", "STD", names(tidy.dataset), ignore.case = TRUE) 
names(tidy.dataset)<-gsub("-freq()", "Frequency", names(tidy.dataset), ignore.case = TRUE) 
names(tidy.dataset)<-gsub("angle", "Angle", names(tidy.dataset)) 
names(tidy.dataset)<-gsub("gravity", "Gravity", names(tidy.dataset)) 
# We can now check the variables names with a simple names(tidy.dataset) call 

# An example of inspection: 
tidy.dataset[40:42, c(1, 2, 3, 70)]   # subject 1, activity SITTING, TimeBodyAccelerometer.mean...X, TimeBodyGyroscopeJerk.std...Z 
tidy.dataset[400:402, c(1, 2, 3, 70)] # subject 3, idem, idem, idem 

## STEP 5 

# Finally, we are asked to create "a second, independent tidy data set with the 
# average of each variable for each activity and each subject" 

# We want to obtain a data set in which observation will be like: 
# Average of variable k (stored in column k+2), for subject i, for activity j, or 
# avg_ijk in short 
# Note that since we have 30 subjects in total, each performing 6 activities, 
# and 88 different measurements (our variables, i.e. the columns), 
# we expect to end up with a (30*6) x 88 = 180 x 88 data frame 

# The across() function allows to apply a transformation such as mean(),  
# feasible for summarise(), to multiple variables (in this case, to all of them, 
# using the everything() argument). 
# Note that across() with argument everything() substitutes the summarise_all() 
# function, now superseded (check the help page for 'summarise_all') 

# Thanks to the dplyr package, we can also employ the 'pipeline operator' 
# (I consulted reference [2] on the matter) 

final.dataset <- tidy.dataset %>% 
       group_by(subject, activity) %>% 
       summarise(across(everything(), mean)) 
# Let's check if its dim() is congruent with our expectations: 
dim(final.dataset) # it is 
# Note, however, that we have created a 'tibble' 
class(final.dataset) 
# Finally, let's export the data set in .txt format (without row names) 
write.table(final.dataset, "/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/c3_w4_TidyData.txt", row.name=FALSE) 
## NOTE: THE FILE NAME CONTAINS MY OWN DIRECTORY PATH! 
## It has to be changed to be executed properly so as to get the .txt data set! 
# USE: 
# data <- read.table(file_path, header = TRUE) ; View(data) 
# to see the content of the .txt data set created above. 

## REFERENCES 

# [1] "Getting and Cleaning the Assignment", by thoughtfulbloke, 
# available at https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ ; 
# [2] "Pipes in R Tutorial For Beginners", by Karlijn Willems, available 
# at https://www.datacamp.com/community/tutorials/pipe-r-tutorial 
# [3] Wickham, H. (2014), "Tidy data", Journal of statistical software, 59(10), 1-23 ; 
# [4] De Jonge, E., & Van Der Loo, M. (2013), "An introduction to data cleaning 
# with R", Heerlen: Statistics Netherlands 





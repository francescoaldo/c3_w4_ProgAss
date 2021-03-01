setwd("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset") 
library(dplyr) 

features <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/features.txt", 
                       col.names = c("n","functions")) 

activity_labels <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("code", "activity")) 

subject_test <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject") 

x_test <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/test/X_test.txt", col.names = features$functions) 

y_test <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/test/y_test.txt", col.names = "code") 

subject_train <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject") 

x_train <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions) 

y_train <- read.table("/Users/francescoaldo/Desktop/COURSES MATERIAL/R DATA SCIENCE - Coursera/c3_w4_ProgAss/UCI HAR Dataset/train/y_train.txt", 
                      col.names = "code") 





















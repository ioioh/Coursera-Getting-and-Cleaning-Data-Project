Coursera-Getting-and-Cleaning-Data-Project
==========================================

April 2014

Coursera: Getting and Cleaning Data Project, April 2014

Files included:
===============
run_analysis.R - R script
CodeBook.md - describes the variables, the data, and all transformations to clean the data
README - this README, which provides the scripts and explains how all of the scripts work and how they are connected.  

Script Notes:
=============
The following five steps were taken to accomplish the project tasks:

## Step 1, Download file, Unzip, Read data sets
## 1.1 Download zipfile from URL provided
AfileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(AfileUrl, destfile="~/Desktop/Getting and Cleaning Data/assignment/data", method="curl")
dateDownloaded<-date()
dateDownloaded

## 1.2 Unzip downloaded zipfile
unzip("./data")

## 1.3 Read all relevant data files
setwd("./UCI HAR Dataset/test")
TestD1<-read.table("X_test.txt")
TestL1<-read.table("Y_test.txt")
TestID<-read.table("subject_test.txt")
setwd("..")

setwd("./train")
TrainD1<-read.table("X_train.txt")
TrainL1<-read.table("Y_train.txt")
TrainID<-read.table("subject_train.txt")
setwd("..")

Labels<-read.table("features.txt")
Activity<-read.table("activity_labels.txt")

## Step 2, Merge training and test sets
## 2.1 Add variable Labels (features.txt) as Column Names to both the test and training data sets
columnNames <- Labels$V2
names(TestD1) <- columnNames
names(TrainD1) <- columnNames

## 2.2 Merge test and training set activity labels (Y_test.txt, Y_train.txt) to data
TestD1<-cbind(TestL1, TestD1)
colnames(TestD1)[colnames(TestD1)=="V1"] <- "Activity"
TrainD1<-cbind(TrainL1, TrainD1)
colnames(TrainD1)[colnames(TrainD1)=="V1"] <- "Activity"

## 2.3 Merge IDs ("subject_test.txt", "subject_train.txt") to test and training sets
TestD1<-cbind(TestID, TestD1)
colnames(TestD1)[colnames(TestD1)=="V1"] <- "Subject ID"
TrainD1<-cbind(TrainID, TrainD1)
colnames(TrainD1)[colnames(TrainD1)=="V1"] <- "Subject ID"

## 2.4 Merge test and training sets
mergedData<-rbind(TestD1, TrainD1)

## Step 3, Extract mean and standard deviation for each measurement 
DataSubset <- mergedData[ , grep("Subject ID|Activity|mean\\(\\)|std\\(\\)",colnames(mergedData))]

## Step 4, Appropriately label the data set with descriptive activity names
## 4.1 Replace values with descriptive activity labels provided in original data
DataSubset$Activity<-factor(DataSubset$Activity, labels=Activity$V2)

## 4.2 Save to tab separated text file
write.table(DataSubset, "~/Desktop/Getting and Cleaning Data/assignment/tidydata.txt", sep="\t")

## Step 5, Create a second tidy data set with average of each variable for each activity and each subject

## 5.1 Load reshape2 library to allow for melt and dcast
library(reshape2)

## 5.2 Melt then dcast data to new data frame
MData<-melt(DataSubset, id=c("Subject ID", "Activity"))
FData<-dcast(MData, MData[,1] + MData$Activity ~ variable, mean)

## 5.3 Rename Subject ID and Activity columns
colnames(FData)[colnames(FData)=="MData[, 1]"] <- "Subject ID"
colnames(FData)[colnames(FData)=="MData$Activity"] <- "Activity"

## 5.4 Save to tab separated text file
write.table(FData, "~/Desktop/Getting and Cleaning Data/assignment/tidyMeandata.txt", sep="\t")


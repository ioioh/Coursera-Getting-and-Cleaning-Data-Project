## Coursera: Getting and Cleaning Data Project, April 2014

##You should create one R script called run_analysis.R that does the following: 
## -Merges the training and the test sets to create one data set.
## -Extracts only the measurements on the mean and standard deviation for each measurement. 
## -Uses descriptive activity names to name the activities in the data set.
## -Appropriately labels the data set with descriptive activity names. 
## -Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Step 1, Download file, Unzip, Read data sets
## 1.1 Download and unzip file
AfileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(AfileUrl, destfile="~/Desktop/Getting and Cleaning Data/assignment/data", method="curl")
unzip("./data")
dateDownloaded<-date()
dateDownloaded

## 1.2 Read data files
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
## 2.1 Add Labels (features.txt) as Column Names to test and training sets
columnNames <- Labels$V2
names(TestD1) <- columnNames
names(TrainD1) <- columnNames

## 2.2 Merge test and training set labels to data
TestD1<-cbind(TestL1, TestD1)
colnames(TestD1)[colnames(TestD1)=="V1"] <- "Activity"
TrainD1<-cbind(TrainL1, TrainD1)
colnames(TrainD1)[colnames(TrainD1)=="V1"] <- "Activity"

## 2.3 Merge IDs to test and training sets
TestD1<-cbind(TestID, TestD1)
colnames(TestD1)[colnames(TestD1)=="V1"] <- "Subject ID"
TrainD1<-cbind(TrainID, TrainD1)
colnames(TrainD1)[colnames(TrainD1)=="V1"] <- "Subject ID"

## 2.4 Merge test and training sets
mergedData<-rbind(TestD1, TrainD1)

## Step 3, Extract mean and standard deviation for each measurement 
DataSubset <- mergedData[ , grep("Subject ID|Activity|mean\\(\\)|std\\(\\)",colnames(mergedData))]

## Step 4, Appropriately label the data set with descriptive activity names
DataSubset$Activity<-factor(DataSubset$Activity, labels=Activity$V2)
write.table(DataSubset, "~/Desktop/Getting and Cleaning Data/assignment/tidydata.txt", sep="\t")

## Step 5, Create a second tidy data set with 
##average of each variable for each activity and each subject.
library(reshape2)
MData<-melt(DataSubset, id=c("Subject ID", "Activity"))
FData<-dcast(MData, MData[,1] + MData$Activity ~ variable, mean)
colnames(FData)[colnames(FData)=="MData[, 1]"] <- "Subject ID"
colnames(FData)[colnames(FData)=="MData$Activity"] <- "Activity"
write.table(FData, "~/Desktop/Getting and Cleaning Data/assignment/tidyMeandata.txt", sep="\t")         

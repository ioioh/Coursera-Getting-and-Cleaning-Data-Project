Coursera: Getting and Cleaning Data Project, April 2014
Code Book

--This code book was prepared as part of the Getting and Cleaning Data Coursera course project. It describes the variables, the data, and all transformations to clean the data.

Original data was obtained via the course page: Human Activity Recognition Using Smartphones Dataset Version 1.0

Data set and variable arable descriptions can be found in original data under features.info and README text files. There are 30 volunteer subjects age 19-48 years (variable is "Subject ID": test (30%) and train (70%) subjects), 6 activities (variable is "Activity": walking, walking upstairs, walking downstairs, sitting, standing, laying), and numerous variables estimated from feature vectors (time domain signals from Samsung Galaxy S II Smartphones worn on waist). Original data files were transformed in the following steps:

1 - Variable names (features.txt) were added to the test data (X_test.txt) and the train data (X_test.txt)
2 - "Activity" labels (Y_test.txt, Y_train.txt) were merged to the test data and the training data
3 - "Subject ID"s ("subject_test.txt", "subject_train.txt") were merged to the test data and the training data
4 - Test data and training data were merged to form one larger data set
5 - This larger data set was subset to extract only mean and standard deveiations for each measurement (excluding meanFreqs and additional averaged vectors)
6 - Each "Activity" value was replaced with actual descriptive activity name (activity_labels.txt)
7 - Based on this subset, a second data frame is created with average of each variable for each activity and each subject

=================
VARIABLES:
1 - Subject ID : 1-30
2 - Activity : walking, walking upstairs, walking downstairs, sitting, standing, laying
3:563 - + 561 Feature Variables, which CAN BE FOUND IN ORIGINAL DATA FILE (features.txt)

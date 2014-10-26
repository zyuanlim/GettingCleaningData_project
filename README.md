GettingCleaningData_project
===========================

## Readme

The script starts with loading the required library and setting the work directory.

Then, it reads the training and testing txt files, each consisting of subject, class
label and feature variables data.

After reading the data into the respective data frame, it merges them into training 
and test data frames separately, then both data frames into one whole data frame.

It then runs the following process:

  point 1: Merges the training and the test sets to create one data set
  
  reads the descriptive variable names into a data frame
  
  extracts indexes of variables which contain mean() and std() from the data frame
  
  point 2: Extracts only the measurements on the mean and standard deviation for each measurement
  reads the activity names into a data frame
  
  point 3: uses descriptive activity names to name the activities in the data set
  
  point 4: appropriately labels the data set with descriptive variable names 
  
  point 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  writes the tidy data set from point 5 into txt file





## Loading required libraries
lapply(list("dplyr","tidyr","Hmisc"),require,character.only=T,quietly=T)
setwd("/Users/zanelim/Documents/Coursera/Getting & Cleaning Data")

## Reading Training Data
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt",
                            sep="\t")
label_train <- read.table("data/UCI HAR Dataset/train/y_train.txt",
                          sep="\t")
set_train <- read.table("data/UCI HAR Dataset/train/X_train.txt",
                          sep="",colClasses=c("numeric"))

## Combining training subject, label and set
df_train <- cbind(subject=subject_train$V1,
                  label=label_train$V1,
                  set_train)

## Reading Test Data
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt",
                            sep="\t")
label_test <- read.table("data/UCI HAR Dataset/test/y_test.txt",
                          sep="\t")
set_test <- read.table("data/UCI HAR Dataset/test/X_test.txt",
                        sep="",colClasses=c("numeric"))

## Combining testing subject, label and set
df_test <- cbind(subject=subject_test$V1,
                  label=label_test$V1,
                  set_test)

## point 1: Merges the training and the test sets to create one data set.
df_1 <- rbind(df_train,df_test)

## Reading descriptive variable names
name_variable <- read.table("data/UCI HAR Dataset/features.txt",sep="",
                            col.names=c("id","names"),stringsAsFactor=F)

## Extracting indexes of variables which contain mean() and std()
id <- grep("(mean()|std())",name_variable$names)

## point 2: Extracts only the measurements on the mean and standard deviation for each measurement.
## add 2 to indexes because the first 2 columns are subject and activity identifiers
df_2 <- df_1[,c(1,2,id+2)]

## Reading activity names
name_activity <- read.table("data/UCI HAR Dataset/activity_labels.txt",sep="",
                            col.names=c("label","names"),stringsAsFactor=F)

## point 3: Uses descriptive activity names to name the activities in the data set
df_3 <- merge(name_activity,df_2)

## point 4: Appropriately labels the data set with descriptive variable names 
name_variable$id<-paste0("V",name_variable$id)
df_4 <- df_3
names(df_4)[-(1:3)] <- replace(names(df_4)[-(1:3)],
                               match(names(df_4)[-(1:3)],name_variable$id[id]),
                               name_variable$names[id])

## point 5: Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
df_5 <- aggregate(.~names+label+subject,df_4,mean,na.rm=T)

## Writing dataset from point 5 into txt file
write.table(df_5,"tidy_dataset.txt",row.name=F)

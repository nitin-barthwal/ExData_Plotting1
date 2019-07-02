# Getting and Cleaning Data Course Project Week 4


## Read Data

# Train data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Metadata
featureNames <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

## Analysis
# 1. Merges the training and the test sets to create one data set.
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# 2.set names to variables
names(subject)<-c("subject")
names(activity)<- c("activity")
names(features)<- featureNames$V2

# 3.Merge columns to get the data frame Data for all data
completeData <- cbind(features,activity,subject)

head(completeData,1)

library(dplyr)
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Create a vector of only mean and std, use the vector to subset.

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)


extractedData <- completeData[,requiredColumns]
dim(extractedData)

#3. Uses descriptive activity names to name the activities  in the data set
extractedData$activity <- factor(extractedData$activity, labels=c("Walking",
  "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))



#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# create the tidy data set
library(reshape2)
melted <- melt(extractedData, id=c("subject","activity"))
tidy <- dcast(melted, subject+activity ~ variable, mean)
dim(tidy)

# write the tidy data set to a file
write.csv(tidy, "tidy.csv", row.names=FALSE)

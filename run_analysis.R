
## Step 0 - Preparing Script

# Sub-step 1 - Installing Libs
if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("dplyr")) {
    install.packages("dplyr")
}

require("data.table")
require("dplyr")

# Sub-step 2 - Retriving labels
listFeatures <- read.table("UCI HAR Dataset/features.txt")
listActivities <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Sub-step 3 - Getting Test Data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Sub-step 4 - Getting Training Data
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)



## Step 1 - Merging

# Sub-step 1 - Merging training and testing data
fullSubject <- rbind(trainSubject, testSubject)
fullActivity <- rbind(trainActivity, testActivity)
fullFeatures <- rbind(trainFeatures, testFeatures)

# Sub-step 2 - Renaming Activity & Subject dataframes
colnames(fullActivity) <- "Activity"
colnames(fullSubject) <- "Subject"

# Sub-step 3 - Renaming Features dataframe cols with data from listFeatures
colnames(fullFeatures) <- t(listFeatures[2])

# Sub-step 4 - Combining rows into complete dataframe
completeFrame <- cbind(fullFeatures, fullActivity, fullSubject)

# Sub-step 5 - Cleaning old data frames
rm(trainSubject)
rm(trainActivity)
rm(trainFeatures)
rm(testSubject)
rm(testActivity)
rm(testFeatures)
rm(fullSubject)
rm(fullActivity)
rm(fullFeatures)



## Step 2 - Extracting Mean & SD

# Sub-step 1 - Using Regexp to extract id of cols with Mean & SD
usefulColumns <- grep(".*Mean.*|.*Std.*", names(completeFrame), ignore.case=TRUE)

# Sub-step 2 - Making a list of columns to keep
colsToKeep <- c(usefulColumns, 562, 563)

# Sub-step 3 - Extracting cols we need
reducedFrame <- completeFrame[,colsToKeep]

# Sub-step 4 - Cleaning old data frames
rm(completeFrame)
rm(usefulColumns)
rm(colsToKeep)



## Step 3 - Using descriptive activity names to name the activities

# Sub-step 1 - Converting Activity from numeric to characters
reducedFrame$Activity <- as.character(reducedFrame$Activity)

# Sub-step 2 - Replacing Activity number by activity Name from List Activities
for (i in 1:6) {
    reducedFrame$Activity[reducedFrame$Activity == i] <- as.character(listActivities[i,2])
}

# Sub-step 3 - Using Activity as a Factor
reducedFrame$Activity <- as.factor(reducedFrame$Activity)

# Sub-step 4 - Cleaning old data frames
rm(listFeatures)
rm(listActivities)
rm(i)



## Step 4 - Renaming cols with comprehensive names

# Sub-step 1 - Using Regexp to rename cols
names(reducedFrame)<-gsub("-mean()", "Mean", names(reducedFrame), ignore.case = TRUE)
names(reducedFrame)<-gsub("-std()", "STD", names(reducedFrame), ignore.case = TRUE)
names(reducedFrame)<-gsub("-freq()", "Frequency", names(reducedFrame), ignore.case = TRUE)

names(reducedFrame)<-gsub("Acc", "Accelerometer", names(reducedFrame))
names(reducedFrame)<-gsub("Gyro", "Gyroscope", names(reducedFrame))
names(reducedFrame)<-gsub("BodyBody", "Body", names(reducedFrame))
names(reducedFrame)<-gsub("Mag", "Magnitude", names(reducedFrame))

names(reducedFrame)<-gsub("^t", "Time", names(reducedFrame))
names(reducedFrame)<-gsub("^f", "Frequency", names(reducedFrame))

names(reducedFrame)<-gsub("tBody", "TimeBody", names(reducedFrame))

names(reducedFrame)<-gsub("angle", "Angle", names(reducedFrame))
names(reducedFrame)<-gsub("gravity", "Gravity", names(reducedFrame))

names(reducedFrame)<-gsub("()", "", names(reducedFrame))



## Step 5 - Creating independant dataframe for data outputing

# Sub-step 1 - Converting Subjects as factor
reducedFrame$Subject <- as.factor(reducedFrame$Subject)

# Sub-step 2 - Creating the data frame
independantFrame <- data.table(reducedFrame)

# Sub-step 3 - Aggregating rows by Subject and Activity and using mean calculation
finalFrame <- aggregate(. ~Subject + Activity, independantFrame, mean)

# Sub-step 4 - Re-ordering cols to place Activities and Subjects at the beginning of the data frame
finalFrame <- finalFrame[order(finalFrame$Subject,finalFrame$Activity),]

# Sub-step 5 - Writing the cleanned dataset to a file
write.table(finalFrame, file = "Tidy.txt", row.names = FALSE)

# Sub-step 6 - Cleaning old data frames
rm(independantFrame)
rm(reducedFrame)
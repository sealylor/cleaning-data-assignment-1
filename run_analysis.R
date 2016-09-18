## download and unzip the data file

	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl,destfile="./data/Dataset.zip")
	unzip(zipfile="./data/Dataset.zip",exdir="./data")

## read the train and test tables, feature vector, and activity lables

	# read the train tables
	x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
	y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
	subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

	# read the test tables
	x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
	y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
	subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

	# read the features vector
	features <- read.table("./data/UCI HAR Dataset/features.txt")

	# read the activity labels
	ActivityLabels = read.table("./data/UCI HAR Dataset/activity_labels.txt")

## Assign names to the columns

	colnames(x_train) <- features[,2] 
	colnames(y_train) <-"activityId"
	colnames(subject_train) <- "subjectId"
      
	colnames(x_test) <- features[,2] 
	colnames(y_test) <- "activityId"
	colnames(subject_test) <- "subjectId"
      
	colnames(ActivityLabels) <- c("activityId","activityType")

## Merge the two data sets 

	mrg_train <- cbind(y_train, subject_train, x_train)
	mrg_test <- cbind(y_test, subject_test, x_test)
	MergedSet <- rbind(mrg_train, mrg_test)

## Extract only measurements on mean and standard deviation

	# read the column names and make a vector for the ID, mean, and standard deviation
	colNames <- colnames(MergedSet)
	mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                 )
	# create a subset from the merged data files
	MeanStdev <- MergedSet[ , mean_and_std == TRUE]

## Use descriptive activity names to name the activities in the data set
	setWithActivityNames <- merge(MeanStdev, ActivityLabels, by='activityId', all.x=TRUE)
	colNames  = colnames(MeanStdev); 



## Create a tiday data set and write to a text file
	TidyData <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
	TidyData <- TidyData[order(TidyData$subjectId, TidyData$activityId),]
	write.table(TidyData, "TidyData.txt", row.name=FALSE)
                            
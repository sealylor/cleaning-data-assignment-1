# cleaning-data-assignment-1
run.analysis.R  README

This script uses the Human Activity Recognition Using Smartphones Data Set and creates a clean data set.

The download.file and unzip functions are used to download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the contents.

The data tables(train and test), features vector, and activity tables are loaded into R using the read.table function for each table.

Appropriate names are assigned to the columns, and then cbind and rbind functions are used to create a merged data set called 'MergedSet'.

The grpl function is used to extract columns with mean and standard deviation data and a new data table called 'MeanStdev' is created using the extracted columns.

The merge function is used to give descriptive activity names to name the activities in the data set.

A text file of the data called TidyData.txt is created using the write.table function.

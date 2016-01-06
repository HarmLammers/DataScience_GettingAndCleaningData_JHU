##	The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
##	The goal is to prepare a tidy data that can be used for later analysis. 
##	You will be graded by your peers on a series of yes/no questions related to the project. 
##	You will be required to submit: 
##	1) a tidy data set as described below, 
##	2) a link to a Github repository with your script for performing the analysis, and 
##	3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
##	You should also include a README.md in the repo with your scripts. 
##	This repo explains how all of the scripts work and how they are connected.  
##	
##	One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
##	Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
##	The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
##	A full description is available at the site where the data was obtained: 
##	
##	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##	
##	Here are the data for the project: 
##	
##	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##	
##	You should create one R script called run_analysis.R that does the following. 
##	1. Merges the training and the test sets to create one data set.
##	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##	3. Uses descriptive activity names to name the activities in the data set
##	4. Appropriately labels the data set with descriptive variable names. 
##	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##	
##	Good luck!
##
# 	The datasets have been downloaded manually into dir GaCDCourseProject & subsequently unzipped to my workdirectory
# 
# 	I.ve a slight preference to keep instructions in a general form and to 
# 	use variables to steer the individual cases
##
##	You should create one R script called run_analysis.R that does the following. 
##	1. Merges the training and the test sets to create one data set.

##	Measurements
##	The original dataset was split into a trainingset and a testset
## 	Combine them together (rows)
trainfn 			<- ("./train/X_train.txt")						## name file - train
testfn 				<- ("./test/X_test.txt")						## name file - test
xtraindata			<- read.table(trainfn)							## read file into a dataframe-variable
xtestdata			<- read.table(testfn)							## read file into a dataframe-variable
measurementdata			<- rbind(xtraindata, xtestdata)						## bind the two dataframes

##	Activities 
##	The original dataset was split into a trainingset and a testset
## 	Combine them together (rows)
trainfn 			<- ("./train/y_train.txt")
testfn 				<- ("./test/y_test.txt")
ytraindata			<- read.table(trainfn)
ytestdata			<- read.table(testfn)
activitydata			<- rbind(ytraindata, ytestdata)

##	Subjects
##	The original dataset was split into a trainingset and a testset
## 	Combine them together (rows)
trainfn 			<- ("./train/subject_train.txt")
testfn 				<- ("./test/subject_test.txt")
straindata			<- read.table(trainfn)
stestdata			<- read.table(testfn)
subjectdata			<- rbind(straindata, stestdata)

##	We stil have 3 datasets here, but the cleaning (as asked for) will be done on every set seperately
##	Which leaves us the task to combine the datasets columnwise afterwards

##	You should create one R script called run_analysis.R that does the following. 
##	D. Merges the training and the test sets to create one data set.
##	2. Extracts only the measurements on the mean and standard deviation for each measurement. 

featuredata			<- read.table("features.txt")						## Read features into a data.frame
usedFeatures 			<- features[grep("-mean\\(\\)|-std\\(\\)",featuredata[,2]), ]		## select features containing -mean() or -std()
													## use escape-characters to identify the parenthesis characters
measurement_meanstd		<- measurementdata[ , usedFeatures[ ,1]]				## select columns corresponding to the selected features

##	You should create one R script called run_analysis.R that does the following. 
##	D. Merges the training and the test sets to create one data set.
##	D. Extracts only the measurements on the mean and standard deviation for each measurement. 
##	3. Uses descriptive activity names to name the activities in the data set

activitylabeldata		<- read.table("activity_labels.txt")					## Read activity labels into a data.frame
names(activitylabeldata)	<- c("activitycode", "activitylabel")					## assign meaningfull column names, lowercase preferably
activitylabeldata[, 2]		<- gsub("_", "-", tolower(activitylabeldata[ ,2]))			## restyle labels to lowercase and use readable dashes
	
activity			<- activitylabeldata[activitydata[,1], 2]				## replace numbers by corresponding labels
## activity												## check the result

##	4. Appropriately labels the data set with descriptive variable names. 
## names(measurement_meanstd)										## reveals non-descriptive Vxx names
names(measurement_meanstd)	<- tolower(usedFeatures[ , 2])						## copy feature names from usedFeatures
													## set them to lowercase
names(measurement_meanstd)	<- gsub("\\(|\\)","",names(measurement_meanstd))			## get rid of the pointless parentheses in the column names
## names(measurement_meanstd)										## check the result

names(activity)			<- "activity"								## assign descriptive column name 
names(subjectdata) 		<- "subject"								## assign descriptive column name

##	You should create one R script called run_analysis.R that does the following. 
##	1. Merges the training and the test sets to create one data set - REVISITED
##
##	We stil have 3 datasets here, but the cleaning (as asked for) has been done on every set seperately
##	Which leaves us the task to combine the datasets columnwise now

projectdata			<- cbind(subjectdata, activity, measurement_meanstd)			## bind datasets together, column wise, identifiers first
write.table(projectdata, "merged_cleansed_projectdata.txt", row.names=FALSE)				## keep result of the work for later use


##	You should create one R script called run_analysis.R that does the following. 
##	D. Merges the training and the test sets to create one data set.
##	D. Extracts only the measurements on the mean and standard deviation for each measurement. 
##	D. Uses descriptive activity names to name the activities in the data set
##	D. Appropriately labels the data set with descriptive variable names. 
##	5. From the data set in step 4, creates a second, independent tidy data set 
##	   with the average of each variable for each activity and each subject.
##	

##	use aggregate function; identify columns (without identifiers) to aggregate, identify the group-by columns in a list, calculate the mean 
agg				<- aggregate(projectdata[, 3:dim(projectdata)[2]], list(projectdata$subject, projectdata$activity), mean)
names(agg)			<- names(projectdata)							## aggregation/group_by columns have been renamed to groupx
write.table(agg, "merged_cleansed_projectdata_avg_aggregate.txt", row.names=FALSE)

##	use package dplyr as mentioned in the video lectures to create an alternative result
library(dplyr)
effe				<- projectdata %>% group_by(subject, activity) %>% summarise_each(funs(mean(., na.rm=TRUE)))
write.table(effe, "merged_cleansed_projectdata_avg_dplyr.txt", row.names=FALSE)
 

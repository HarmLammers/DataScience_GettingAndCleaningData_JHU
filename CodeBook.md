# Codebook

## Origin of the data
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data Set Information - as published on the website
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset. 

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [http://www.youtube.com/watch?v=XOEN9W05_4A]

An updated version of this dataset can be found at [http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions]. 
It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows.

### Attribute Information - as published on the website
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Assignment
You should create one R script called run_analysis.R that does the following:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Getting started
The data have been downloaded manually, resulting in a zip-file containing data for MACOS and others. 
Working on a Windows-machine myself, I extracted the data in folder UCI HAR Dataset to a local directory and changed my R-workdirectory to this folder.

## Approach
The original dataset had been split into a test and a training set, each containing three files: subjects, activities (y) and measurements (x).
The first actions were to combine the corresponding files of the test and training sets rowwise. 
Once the rows had been combined, the requested columns have been selected and named properly; 
- The selection of measurementdata has been done by keeping the variabels with -mean() or -std() in their names as to keep the means and standarddeviations as requested. 
- The editing of the column names has been done by 
	- replacing the _underscores by -dashes, 
	- formatting them to lowercase and 
	- removing the parentheses "()" at the end of the variable names. 
- The activity and subject files have been given specific values as column name. 

Some data have been reformatted:
- The activity-labels have been formatted to lowercase, replacing the _underscores by -dashes.
- The activities had originally been coded by a number, the numbers have been replaced by their corresponding label using the contents of the activity_labels.txt-file. 

With these three files tidied up, the files have been combined together column wise, taking the identifiers for the measurements as first columns (subject and activity).

This tidy dataset had to be summarised, by taking the means of the columns grouped_by the identifiers subject and activity.
The result has been saved with a write.table command as requested. 

## Resulting variables 
- "subject"
- "activity"		
- "tbodyacc-mean-x"
- "tbodyacc-mean-y"
- "tbodyacc-mean-z"
- "tbodyacc-std-x"
- "tbodyacc-std-y"
- "tbodyacc-std-z"
- "tgravityacc-mean-x"
- "tgravityacc-mean-y"
- "tgravityacc-mean-z"
- "tgravityacc-std-x"
- "tgravityacc-std-y"
- "tgravityacc-std-z"
- "tbodyaccjerk-mean-x"
- "tbodyaccjerk-mean-y"
- "tbodyaccjerk-mean-z"
- "tbodyaccjerk-std-x"
- "tbodyaccjerk-std-y"
- "tbodyaccjerk-std-z"
- "tbodygyro-mean-x"
- "tbodygyro-mean-y"
- "tbodygyro-mean-z"
- "tbodygyro-std-x"
- "tbodygyro-std-y"
- "tbodygyro-std-z"
- "tbodygyrojerk-mean-x"
- "tbodygyrojerk-mean-y"
- "tbodygyrojerk-mean-z"
- "tbodygyrojerk-std-x"
- "tbodygyrojerk-std-y"
- "tbodygyrojerk-std-z"
- "tbodyaccmag-mean"
- "tbodyaccmag-std"
- "tgravityaccmag-mean"
- "tgravityaccmag-std"
- "tbodyaccjerkmag-mean"
- "tbodyaccjerkmag-std"
- "tbodygyromag-mean"
- "tbodygyromag-std"
- "tbodygyrojerkmag-mean"
- "tbodygyrojerkmag-std"
- "fbodyacc-mean-x"
- "fbodyacc-mean-y"
- "fbodyacc-mean-z"
- "fbodyacc-std-x"
- "fbodyacc-std-y"
- "fbodyacc-std-z"
- "fbodyaccjerk-mean-x"
- "fbodyaccjerk-mean-y"
- "fbodyaccjerk-mean-z"
- "fbodyaccjerk-std-x"
- "fbodyaccjerk-std-y"
- "fbodyaccjerk-std-z"
- "fbodygyro-mean-x"
- "fbodygyro-mean-y"
- "fbodygyro-mean-z"
- "fbodygyro-std-x"
- "fbodygyro-std-y"
- "fbodygyro-std-z"
- "fbodyaccmag-mean"
- "fbodyaccmag-std"
- "fbodybodyaccjerkmag-mean"
- "fbodybodyaccjerkmag-std"
- "fbodybodygyromag-mean"
- "fbodybodygyromag-std"
- "fbodybodygyrojerkmag-mean"
- "fbodybodygyrojerkmag-std"

As requested in the assignment, the values of these variables are a computed mean over n(s) observations for subject s and activity y.

The subjects are identified by a number 1 .. 30.
The activities have been labeled: laying, sitting, standing, walking, walking-upstairs, walking-downstairs.
The measurements have standard values: [-1, 1].

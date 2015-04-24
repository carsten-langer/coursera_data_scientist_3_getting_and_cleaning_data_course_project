# Coursera Data Scientist / Getting and Cleaning Data / course project work / codebook

This is the code book for the file _average_per_activity_and_subject.txt_.

## Raw data
The raw data comes from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. That raw data originally comes from <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>, where you also find more background information on the raw data.


This code book is based on the _README.txt_ and _features_info.txt_ from the raw data zip file.

## Contents
This data set includes the following files:

- _README.md_
- _CodeBook.md_: Describes the tidy data set _average_per_activity_and_subject.txt_.
- _average_per_activity_and_subject.txt_: Tidy data set: Average values per measurement per activity and subject.
- _run_analysis.R_: The R script to convert from raw to tidy data.

## Study Design and raw data
The study is about _Human Activity Recognition Using Smartphones_.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Raw data files
The raw data zip file contains many files. Only some were used as raw data for this tiny data set. The original data contains a training data set and a testing data set:  
_train/subject_train.txt_: subject for each observation of _X_train.txt_   
_test/subject_test.txt_: same for test  
_train/X_train.txt_: observations of variables of features, see below  
_test/X_test.txt_: same for test  
_train/y_train.txt_: activity for each observation of _X_train.txt_  
_test/y_test.txt_: same for test  
_activity_labels.txt_: labels for the activities  
_features.txt_: labels for the feature variables


### Raw data features and variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag

All features are normalized and bounded within [-1,1].

The set of variables that were estimated from these signals are:  
mean(): Mean value  
std(): Standard deviation  
...: and some more not used for the tidy data set.


## Tidy data
The raw data set was randomly split into a training and testing set. The tidy data set has merged them back to form a single data set.

The raw data set contains many variables per feature. The tidy data set only uses the mean and standard deviation variable per feature.

The raw data set has the activity and subject per observation stored in separate files. The tidy data set brings them is as an activity and a subject variable for grouping. The activity is labelled.

In the tidy data set, for all feature variables the average value of that variable per activity and subject is calculated. There is one row per activity and subject.

### Tidy data variables overview

_activity_
: The executed activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

_subject_
: Integer identifier for the test person (1 - 30).

Each observation of the raw data is grouped by the combination of _activity_ and _subject_.

_tBodyAcc-mean()-X_
: The average of the values of the _tBodyAcc-mean()-X_ feature variable of the combined raw training and test data sets for the given _activiy_ and _subject_. As the raw values were normalized and bounded within [-1, 1], these values are in the same range.

_... and so on ..._
: see below for full list of variables

### List of all tidy data variables
_activity_  
_subject_  
_tBodyAcc-mean()-X_   
_tBodyAcc-mean()-Y_  
_tBodyAcc-mean()-Z_  
_tBodyAcc-std()-X_  
_tBodyAcc-std()-Y_  
_tBodyAcc-std()-Z_  
_tGravityAcc-mean()-X_  
_tGravityAcc-mean()-Y_  
_tGravityAcc-mean()-Z_  
_tGravityAcc-std()-X_  
_tGravityAcc-std()-Y_  
_tGravityAcc-std()-Z_  
_tBodyAccJerk-mean()-X_  
_tBodyAccJerk-mean()-Y_  
_tBodyAccJerk-mean()-Z_  
_tBodyAccJerk-std()-X_  
_tBodyAccJerk-std()-Y_  
_tBodyAccJerk-std()-Z_  
_tBodyGyro-mean()-X_  
_tBodyGyro-mean()-Y_  
_tBodyGyro-mean()-Z_  
_tBodyGyro-std()-X_  
_tBodyGyro-std()-Y_  
_tBodyGyro-std()-Z_  
_tBodyGyroJerk-mean()-X_  
_tBodyGyroJerk-mean()-Y_  
_tBodyGyroJerk-mean()-Z_  
_tBodyGyroJerk-std()-X_  
_tBodyGyroJerk-std()-Y_  
_tBodyGyroJerk-std()-Z_  
_tBodyAccMag-mean()_  
_tBodyAccMag-std()_  
_tGravityAccMag-mean()_  
_tGravityAccMag-std()_  
_tBodyAccJerkMag-mean()_  
_tBodyAccJerkMag-std()_  
_tBodyGyroMag-mean()_  
_tBodyGyroMag-std()_  
_tBodyGyroJerkMag-mean()_  
_tBodyGyroJerkMag-std()_  
_fBodyAcc-mean()-X_  
_fBodyAcc-mean()-Y_  
_fBodyAcc-mean()-Z_  
_fBodyAcc-std()-X_  
_fBodyAcc-std()-Y_  
_fBodyAcc-std()-Z_  
_fBodyAccJerk-mean()-X_  
_fBodyAccJerk-mean()-Y_  
_fBodyAccJerk-mean()-Z_  
_fBodyAccJerk-std()-X_  
_fBodyAccJerk-std()-Y_  
_fBodyAccJerk-std()-Z_  
_fBodyGyro-mean()-X_  
_fBodyGyro-mean()-Y_  
_fBodyGyro-mean()-Z_  
_fBodyGyro-std()-X_  
_fBodyGyro-std()-Y_  
_fBodyGyro-std()-Z_  
_fBodyAccMag-mean()_  
_fBodyAccMag-std()_  
_fBodyBodyAccJerkMag-mean()_  
_fBodyBodyAccJerkMag-std()_  
_fBodyBodyGyroMag-mean()_  
_fBodyBodyGyroMag-std()_  
_fBodyBodyGyroJerkMag-mean()_  
_fBodyBodyGyroJerkMag-std()_

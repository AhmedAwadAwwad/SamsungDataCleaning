# Samsung Data Cleaning Codebook
Author: Phil Lombardo


The following codebook describes the variables and files for this data cleaning project. Specifically, we will describe the variables that appear in the data frame we called `full_df` and the tidy data set of means for the accelerometer data we called `tidayDataMeans`.  (For more information, see the README.md file in this repository.)

*Note:*  Codebook and descriptions for the original data can be found by downloading [this zipped file.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Variables and descriptions in `full_df`
As mentioned in the README.md, the `run_analysis.R` script took raw files from [this zipped folder](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of data. This raw data took measurements from an accelerometer and gyroscope in a Samsung phone and recorded activity while participants did different activities. We performed the following modifications:

1. Merged the test and training set;
2. Extractd the variables from the accelerometer that involve means and standard deviations for the accelerometer data;
3. Changed the output variable, "Activity", so that the variable values are descriptive;
4. Provided descriptive variables names to the `full_df`.

We created a new data set in the fifth step, but since this part of the codebook only deals with `full_df`, we move on to the data description.

#### Variables in `full_df`:
Here is a list and description for the variables in the `full_df` data frame. For convenience, they appear in the same order as the columns of the data frame. 

* _Subject ID:_  This variable is a unique identifier for the participants in this study.
* _tBodyAcc-mean()-X:_ This is the mean acceleration of the body in the X-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAcc-mean()-Y:_ This is the mean acceleration of the body in the Y-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAcc-mean()-Z:_ This is the mean acceleration of the body in the Z-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAcc-std()-X:_ This is the standard deviation acceleration of the body in the X-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAcc-std()-Y:_ This is the standard deviation acceleration of the body in the Y-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAcc-std()-Z:_ This is the standard deviation acceleration of the body in the Z-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-mean()-X:_ This is the mean acceleration of due to gravitational forces in the X-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-mean()-Y:_ This is the mean acceleration of due to gravitational forces in the Y-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-mean()-Z:_ This is the mean acceleration of due to gravitational forces in the Z-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-std()-X:_ This is the standard deviation of acceleration of due to gravitational forces in the X-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-std()-Y:_ This is the standard deviation of acceleration of due to gravitational forces in the Y-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tGravityAcc-std()-Z:_ This is the standard deviation of acceleration of due to gravitational forces in the Z-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAccJerk-mean()-X:_ This is the mean of the jerk-motion acceleration of due for the body in the X-direction as recorded by the accelerometer, measured in meters per seconds-squared.
* _tBodyAccJerk-mean()-Y:_
* _tBodyAccJerk-mean()-Z:_
* _tBodyAccJerk-std()-X:_
* _tBodyAccJerk-std()-Y:_
* _tBodyAccJerk-std()-Z:_
* _tBodyGyro-mean()-X:_
* _tBodyGyro-mean()-Y:_
* _tBodyGyro-mean()-Z:_
* _tBodyGyro-std()-X:_
* _tBodyGyro-std()-Y:_
* _tBodyGyro-std()-Z:_
* _tBodyGyroJerk-mean()-X:_
* _tBodyGyroJerk-mean()-Y:_
* _tBodyGyroJerk-mean()-Z:_
* _tBodyGyroJerk-std()-X:_
* _tBodyGyroJerk-std()-Y:_
* _tBodyGyroJerk-std()-Z:_
* _tBodyAccMag-mean():_
* _tBodyAccMag-std():_
* _tGravityAccMag-mean():_
* _tGravityAccMag-std():_
* _tBodyAccJerkMag-mean():_
* _tBodyAccJerkMag-std():_
* _tBodyGyroMag-mean():_
* _tBodyGyroMag-std():_
* _tBodyGyroJerkMag-mean():_
* _tBodyGyroJerkMag-std():_
* _fBodyAcc-mean()-X:_
* _fBodyAcc-mean()-Y:_
* _fBodyAcc-mean()-Z:_
* _fBodyAcc-std()-X:_
* _fBodyAcc-std()-Y:_
* _fBodyAcc-std()-Z:_
* _fBodyAcc-meanFreq()-X:_
* _fBodyAcc-meanFreq()-Y:_
* _fBodyAcc-meanFreq()-Z:_
* _fBodyAccJerk-mean()-X:_
* _fBodyAccJerk-mean()-Y:_
* _fBodyAccJerk-mean()-Z:_
* _fBodyAccJerk-std()-X:_
* _fBodyAccJerk-std()-Y:_
* _fBodyAccJerk-std()-Z:_
* _fBodyAccJerk-meanFreq()-X:_
* _fBodyAccJerk-meanFreq()-Y:_
* _fBodyAccJerk-meanFreq()-Z:_
* _fBodyGyro-mean()-X:_
* _fBodyGyro-mean()-Y:_
* _fBodyGyro-mean()-Z:_
* _fBodyGyro-std()-X:_
* _fBodyGyro-std()-Y:_
* _fBodyGyro-std()-Z:_
* _fBodyGyro-meanFreq()-X:_
* _fBodyGyro-meanFreq()-Y:_
* _fBodyGyro-meanFreq()-Z:_
* _fBodyAccMag-mean():_
* _fBodyAccMag-std():_
* _fBodyAccMag-meanFreq():_
* _fBodyBodyAccJerkMag-mean():_
* _fBodyBodyAccJerkMag-std():_
* _fBodyBodyAccJerkMag-meanFreq():_
* _fBodyBodyGyroMag-mean():_
* _fBodyBodyGyroMag-std():_
* _fBodyBodyGyroMag-meanFreq():_
* _fBodyBodyGyroJerkMag-mean():_
* _fBodyBodyGyroJerkMag-std():_
* _fBodyBodyGyroJerkMag-meanFreq():_
* _angle(tBodyAccMean,gravity):_
* _angle(tBodyAccJerkMean),gravityMean):_
* _angle(tBodyGyroMean,gravityMean):_
* _angle(tBodyGyroJerkMean,gravityMean):_
* _angle(X,gravityMean):_
* _angle(Y,gravityMean):_
* _angle(Z,gravityMean):_

* _Activity_: records the activity the participant was doing while this Samsung data was collect. There are 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
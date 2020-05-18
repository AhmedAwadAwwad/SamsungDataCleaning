# Samsung Data Cleaning Codebook
Author: Phil Lombardo


The following codebook describes the variables and files for this data cleaning project. Specifically, we will describe the variables that appear in the data frame we called `full_df` and the tidy data set of means for the accelerometer data we called `tidayDataMeans`.  (For more information, see the README.md file in this repository.)

*Note:*  Codebook and descriptions for the original data can be found by downloading [this zipped file.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Variables and descriptions in `full_df`
As mentioned in the README.md, the `run_analysis.R` script took raw files from [this zipped folder](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of data and performed the following modifications:

1. Merged the test and training set;
2. Extractd the variables from the accelerometer that involve means and standard deviations for the accelerometer data;
3. Changed the output variable, "Activity", so that the variable values are descriptive;
4. Provided descriptive variables names to the `full_df`.

We created a new data set in the fifth step, but since this part of the codebook only deals with `full_df`, we move on to the data description.

#### Variables in `full_df`:
Here is a list and description for the variables in the `full_df` data frame. For convenience, they appear in the same order as the columns of the data frame. Test $\cos(x)$.

* _tBodyAcc-mean()-X:_  test 
* _tBodyAcc-mean()-Y_
* _tBodyAcc-mean()-Z_
* _tBodyAcc-std()-X_
* _tBodyAcc-std()-Y_
* _tBodyAcc-std()-Z_
* _tGravityAcc-mean()-X_
* _tGravityAcc-mean()-Y_
* _tGravityAcc-mean()-Z_
* _tGravityAcc-std()-X_
* _tGravityAcc-std()-Y_
* _tGravityAcc-std()-Z_
* _tBodyAccJerk-mean()-X_
* _tBodyAccJerk-mean()-Y_
* _tBodyAccJerk-mean()-Z_
* _tBodyAccJerk-std()-X_
* _tBodyAccJerk-std()-Y_
* _tBodyAccJerk-std()-Z_
* _tBodyGyro-mean()-X_
* _tBodyGyro-mean()-Y_
* _tBodyGyro-mean()-Z_
* _tBodyGyro-std()-X_
* _tBodyGyro-std()-Y_
* _tBodyGyro-std()-Z_
* _tBodyGyroJerk-mean()-X_
* _tBodyGyroJerk-mean()-Y_
* _tBodyGyroJerk-mean()-Z_
* _tBodyGyroJerk-std()-X_
* _tBodyGyroJerk-std()-Y_
* _tBodyGyroJerk-std()-Z_
* _tBodyAccMag-mean()_
* _tBodyAccMag-std()_
* _tGravityAccMag-mean()_
* _tGravityAccMag-std()_
* _tBodyAccJerkMag-mean()_
* _tBodyAccJerkMag-std()_
* _tBodyGyroMag-mean()_
* _tBodyGyroMag-std()_
* _tBodyGyroJerkMag-mean()_
* _tBodyGyroJerkMag-std()_
* _fBodyAcc-mean()-X_
* _fBodyAcc-mean()-Y_
* _fBodyAcc-mean()-Z_
* _fBodyAcc-std()-X_
* _fBodyAcc-std()-Y_
* _fBodyAcc-std()-Z_
* _fBodyAcc-meanFreq()-X_
* _fBodyAcc-meanFreq()-Y_
* _fBodyAcc-meanFreq()-Z_
* _fBodyAccJerk-mean()-X_
* _fBodyAccJerk-mean()-Y_
* _fBodyAccJerk-mean()-Z_
* _fBodyAccJerk-std()-X_
* _fBodyAccJerk-std()-Y_
* _fBodyAccJerk-std()-Z_
* _fBodyAccJerk-meanFreq()-X_
* _fBodyAccJerk-meanFreq()-Y_
* _fBodyAccJerk-meanFreq()-Z_
* _fBodyGyro-mean()-X_
* _fBodyGyro-mean()-Y_
* _fBodyGyro-mean()-Z_
* _fBodyGyro-std()-X_
* _fBodyGyro-std()-Y_
* _fBodyGyro-std()-Z_
* _fBodyGyro-meanFreq()-X_
* _fBodyGyro-meanFreq()-Y_
* _fBodyGyro-meanFreq()-Z_
* _fBodyAccMag-mean()_
* _fBodyAccMag-std()_
* _fBodyAccMag-meanFreq()_
* _fBodyBodyAccJerkMag-mean()_
* _fBodyBodyAccJerkMag-std()_
* _fBodyBodyAccJerkMag-meanFreq()_
* _fBodyBodyGyroMag-mean()_
* _fBodyBodyGyroMag-std()_
* _fBodyBodyGyroMag-meanFreq()_
* _fBodyBodyGyroJerkMag-mean()_
* _fBodyBodyGyroJerkMag-std()_
* _fBodyBodyGyroJerkMag-meanFreq()_
* _angle(tBodyAccMean,gravity)_
* _angle(tBodyAccJerkMean),gravityMean)_
* _angle(tBodyGyroMean,gravityMean)_
* _angle(tBodyGyroJerkMean,gravityMean)_
* _angle(X,gravityMean)_
* _angle(Y,gravityMean)_
* _angle(Z,gravityMean)_

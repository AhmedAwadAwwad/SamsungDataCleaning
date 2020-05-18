# Samsung Data Cleaning Codebook
Author: Phil Lombardo


The following codebook describes the variables and files for this data cleaning project. Specifically, we will describe the variables that appear in the data frame we called `df` and the tidy data set of means for the accelerometer data we called `tidayDataMeans`.  (For more information, see the README.md file in this repository.)

*Note:*  Codebook and descriptions for the original data can be found by downloading [this zipped file.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Variables and descriptions in `df`:
As mentioned in the README.md, the `run_analysis.R` script took raw files from [this zipped folder](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of data. This raw data took measurements from an accelerometer and gyroscope in a Samsung phone and recorded activity while participants did different activities. We performed the following modifications:

1. Merged the test and training set;
2. Extractd the variables from the accelerometer that involve means and standard deviations for the accelerometer data;
3. Changed the output variable, "Activity", so that the variable values are descriptive;
4. Provided descriptive variables names to the `df`.

We created a new data set in the fifth step, but since this part of the codebook only deals with `df`, we move on to the data description.

#### Variables in `df`:
The data frame `df` consists of 88 variables:

- **SubjectID**: is a unique, integer identifier for the 30 participants in this study.

- **Activity**: records the activity the participant was doing while this Samsung data was collect. There are 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

- **86 different variables from the original data set**: These 86 variables are means or standard deviations of measurements from a gyroscope and accelerometer on the phone, or some sort of important transform of these measurements. They are highly technical, so I defer to the original codebook data [available here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). After unzipping this file, the information is recorded in a file called "features\_info.txt". *For clarity, I kept all of the same variable names so that the original codebook and documentation would apply to our current files as well!*

For some brief background and grounding, here is a direct quote from that file:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


## Variables and descriptions for `tidyDataMeans.txt`:
To create the `tidayDataMeans.txt` data set, we performed the following actions:

1. We grouped each of our 86 measurements from the original data set by **SubjectID** and **Activity**.
2. For each grouping, we computed the _mean_ of the measurement involved.

#### Variables in `tidyDataMeans.txt`:
The variables in this data set are as follows:

- **SubjectID**: a unique, integer identifier that tells us the subject to whom the row corresponds.
- **Activity**: a factor variable describing the activity the participant was doing at the time the measurements were taken, and hence, the mean we associated.
- **kind**:  This is a factor variable that indicates which _kind_ of measurement the row records. Specifically, the possiblve values of this variable are the 86 different measurements from the data frame `df` described in the previous section.  Each of these 86 measurements from the accelerometer or gyroscope is reperesented.
- **averageValue**: this variable contains the _mean measurement_, where the type of measurement we consider is identified by the value of the **kind** variable for that row. The units depend on the original units of the measurement. (See raw data Codebook for more.)





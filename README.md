# Samsung Data Cleaning Exercise Repository

### General Description:

The following repository aims to provide the details of working with Samsung
accelerometer and activity data. Specifically, we aim to combine the data and put it into a specific format. Lastly, we generate a tidy data frame that summarizes key variables.  

The original data comes the 
UCI Machine Learning Repository, *Human Activity Recognition Using Smartphone Data Set*, which you can access [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  However, the raw files this repository uses can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). This is part of data cleaning activity for a Coursera course.


This repository contains:

* `CodeBook.md`: a description of the data and variables for this project.  This is largely a modification of the original codebook files provided by the UCI data repository.

* `run_analysis.R`: an R script that takes the raw files ([available here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) and combines subject IDs, accelerometer data, and activity type for a testing and training set into a single data frame.  Lastly, it generates a tidy-format data frame that summarizes key variables.

The remainder of this README is designed to provide a step-by-step walkthrough of the analysis in the R-script `run_analysis.R`.

### Explanation of `run_analysis.R`:
The `run_analysis.R` file follows specific steps provided in the instructions of the activity. Below, we will highlight each step and explain the R-code involved in completing that step.  For convenience, specific parts of the code will be labeled and correspond to comments in the R-script.

#### Step 0:
We begin by loading the packages that we use for the assignment; specifically, `dplyr` for data manipulation and `tidyr` for recasting the format of our dataframes when necessary.  Everything else is done in Base R.

In this step we also load the data. The code assumes that the R-script is sitting in the same directory as the data downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and unzipped.  The data folder will be "UCI HAR Dataset".

*** 

#### Step 1:
> Merges the training and the test sets to create one data set.

Before doing this, I want to rename the vectors for the subject id and activity dataframes. This will avoid confusing variable names later. (See *S1\_prep* in the R script.)

To merge the data, we will 

1. Create training and testing data frames with all information. This will involved:  
    a. Bind, as columns, the subject ID, accelerometer data, and the activity data for the training data. We call this data frame `train_df`. (See *S1\_1a*)
    b. Bind, as columns, the subject ID, accelerometer data, and the activity data for the testing data. We call this data frame `test_df`. (See *S1\_1b*)

2. After doing a quick dimension check (we want to make sure these two data frames have the same number of columns), we bind, *as rows*, these new data frames for train and test into one data frame. We call this data frame `full_df`. (See *S1\_2*)

*Quick note:* There are 563 columns of this data frame. The first is our Subject ID, and the last is the Activity type.  This leaves 561 variables coming from the acceleromater, which we verify using the `features.txt` file in the downloaded data. This file lists the variables from the accelerometer.


***

####  Step 2:

> Extract only measurements that involve a mean or
> standard deviation of the accelerometer data.

As mentioned above, the middle 561 columns correspond to the features listed in the `features.txt` file of the downloaded data. We start by loading that into a variable called "features" and store it as a character vector. (See *S2\_1*)

To find the variables of interest, we'll use regular expressions to grab those variables in the `features` vector that involve the word "Mean", "mean", "Std", or "std". The grep command will give us variable numbers where these values occur. We save these under the variable name `mean_std_variable_numbers`. (See *S2\_2a*.)

Now using the paste command, we can append the "V" to the front of these numbers to return a vector with the default names that R assigned when we created our original `full_df` data frame.  We store this in `variable_names_keep`. (See *S2\_2b*.)

We want to make sure we include our subject ID and our activity variables as well. We create a new character vector called `final_variables` that adds these variables to our accelerometer variables we want to keep. (See *S2\_3*.)

Last but not least, we can use this character vector of names to subset our `full_df` into a data frame that only contains our variables of interest.  We call this final data frame `df`. (See *S2\_4*.)

***

#### Step 3
> Uses descriptive activity names to name the activities.

Our last variable in `df`, "Activity", is currently an integer vector, where each number corresponds to a specific activity. To make this more understandable, this step has us switch the integers with a name of the actual activity.

Notice that in the downloadable data we have a nice file associating the integer in the Activity column to text description of the activity. We will read that into R and use it to create  simple function that maps an integer input to a text output describing the activity. (See *S3\_1*.)

In our next step, we use the `sapply` function with our newly minted `label_fxn` to replace the integer entries with the text description. We save the result temporarily under the variable name `descriptiveActivity`. (See *S3\_2*.)

Finally, we overwrite the "Activity" variable (which currently contains integers) with our vector `descriptiveActivity`. This variable is now more understandable. (See *S3\_3*.)

***

#### Step 4 
> Appropriately labels the data set with descriptive variable names.

I'm not a physicist, so I'm going to assume that the variable labels in features.txt are appropriately descriptive, and use them. (See the `CodeBook.md` in this repository for more description of these variable names.)

Recall from step *S2\_1*, we already have the feature names provided by the original researches as a character vector in R called `features`. We also already have the variable numbers that we kept in when the columns of the accelerometer data: 
`mean_std_variable_numbers`, from step *S2\_2a*.

Let's subset the `features` vector using the indices in `mean_std_variable_numbers` to get a vector of the correct names for the data we kept.  We store the answer in `accelerometer_variable_names`. (See *S4\_1*.)

Remembering we have our first variables as "SubjectID" and our last variable as "Activity", we can create a vector for all the names of the data frame. We call it `all_names`. (See *S4\_2*.)

Finally, we assign `all_names` to our data frame `df`. (See *S4\_3*.)


*Quick note:* The data frame `df` currently has all the data with which we have chosen to work. Our last step involves manipulating and summarizing this data.

#### Step 5

> From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A tidy data frame, as I interpret it, would have the following variables:

  * `SubjectID`: indicates the subject for whom the data corresponds;
  * `Activity`: indicates the activity the subject was doing when the accelerometer data was measured;
  * `kind`: indicates the kind of accelerometer data recorded in that row;
  * `averageValue`: the average value of the given *kind* of accelerometer data for that row.
  
To get a table in this form, we start by manipulating our data frame `df` so that it is in a longer format. (This will lend itself better to computations using the `dplyr`package.) 

Rather than having 86 separate variables from the accelerometer, we *gather* these into two variables: "kind" and "values", which tell us 

* the *kind* of measurement from the accelerometer, and 
* the *value* for that  measurement.

We save this under the name `long_df`. (See *S5\_1*.)

Finally, we create our tidy data set of means for each person, activity, and measurement *kind* using the `group_by()` and `summarise()` functions from `dplyr`. I save the output under the name `tidyDataMeans`. (See *S5\_2*.)


#### Supplementary Stuff
The last bits of code in the `run_analysis.R` file just share how I wrote the `tidyDataMeans` data frame into a text file, and how to take the generated file and re-load it into R.

Reading generated file into R:

`tidyDataMeans<-read.table("tidyDataMeans.txt",header = T)`



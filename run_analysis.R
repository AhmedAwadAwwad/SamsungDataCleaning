# Loading packages needed below
library(dplyr)
library(tidyr)

# Loading the raw data files.
# Training files first
# The accelerometer data
XTrain<-read.table("../UCI_HAR_Dataset/train/X_train.txt")
# The activity information
YTrain<-read.table("../UCI_HAR_Dataset/train/Y_train.txt")
# the subject ID
SubjectTrain<-read.table("../UCI_HAR_Dataset/train/subject_train.txt")

#grab testing files
# The accelerometer data
XTest<-read.table("../UCI_HAR_Dataset/test/X_test.txt")
# The activity information
YTest<-read.table("../UCI_HAR_Dataset/test/Y_test.txt")
# the subject ID
SubjectTest<-read.table("../UCI_HAR_Dataset/test/subject_test.txt")


############
## Step 1 ##
############

# Merging the training and test sets.
# We will do this in two steps
  # 1. Create training and testing data frames with
  #   all information:
    # a. bind as columns the subject ID, accelerometer
    #  data, and the activity data for the training data
    # b. bind as columns the subject ID, accelerometer
    #  data, and the activity data for the testing data
  # 2. bind, as rows, these new data frames for train and test
  #  into one data frame.

# Before doing this, I want to rename the vectors for 
# the subject id and activity dataframes. This will avoid
# confusion later.

names(SubjectTrain)<-"SubjectID"
names(SubjectTest)<-"SubjectID"
names(YTrain)<-"Activity"
names(YTest)<-"Activity"

train_df<-data.frame(SubjectTrain, XTrain,YTrain)
names(train_df)
test_df<-cbind(SubjectTest, XTest,YTest)
names(train_df)

# Dimension check: they should have same number of 
# columns.
dim(train_df)
dim(test_df)
# Notice there are 563 columns.  The middle 561 correspond to
# the 561 features in feature.txt; they are currently labeled
# V1, V2, ... V561.

full_df<-rbind(train_df, test_df)

dim(full_df)
names(full_df)

#############
##  Step 2 ##
#############

# Extract only measurements that involve a mean or
# std deviation of the accelerometer data.

# As mentioned above, the middle 561 columns correspond to
# the features listed in the features.txt file. Let's load
# that and take a look.

features<-read.table("../UCI_HAR_Dataset/features.txt")[,2] %>%
  as.character()

# These 561 feature names are now stored in a vector as
# characters.  We'll use regular expressions to grab those
# that involve the word Mean, mean, Std, or std.

# The grep command will give us variable numbers where these
# values occur. We save these under the variable name
# "mean_std_variable_numbers".
mean_std_variable_numbers<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
                       features)

# Now using the paste command, we can append the "V" to the front
# and have a vector of the appropriate column names that we
# want to keep from full_df.
variable_names_keep<-paste("V",mean_std_variable_numbers,sep="")

# Lastly, we want to make sure we include our subject ID
# and our activity.
final_variables<-c("SubjectID",variable_names_keep,"Activity")


# Now we can subset our full_df to include only these variables:
df<-full_df[,final_variables]


############
## Step 3 ##
############

# rename the entries  in the final column, the activity level,
# to make them more understandable.

# Notice that in the data we have a nice "table" associating 
# the value in the Ytrain vector to an actual activity level.
# We will read that in and use it to create  simple function
# that will switch out an number for an activity!

activity.labels<-read.table("../UCI_HAR_Dataset/activity_labels.txt")
activity.labels
label_fxn<-function(n){
  activity.labels[n,2]
}

descriptiveActivity<-sapply(df$Activity,label_fxn)

#Now we replace our activity column with this descriptive 
# vector.
df$Activity <- descriptiveActivity




############
## Step 4 ##
############

# Appropriately labels the data set with descriptive variable names.

# I'm not a physicist, so I'm going to assume that the variable
# labels in features.txt are appropriately descriptive, and use
# them.  Recall we already have the features as a character 
# vector in R:
features

# we also already have the variable numbers that we kept in 
# selecting the columns of the accelerometer data.
mean_std_variable_numbers

# subsetting the features variable, we can select just those names:
accelerometer_variable_names<-features[mean_std_variable_numbers]
# At this point we can do a quick visual check to see all these
# variables have Mean or STD in the name.

# Now we simply add these names to the middle vectors; i.e., NOT
# the SubjectID or Activity.
all_names<-c("SubjectID",accelerometer_variable_names,"Activity")
names(df)<-all_names

names(df)

############
## Step 5 ##
############

# From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and 
# each subject.

# We start by putting the data frame into a longer format. Rather 
# than 86 variables, we gather it into two variables kind and values
# which tell us the "kind of measurement" and the "value for that 
# measurement". We save this under the name long_df.

long_df<-df %>% 
  gather(kind, value,
         -c(SubjectID, Activity))

# Finally, we create our tidy data set of means for each person,
# activity, and measurement type.

tidyDataMeans<-long_df %>% 
  group_by(SubjectID, Activity,kind) %>%
  summarise(averageValue = mean(value))
  
# In our last step, we write this to a text file. 
write.table(tidyDataMeans, "tidyDataMeans.txt",row.names = F)

#test read:
df2<-read.table("tidyDataMeans.txt",header = T)
head(df2)
names(df2)
dim(df2)
dim(tidyDataMeans)

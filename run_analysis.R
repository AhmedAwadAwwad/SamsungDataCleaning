# Loading packages needed below
library(dplyr)
library(tidry)

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

# The grep command will give us column numbers where these
# values occur. We save these under the variable name
# "mean_std_columns_initial".
mean_std_columns_initial<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
                       features)

alt_col_names<-paste("V",mean_std_columns_initial,sep="")

# Keeping in mind that the first column of full_df is the
# subject id, we want to shift these by 1.
mean_std_columns<-mean_std_columns_initial + 1

# Lastly, we want to make sure we include our subject ID
# and our activity.
final_columns<-c(1,mean_std_columns,563)
# Now we can subset our full_df to include only these columns:

df<-full_df[,final_columns]


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





mean_std_columns<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
     features_char)

updated_Xtrain<-Xtrain[,mean_std_columns]

# Add meaningful names, as provided by their own ReadMe
# file.
names(updated_Xtrain)<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
                            features_char,
                            value = T)

head(updated_Xtrain)

dim(updated_Xtrain)
dim(Ytrain)
dim(Subtrain)

# Probably want to rbind() the subject ID and
# classification first, then run this whole 
# analysis again with the test sets and cbind them.

# first, let's clean up the levels of the Ytrain
Ytrain$V1 %>% class()
activity.labels<-read.table("../UCI_HAR_Dataset/activity_labels.txt")
activity.labels
label_fxn<-function(n){
  activity.labels[n,2]
}

descriptiveYtrain<-sapply(Ytrain$V1,label_fxn)
class(descriptiveYtrain)

# dimensions still fit.
descriptiveYtrain %>% length()
dim(updated_Xtrain)

train_df<-cbind(Subject_ID = Subtrain$V1,
     updated_Xtrain,
     Activity = descriptiveYtrain)

train_df %>% names()

# Repeating on test data stuff.

updated_Xtest<-Xtest[,mean_std_columns]

# Add meaningful names, as provided by their own ReadMe
# file.
names(updated_Xtest)<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
                            features_char,
                            value = T)

head(updated_Xtest)

#dimensions check
dim(updated_Xtest)
dim(Ytest)
dim(Subtest)



descriptiveYtest<-sapply(Ytest$V1,label_fxn)
class(descriptiveYtest)

# dimensions still fit.
descriptiveYtest %>% length()
dim(updated_Xtest)

test_df<-cbind(Subject_ID = Subtest$V1,
                updated_Xtest,
                Activity = descriptiveYtest)

test_df %>% dim()

final_df<-rbind(train_df, test_df)
names(final_df)


# getting means of all columns except the Subject_ID
# and Activity.

# Currently in Side format, with measurements broken up over
# columns
library(tidyr)
long_df<-final_df %>% 
  gather(kind, value,
         -c(Subject_ID, Activity))

format0<-long_df %>% group_by(Subject_ID, Activity, kind) %>% 
  summarise(avg = mean(value))

format1<-long_df %>% group_by(Subject_ID, Activity, kind) %>% 
  summarise(avg = mean(value)) %>%
  spread(Activity,avg)

# data check
format0 %>% group_by(Subject_ID, Activity) %>%
  summarise(n()) %>% filter(Subject_ID ==6)

length(mean_std_columns)

#Notice that every subject is tested on each activity,
# and we have an average recorded for each of the 
# 86 different "meaningful" measuremnts.

# Looks good.

# Samsung Cleaning Data Script
# Author: Phil Lombardo

############
## Step 0 ##
############

library(dplyr)
library(tidyr)

#Load Training Data:
XTrain<-read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<-read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")

# Load Testing Data
XTest<-read.table("UCI HAR Dataset/test/X_test.txt")
YTest<-read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt")


############
## Step 1 ##
############

#S1_prep
names(SubjectTrain)<-"SubjectID"
names(SubjectTest)<-"SubjectID"
names(YTrain)<-"Activity"
names(YTest)<-"Activity"

#S1_1a
train_df<-data.frame(SubjectTrain, XTrain,YTrain)

#S1_1b
test_df<-cbind(SubjectTest, XTest,YTest)


# Dimension check
dim(train_df)
dim(test_df)
# Notice there are 563 columns.  The middle 561 correspond to
# the 561 features in feature.txt; they are currently labeled
# V1, V2, ... V561.

#S1_2
full_df<-rbind(train_df, test_df)

dim(full_df)
names(full_df)

#############
##  Step 2 ##
#############

# S2_1
features<-read.table("../UCI_HAR_Dataset/features.txt")[,2] %>%
  as.character()

# S2_2a
mean_std_variable_numbers<-grep("(.*[Mm]ean.*)|(.*[Ss]td.*)",
                       features)

# S2_2b
variable_names_keep<-paste("V",mean_std_variable_numbers,sep="")

# S2_3
final_variables<-c("SubjectID",variable_names_keep,"Activity")

#S2_4
df<-full_df[,final_variables]


############
## Step 3 ##
############

#S3_1
activity.labels<-read.table("../UCI_HAR_Dataset/activity_labels.txt")
activity.labels
label_fxn<-function(n){
  activity.labels[n,2]
}

# S3_2
descriptiveActivity<-sapply(df$Activity,label_fxn)

# S3_3
df$Activity <- descriptiveActivity


############
## Step 4 ##
############

# S4_1
accelerometer_variable_names<-features[mean_std_variable_numbers]

# S4_2.
all_names<-c("SubjectID",accelerometer_variable_names,"Activity")

# S4_3
names(df)<-all_names


############
## Step 5 ##
############

# S5_1
long_df<-df %>% 
  gather(kind, value,
         -c(SubjectID, Activity))

# S5_2
tidyDataMeans<-long_df %>% 
  group_by(SubjectID, Activity,kind) %>%
  summarise(averageValue = mean(value))
 

#########################
## Supplementary Stuff ##
#########################


# Code for exporting the tidy data summary file
write.table(tidyDataMeans, "tidyDataMeans.txt",row.names = F)

# Code for reading the tidy data summary file just exported
tidyDataMeans<-read.table("tidyDataMeans.txt",header = T)

library(dplyr)
library(zip)
library(stringr)
options(warn=-1)

#Download Zip File
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipdest <- "dataset.zip"
if (!file.exists(zipdest)) download.file(url,zipdest)

#check if data file exists and unzip the file
if (!file.exists("./UCI HAR Dataset/train/X_train.txt")) unzip(zipdest)


#import activity_labels.txt 
activity_labels <- as_tibble(read.csv("./UCI HAR Dataset/activity_labels.txt",header = FALSE, sep = ""))
names(activity_labels) <- c("activity_id","activity_name")

#import features.txt with training field names
training_fields_names <- as_tibble(read.csv("./UCI HAR Dataset/features.txt",header = FALSE, sep = ""))



#import training Files
####Import X_train.txt (Training set)
training_db <- as_tibble(read.csv("./UCI HAR Dataset/train/X_train.txt",header = FALSE, sep = ""))
names(training_db) <- training_fields_names$V2

####Import y_train.txt (Training labels)
training_labels <- as_tibble(read.csv("./UCI HAR Dataset/train/y_train.txt",header = FALSE, sep = ""))
names(training_labels) <- c("activity_id")

####Import subject_train.txt (subject identification)
training_subjects <- as_tibble(read.csv("./UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = ""))
names(training_subjects) <- c("subjects_id")

#join, by rows,  training_subjects with training_labels and activity_labels
temp <- bind_cols(training_subjects, training_labels)

#join temp file created with activity_labels  and get activity name
#Uses descriptive activity names to name the activities in the data set
temp2 <- inner_join(temp,activity_labels, by = c("activity_id"="activity_id"))

#join, by rows, training_db with temp2
training_db <- bind_cols(temp2, training_db)

#add col set_type
training_db <- mutate(training_db, set_type = "TRAINING", .after=activity_name)

#remove unecessary objects
rm("training_labels")
rm("training_subjects")
rm("temp")
rm("temp2")


#import test Files
####Import X_test.txt (Training set)
testing_db <- as_tibble(read.csv("./UCI HAR Dataset/test/X_test.txt",header = FALSE, sep = ""))
names(testing_db) <- training_fields_names$V2

####Import y_test.txt (Training labels)
testing_labels <- as_tibble(read.csv("./UCI HAR Dataset/test/y_test.txt",header = FALSE, sep = ""))
names(testing_labels) <- c("activity_id")

####Import subject_test.txt (subject identification)
testing_subjects <- as_tibble(read.csv("./UCI HAR Dataset/test/subject_test.txt",header = FALSE, sep = ""))
names(testing_subjects) <- c("subjects_id")

#join, by rows,  test_subjects with test_labels and activity_labels
temp <- bind_cols(testing_subjects, testing_labels)

#join temp file created with activity_labels  and get activity name
#Uses descriptive activity names to name the activities in the data set
temp2 <- inner_join(temp,activity_labels, by = c("activity_id"="activity_id"))

#join, by rows, training_db with temp2
testing_db <- bind_cols(temp2, testing_db)

#add col set_type
testing_db <- mutate(testing_db, set_type = "TESTING", .after=activity_name)


#remove unecessary objects
rm("testing_labels")
rm("testing_subjects")
rm("temp")
rm("temp2")

rm("activity_labels")
rm("training_fields_names")


#Merges the training and the test sets to create one data set.
allsets <- temp <- bind_rows(training_db, testing_db)
View(allsets)
rm("training_db")
rm("testing_db")

#Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_and_std <- select(allsets, c(subjects_id, set_type, activity_name, matches("(mean|std)")))

#Appropriately labels the data set with descriptive variable names. 
mx <- matrix(c(
  "tBodyAcc-","time_body_accelerated-","tGravityAcc-","time_gravity_accelerated-",
  "tBodyAccJerk-","time_body_accelerated_jerk-","tBodyGyro-","time_body_gyroscope-",
  "tBodyGyroJerk-","time_body_gyroscope_jerk-","tBodyAccMag-",
  "time_body_accelerated_magnitude-","tGravityAccMag-",
  "time_gravity_accelerated_magnitude-","tBodyAccJerkMag-",
  "time_body_accelerated_jerk_magnitude-","tBodyGyroMag-",
  "time_body_gyroscope_magnitude-","tBodyGyroJerkMag-",
  "time_body_gyroscope_jerk_magnitude-","fBodyAcc-",
  "frequency_body_accelerated-","fBodyAcc-bandsEnergy()-",
  "frequency_body_accelerated_bands_energy-",
  "fBodyAccJerk-","frequency_body_accelerated_jerk-",
  "fBodyAccJerk-","frequency_body_accelerated_jerk_bands_energy-",
  "fBodyGyro-","frequency_body_gyroscope-","fBodyGyro-",
  "frequency_body_gyroscope_bands_energy-","fBodyAccMag-",
  "frequency_body_accelerated_magnitude-","fBodyBodyAccJerkMag-",
  "frequency_body_accelerated_jerk_magnitude-","fBodyBodyGyroMag-",
  "frequency_body_gyroscope_magnitude-","fBodyBodyGyroJerkMag-",
  "frequency_body_gyroscope_jerk_magnitude-","angle-",
  "signal_window_sample_average","\\(\\)",
  "","-","_"
), ncol = 2, byrow =TRUE)

for (i in 1:nrow(mx)){
  names(mean_and_std)<-sapply(names(mean_and_std), function(x){
    str_replace_all(x, mx[i,1], mx[i,2])})
}

View(mean_and_std)


#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
avg_by_activity_and_subject <- select(mean_and_std, -set_type)
avg_by_activity_and_subject <- group_by(avg_by_activity_and_subject, subjects_id, activity_name)
avg_by_activity_and_subject <- summarise(avg_by_activity_and_subject, across(where(is.numeric), mean))


View(avg_by_activity_and_subject)
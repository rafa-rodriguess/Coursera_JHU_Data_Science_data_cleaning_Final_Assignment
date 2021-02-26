# Getting and Cleaning Data - Human Activity Recognition Using Smartphones - Code Book

## Objetive:
This codebook's main objective is to describe the variables, the data, and any transformations or work performed to clean up the data of the Human Activity Recognition Using Smartphones.

## The Data:
This project uses the collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[Human Activity Recognition Using Smartphone][ID]
[ID]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  "Title"

The files can be downloaded at:

[Dataset.zip][ID2]
[ID2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Dataset.zip"

More about the data, take a look at:
**README.txt ** ([Dataset.zip][ID2])
[ID2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Dataset.zip"

## The Variables:

Extracted from **features_info.txt**  ([Dataset.zip][ID2])
[ID2]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Dataset.zip"

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

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

## The Transformation:

All the functions listed below can be found at "**getting_cleaning_data.R**"

#### Step 01 - Downloading file
...**Function Name:** downloadZipFile()

  **Objective:** Downloads file from the repository and unzip it.

  **Returns:** All the files unzipped in the working folder.


#### Step 02 - Loading files

  **Function Name:** loadFiles()

  **Objective:** Loads all the necessary files from the working folder into memory.

  **Returns:** *testing_db* and *trainning_db* containing all the features from the training and the testing set.


#### Step 03 - Loading files

  **Function Name:** mergeTables()

  **Objetive:** Merges 2 tables (*testing_db* and *trainning_db* ) by rows. Deletes origin tables.

  **Returns:** One merged table.


#### Step 04 - Select proper features

  **Function Name:** select_mean_std()

  **Objetive:** Extracts only the measurements on the mean and standard deviation for each measurement.

  **Returns:** One table cotaining only the selected variables.


#### Step 04 - Fixing tables variables labels

  **Function Name:** fixLabels()

  **Objetive:** Appropriately labels the data set with descriptive variable names.

  **Returns:** One table cotaining the same table but with appropriately labels.


#### Step 04 - Creating a summaried table

  **Function Name:** createSummarisedTable()

  **Objetive:** Creates a data set with the average of each variable for each activity and each subject.

  **Returns:** One table summarizes by activity and subject.


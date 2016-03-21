==============================================================
Coursera Getting and Cleaning Data
Course Project
==============================================================
Andy Cataldo
==============================================================
Study Design
==============================================================
The script run_analysis.R and codebook provided rely on data gathered from Samsung Galaxy S smartphones. 

The dataset was downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset includes the following files, with observations on state of data contained in each:
=============================================================

- 'README.txt': Outlines information on the Human Activity Recognition Using Smartphones Dataset Version 1.0, conducted by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto at Smartlab in Genoa, Italy. The experiment was conducted with a group of 30 subjects ranging in age from 19 to 48, grouped into 2 groups: test and train. Observations were made on 561 variables throughout 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing the smartphone device. Refer to this file for more details outlining source and experiment performed. 

- 'features_info.txt': Shows information about the variables used on the feature vector. Gives details on naming conventions used for the variables.

- 'features.txt': List of all features. Total 561 observations with ID and variable name (read as dataframe with 2 columns). Variable names can be enhanced to be more descriptive.

- 'activity_labels.txt': Links the class labels with their activity name. Total 6 observations with ID and name (read as dataframe with 2 columns).

- 'train/X_train.txt': Training set. Contains 7352 observations on 561 variables, all numeric.

- 'train/y_train.txt': Training labels. Contains 7352 observations on 1 integer variable, corresponding to the activity performed by the subject. Should be bound with x_train.txt and subject_train.txt for a complete data set.

- 'test/X_test.txt': Test set. Contains 2947 observations on 561 variables, all numeric.

- 'test/y_test.txt': Test labels. Contains 2947 observations on 1 integer variable, corresponding to the activity performed by the subject. Should be bound with x_test.txt and subject_test.txt for a complete data set.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Note that this needs to be bound with x_test.txt and y_test.txt for the test data set, and with x_train.txt and y_train.txt in the train data set in order to build a complete data set. subject_test.txt for the test data set contains 2947 observations on 1 variable. subject_train.txt for the train dataset contains 7352 observations on 1 variable.

==============================================================
Note: did not use Intertial Signals data in run_analysis.R.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

==============================================================
Code Book 
Used for on analysis performed within run_analysis.R
==============================================================
The script requires that files downloaded above are stored in current working directory

directory - character vector of length 1 containing home directory with "/UCI Har Dataset/" added to simplify mapping to extracted files

activity - dataframe pulled from "activity_labels.txt" with 6 observations on 2 variables:
    actid - integer 1-6
    actname - factor with 6 levels outlining activity names

features - dataframe pulled from "features.txt" containing 561 observationson 2 variables:
    V1 - integer 1-561
    V2 - character vector containing variable names for data collected. later will be enhanced to contain more descriptive info using a series of gsub statements

xtest - dataframe of 2947 observations on 561 variables, all numeric

xtrain - dataframe of 7352 observations on 561 variables, all numeric

extract - integer vector of length 66, containing subset of features for index of variables containing "mean()" or "std()"

ytest - dataframe extracted from "y_test.txt" containing 2947 observations on 1 integer variable, corresponding to the activity performed by the subject

ytrain - dataframe extracted from "y_train.txt" containing 7352 observations on 1 integer variable, corresponding to the activity performed by the subject

subtest - dataframe extracted from "subject_test.txt" containing 2947 observations on 1 integer variable, corresponding to the subject being observed 

subtrain - dataframe extracted from "subject_train.txt" containing 7352 observations on 1 integer variable, corresponding to the subject being observed 

testdata - dataframe composed of 2947 observations with 69 variables..
    partition - factor labeling all data in this set as "test"
    activity - integer labeling the activity type observed
    all remaining variables are numeric, measuring mean() or std()
    
traindata - dataframe composed of 7352 observations with 69 variables..
    partition - factor labeling all data in this set as "train"
    activity - integer labeling the activity type observed
    all remaining variables are numeric, measuring mean() or std()

fulldata - row bind testdata and traindata to create complete dataframe of 69 variables and 10299 observations

tidy - dataframe with 68 variables with 180 observations. creates a new tidy dataset containing mean for each variable for each activity and each subject
    activity - factor indicating descriptive activity name
    subject - integer indicating subject, 1-30
    all remaining variables are numeric, measuring the mean of all variables in original dataset that measured mean() or std()

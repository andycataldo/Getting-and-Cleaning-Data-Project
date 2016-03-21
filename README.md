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
Details on analysis performed within run_analysis.R
==============================================================
The script requires that files downloaded above are stored in current working directory

First the script reads file activity_labels.txt, to be used as mapping table.

Read variable names from features.txt and store in variable.

Leveraging the features_info.txt, replace certain abbreviations to make the variable names more descriptive. Use a series of gsub statements:
replace leading t with "time", leading f with "frequency". Substitute "Acc" with "Acceleration", "Gyro" with "Gyroscope", "Mag" with "Magnitude", "arCoeff" with "AutoregressionCoefficient", "igr" with "InterquartileRange", "sma" with "SignalMagnitude", "Inds" with "Index" and "Freq" with "Frequency".

Then read in data from X_train.txt and X_test.txt and assign enhanced variable names to the dataset. 

Next read subject and y (activity) data from remaining files in test and train folders so that train, test and subject data can be bound together later.

To subset only columns containing mean and standard deviation use grep statement to find all column names containing "mean()" or "std()", using appropriate escape characters for parentheses.
Then subset the x_test and x_train datasets to show the subset of the columns.

Now use cbind to combine data from x_test.txt, y_test.txt (activity) and subject_test.txt (subject), and repeat for train data. Also added a column called "partition" to indicate for each observation if it was from the train or test dataset. 
Use rbind to combine rows from each dataset into one consolidated dataset called fulldata.

Match activity number in fulldata to the activity dataframe extracted from activity_labels.txt and create a new column actname with the descriptive label for each record in fulldata.

Re order columns to keep partition, subject, activity id, and activity name together.. with all variable data together in the fulldata dataframe.
Use aggregate to summarize mean of each variable (means and standard deviations only) on activity and subject.
Extract to a file called "tidydata.txt" for final submission

# Getting-and-Cleaning-Data-Project
# Getting-and-Cleaning-Data-Project

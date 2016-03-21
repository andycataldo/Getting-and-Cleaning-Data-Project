# script requires that you have downloaded the files to current working directory
# read extracted files

# declare a variable to the home directory of extracted data
directory <- paste0(getwd(),"/UCI Har Dataset/")

# create dataframe 'activity' to store activity labels
activity <- read.table(paste0(directory,"activity_labels.txt"),header=F)
names(activity) <- c("actid","actname")

# store variable names from features.txt to label columns in final dataset
features <- read.table(paste0(directory,"features.txt"),header=F)

# develop more meaningful feature names
# replace "prefix 't' to denote time" and prefix 'f' with frequency
# replace Acc with Acceleration, Mag with Magnitude, Gyro with Gyroscope
# remove repeating "Body"
features[,2] <- gsub("^t","time",features[,2])
features[,2] <- gsub("^f","frequency",features[,2])
features[,2] <- gsub("*Acc*","Acceleration",features[,2])
features[,2] <- gsub("*Mag*","Magnitude",features[,2])
features[,2] <- gsub("*Gyro*","Gyroscope",features[,2])
features[,2] <- gsub("BodyBody","Body",features[,2])
features[,2] <- gsub("arCoeff","AutoregressionCoefficient",features[,2])
features[,2] <- gsub("igr","InterquartileRange",features[,2])
features[,2] <- gsub("sma","SignalMagnitude",features[,2])
features[,2] <- gsub("Inds","Index",features[,2])
features[,2] <- gsub("Freq","Frequency",features[,2])

# get data from X_test and X_train
xtest <- read.table(paste0(directory,"test/X_test.txt"),header=F)
xtrain <- read.table(paste0(directory,"train/X_train.txt"),header=F)

# assign features.txt labels to the 561 columns in xtrain & xtest
names(xtest) <- features[,2]
names(xtrain) <- features[,2]

# extract only measurements on man and standard deviation for each measurement
extract <- grep("mean\\(\\)|std\\(\\)",features$V2)
xtest <- xtest[,extract]
xtrain <- xtrain[,extract]

# read data from Y_test and Y_train to merge
ytest <- read.table(paste0(directory,"test/Y_test.txt"), header=F)
names(ytest) <- c("activity")
ytrain <- read.table(paste0(directory,"train/Y_train.txt"), header=F)
names(ytrain) <- c("activity")

# read subject data from test & train to prepare for merge
subtest <- read.table(paste0(directory,"test/subject_test.txt"), header=F)
names(subtest) <- c("subject")
subtrain <- read.table(paste0(directory,"train/subject_train.txt"), header=F)
names(subtrain) <- c("subject")

# combine all data to one table
testdata <- cbind(partition="test", subtest, ytest, xtest)
traindata <- cbind(partition="train", subtrain, ytrain, xtrain)
fulldata <- rbind(testdata, traindata)

# create a column to store the activity name
fulldata$actname <- activity$actname[match(fulldata$activity,activity$actid)]

# reorder columns to put activity and activity name together
fulldata <- fulldata[c(1,2,3,70,4:69)]

# create independent tidy data set with average for each variable 
# for each activity and each subject
# extract to a csv file
tidy <- aggregate(fulldata[,5:70],list(Activity = fulldata$actname, Subject = fulldata$subject), mean)

write.table(tidy, file=paste0(directory,"tidydata.txt"), row.names=FALSE)

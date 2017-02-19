load the required libraries:

if(!require("data.table"))
{
        install.packages("data.table")
}
if(!require("reshape2"))
{
        install.packages("reshape2")
}
require("data.table")
require("reshape2")
library("plyr")
Download the files and load data files.

Following code checks if the zip file is already present. If the file is not present, zip file is downloaded and then extracted using unzip.

Subsequently the code loads all the data files.

if(!require("data.table"))
{
        install.packages("data.table")
}
if(!require("reshape2"))
{
        install.packages("reshape2")
}
require("data.table")
require("reshape2")



dPath <- file.path(path, "UCI HAR Dataset")

xtrain <- tbl_df(data.table(read.table(file.path(dPath, "train", "X_train.txt"))))
xtest <- tbl_df(data.table(read.table(file.path(dPath, "test", "X_test.txt"))))

ytrain <- tbl_df(data.table(read.table(file.path(dPath, "train", "y_train.txt"))))
ytest <- tbl_df(data.table(read.table(file.path(dPath, "test", "y_test.txt"))))

strain <- tbl_dfif(!require("data.table"))
{
        install.packages("data.table")
}
if(!require("reshape2"))
{
        install.packages("reshape2")
}
require("data.table")
require("reshape2")


(data.table(read.table(file.path(dPath, "train", "subject_train.txt"))))
stest <- tbl_df(data.table(read.table(file.path(dPath, "test", "subject_test.txt"))))

dim(xtrain)
dim(xtest)
dim(ytrain)
dim(ytest)
dim(strain)
dim(stest)

features <- tbl_df(data.table(read.table(file.path(dPath, "features.txt"))))
dim(features)

labels <- tbl_df(data.table(read.table(file.path(dPath, "activity_labels.txt"))))
dim(labels)
Rename the columns:

Following code renames the column names for activity, subject, features and labels data frame.

# Reading All data files in specific format
activity1<- read.table(file.path(path_rf,"activity_labels.txt"))[,2]
feature<- read.table(file.path(path_rf,"features.txt"))

dataactivity_test<- read.table(file.path(path_rf,"test","y_test.txt"))
dataactivity_train<- read.table(file.path(path_rf,"train","y_train.txt"))
datasubject_test<- read.table(file.path(path_rf,"test","subject_test.txt"))
datasubject_train<-read.table(file.path(path_rf,"train","subject_train.txt"))
datafeature_test<-read.table(file.path(path_rf,"test","x_test.txt"))
datafeature_train<-read.table(file.path(path_rf,"train","x_train.txt"))
1. Merges the training and the test sets to create one data set.

Following code performs the rbind to merge the training and test data set. And then the code performs the cbind all data sets.

datasubject<-rbind(datasubject_test,datasubject_train)
dataactivity<-rbind(dataactivity_test, dataactivity_train)
datafeature<-rbind(datafeature_test,datafeature_train)
2. Extracts only the measurements on the mean and standard deviation for each measurement.

Following code greps only the mean and std. deviation features to create new vector. And then only the columns [mean, std. deviation, subject, activityNum] from the fulldata.

subdatafeaturename<- feature$V2[grep("mean\\(\\)|std\\(\\)",feature$V2)]
selectednames<- c(as.character(subdatafeaturename), "subject", "activity")
Data<- subset(data, select = selectednames)

Data2<-aggregate(. ~subject + activity, Data, mean)
4. Appropriately labels the data set with descriptive variable names.

Following code greps and replaces the activity names with descriptive names.

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Following code writes the tidy data into TidyData.txt.

write.table(Data2,file="tidydata.txt", row.names = FALSE)

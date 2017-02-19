# pre install required package
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
# creating direcory and geing data and files
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# unziping the folder

unzip(zipfile="./data/Dataset.zip",exdir="./data")
# printing List of Files

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
#setwd("F:/Data Science/Course Eara/Course-3 Geting and Cleaning Data/Project/UCI HAR Dataset/")
# Reading All data files in specific format
activity1<- read.table(file.path(path_rf,"activity_labels.txt"))[,2]
feature<- read.table(file.path(path_rf,"features.txt"))

dataactivity_test<- read.table(file.path(path_rf,"test","y_test.txt"))
dataactivity_train<- read.table(file.path(path_rf,"train","y_train.txt"))
datasubject_test<- read.table(file.path(path_rf,"test","subject_test.txt"))
datasubject_train<-read.table(file.path(path_rf,"train","subject_train.txt"))
datafeature_test<-read.table(file.path(path_rf,"test","x_test.txt"))
datafeature_train<-read.table(file.path(path_rf,"train","x_train.txt"))


# Comnbining different tables into one specific format


datasubject<-rbind(datasubject_test,datasubject_train)
dataactivity<-rbind(dataactivity_test, dataactivity_train)
datafeature<-rbind(datafeature_test,datafeature_train)

names(datasubject)<- c("subject")
names(dataactivity)<-c("activity")
names(datafeature)<- feature$V2
datacombine<- cbind(datasubject, dataactivity)
data<- cbind(datafeature,datacombine)

# geting mean and standard deiveation of the tables

subdatafeaturename<- feature$V2[grep("mean\\(\\)|std\\(\\)",feature$V2)]
selectednames<- c(as.character(subdatafeaturename), "subject", "activity")
Data<- subset(data, select = selectednames)

# cleaing up the data and remodify the details
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# data manipulation and data writing into table

library("plyr")
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<- Data2[order(Data2$subject, Data2$activity),]
write.table(Data2,file="tidydata.txt", row.names = FALSE)


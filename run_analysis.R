library(dplyr)
library(plyr)

setwd("C:/Coursera/Getting and Cleaning Data/Course Project/Data")

DataSetTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
DataSetTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Header <- read.table("./UCI HAR Dataset/features.txt")
SubjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
SubjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
ActivityTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
ActivityTest<-read.table("./UCI HAR Dataset/test/y_test.txt")
ActivityLabel<-read.table("./UCI HAR Dataset/activity_labels.txt")

colnames(DataSetTrain)<-Header[,2]
colnames(DataSetTest)<-Header[,2]
DataSetTrain<-mutate(DataSetTrain, Case = "Train")
DataSetTest<-mutate(DataSetTest, Case = "Test")
colnames(SubjectTrain)<-"SubjectId"
colnames(SubjectTest)<-"SubjectId"
colnames(ActivityTrain)<-"ActivityId"
colnames(ActivityTest)<-"ActivityId"
colnames(ActivityLabel)<-c("ActivityId","ActivityLabel")  

DataSetTrain<-cbind(cbind(DataSetTrain,SubjectTrain),ActivityTrain)
DataSetTest<-cbind(cbind(DataSetTest,SubjectTest),ActivityTest)
DataSet<-rbind(DataSetTrain, DataSetTest)

meanColumns<-grep("mean()", names(DataSet))
stdColumns<-grep("std()", names(DataSet))

DataSetMean<-DataSet[,meanColumns]
DataSetStd<-DataSet[,stdColumns]
DataSetKeys<-DataSet[,c("Case","SubjectId","ActivityId")]
DataSetMeanStd<-cbind(cbind(DataSetMean, DataSetStd), DataSetKeys)
DataSetMeanStd<-inner_join(DataSetMeanStd,ActivityLabel, by="ActivityId")


ActivityIdColNum<-grep("ActivityId",names(DataSetMeanStd))
DataSetMeanStd<-DataSetMeanStd[,-ActivityIdColNum]

names(DataSetMeanStd)<-gsub("^t", "time", names(DataSetMeanStd))
names(DataSetMeanStd)<-gsub("^f", "frequency", names(DataSetMeanStd))
names(DataSetMeanStd)<-gsub("Acc", "Accelerometer", names(DataSetMeanStd))
names(DataSetMeanStd)<-gsub("Gyro", "Gyroscope", names(DataSetMeanStd))
names(DataSetMeanStd)<-gsub("Mag", "Magnitude", names(DataSetMeanStd))
names(DataSetMeanStd)<-gsub("BodyBody", "Body", names(DataSetMeanStd))

TidyData<-aggregate(DataSetMeanStd, by=list(SubjectId=DataSetMeanStd$SubjectId,ActivityLabel=DataSetMeanStd$ActivityLabel), FUN=mean)
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

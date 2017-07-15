## this section downloads the file and saves it in a local directory

if(!file.exists("C:/Users/p417492/Desktop/Data Science/Directory/data/project")){dir.create("C:/Users/p417492/Desktop/Data Science/Directory/data/project")}
ziPfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(ziPfile,destfile="C:/Users/p417492/Desktop/Data Science/Directory/data/project/Dataset.zip",method="auto")

## this section unzips the file

unzip(zipfile="C:/Users/p417492/Desktop/Data Science/Directory/data/project/Dataset.zip",exdir="C:/Users/p417492/Desktop/Data Science/Directory/data/project")

## this section gets the list of the files into a variable

path_data <- file.path("C:/Users/p417492/Desktop/Data Science/Directory/data/project", "UCI HAR Dataset")

## this section reads the data from files into variables

##Activity

dATest  <- read.table(file.path(path_data, "test" , "Y_test.txt" ),header = FALSE)
dATrain <- read.table(file.path(path_data, "train", "Y_train.txt"),header = FALSE)

##Subject

dSTrain <- read.table(file.path(path_data, "train", "subject_train.txt"),header = FALSE)
dSTest  <- read.table(file.path(path_data, "test" , "subject_test.txt"),header = FALSE)


##Features

dFTest  <- read.table(file.path(path_data, "test" , "X_test.txt" ),header = FALSE)
dFTrain <- read.table(file.path(path_data, "train", "X_train.txt"),header = FALSE)


## Combines tables using rbind

dSubject <- rbind(dSTrain, dSTest)
dActivity<- rbind(dATrain, dATest)
dFeatures<- rbind(dFTrain, dFTest)

## Put names to variables created above

names(dSubject)<-c("subject")
names(dActivity)<- c("activity")
dFNames <- read.table(file.path(path_data, "features.txt"),head=FALSE)
names(dFeatures)<- dFNames$V2

## Merge columns to get a data frame from all data

alldata <- cbind(dSubject, dActivity)
Data <- cbind(dFeatures, alldata)

## calculates mean and standard dev
## Subset Name of Features by measurements on the mean and standard deviation

subdFNames<-dFNames$V2[grep("mean\\(\\)|std\\(\\)", dFNames$V2)]

## Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdFNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

## creates labels for the activity data set

labels_activity <- read.table(file.path(path_data, "activity_labels.txt"),header = FALSE)


## change the variables with clearer names

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## creates data set and output

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

## section that creates the code book
library(knitr)
knit2html("codebook.Rmd")

setwd("~/Documents/R WORKMAP")

if (!file.exists("data"))
{dir.create("data")}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#All files are downloaded in the ./mydata folder

download.file(fileurl,"./data/wearable.zip", method="curl")

#After unzipping the data in my ./data folder I execute some list.files 
#statements to locate training and test data

list.files("./data/UCI HAR Dataset/train/Inertial Signals")

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE)
features <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE)

#Underneath all global training data is read in

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE)
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt", header=FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE)


X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE)
Y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt", header=FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

#Merge all TRAIN and TEST datasets together: In my view it is an APPEND and NOT a merge...

subject <-rbind(subject_train,subject_test)
colnames(subject)<- c("subject")
X_total <-rbind(X_train,X_test)

#Only keep features with mean and std values

features2 <- features[c(grep("mean()",features$V2, fixed=TRUE),grep("std()",features$V2, fixed=TRUE)),]

#Drop all irrelevant text characters from the values in variable V2 in the features3 list

features2 <- cbind(paste0("V",features2$V1),features2)
features3 <-gsub("-","",features2$V2)
features3 <-gsub("()","",features3, fixed=TRUE)
X_total <- X_total[,features2$V1]
# assign the reformatted names to the V variables in the dataset
colnames(X_total) <- c(features3)

Y_total <-rbind(Y_train,Y_test)

# activities are labeled in the activity variable

Y_total <- merge(Y_total,activity_labels,by.x="V1",by.y="V1")
colnames(Y_total) <- c("V1","activity")
Y_total <- Y_total[c("activity")]

#Underneath All sets are merged together: No specific merge used, since no ID values

total <- as.data.frame(c(X_total,Y_total,subject))

# reshape data first and afterwards apply the dcast function to get 
# the mean of the requested combinations for all variables
test <- melt(total,id=c("activity","subject"),measure.vars=c(features3))
mean_total <- dcast(test,subject + activity ~variable, mean)

write.table(mean_total, "./data/subject_activity_mean.txt", sep="\t", row.name=FALSE)


library(data.table)

#Import X_train and X_Test data
xdata_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
xdata_test <- read.table('./UCI HAR Dataset/test/X_test.txt')

# Import Y_train and Y_Test data
ydata_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
ydata_test <- read.table('./UCI HAR Dataset/test/y_test.txt')

#Import Subject_train and Subject_Test data
subjectdata_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
subjectdata_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# merging train and test data for X, Y and Subject
xdata <- rbind(xdata_train, xdata_test)
ydata <- rbind(ydata_train, ydata_test)
subjectdata <- rbind(subjectdata_train, subjectdata_test)

# read activity labels and apply to the ydata
activitydata <- read.table("./UCI HAR Dataset/activity_labels.txt")
activitydata[, 2] = gsub("_", "", tolower(as.character(activitydata[, 2])))
ydata [,1] = activitydata[ydata[,1], 2]
names(ydata) <- "Activity"

# get the mean and the std values
featuresdata <- read.table("./UCI HAR Dataset/features.txt")
mean_std_features <- grep("-mean\\(\\)|-std\\(\\)", featuresdata[, 2])
Xdata_mean_std<-xdata[,mean_std_features]
names(Xdata_mean_std)<-tolower(gsub("\\(|\\)", "", featuresdata[mean_std_features, 2]))

# label the subject data and merge all the data
names(subjectdata) <- "Subject"
mergedata <- cbind(subjectdata, ydata, Xdata_mean_std)

# write the merge data
write.table(mergedata, "merge_meanstd_data.txt")

# get a data only using the average of the merge data
group <- c('Subject', 'Activity')
columns<- (3:68)
  
datatable<- data.table(mergedata)
averagedata <- datatable[, lapply(.SD, mean), by=group, .SDcols=columns]

# write the result average data
write.table(averagedata, "average_data.txt")



# Makes a tidy data frame to begin working on then merges into a single data set

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_y <- read.table('./UCI HAR Dataset/train/y_train.txt')
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt')

test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_y <- read.table('./UCI HAR Dataset/test/y_test.txt')
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt')

features <- read.table('./UCI HAR Dataset/features.txt')

dt_x <- rbind(test_x, train_x)
dt_y <- rbind(test_y, train_y)
dt_subject <- rbind(test_subject, train_subject)



# Extracts only the measurements on the mean and standard deviation for each measurement
meanSTD<-grep('mean\\(\\)|std\\(\\)', features[,2])
dt_x<-dt_x[,meanSTD]


# Uses descriptive activity names to name the activities in the data set
activity <- read.table('./UCI HAR Dataset/activity_labels.txt')
dt_y[,1] <- activity[dt_y[,1],2]


# Appropriately labels the data set with descriptive variable names
names <- features[meanSTD,2]
names(dt_x) <- names
names(dt_subject) <- "Subject ID"
names(dt_y) <- "Activity"
ndt <- cbind(dt_subject, dt_y, dt_x)


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ndt <- data.frame(ndt)
tidy <- ndt[, lapply(.SD, mean), by = 'SubjectID,Activity']
write.table(tidy, file = "data_tidy.txt", row.names = FALSE)

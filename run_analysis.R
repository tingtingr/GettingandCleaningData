# loading training data

subject_train <- fread('../GCD3/GettingandCleaningData/train/subject_train.txt')
trainset <- fread('../GCD3/GettingandCleaningData/train/X_train.txt')
trainlabel <- fread('../GCD3/GettingandCleaningData/train/y_train.txt')

# loading test data

subject_test <- fread('../GCD3/GettingandCleaningData/test/subject_test.txt')
testset <- fread('../GCD3/GettingandCleaningData/test/X_test.txt')
testlabel <- fread('../GCD3/GettingandCleaningData/test/y_test.txt')

#loading features and activity labels
features <- fread('../GCD3/GettingandCleaningData/features.txt')
activity_labels <- fread('../GCD3/GettingandCleaningData/activity_labels.txt')


#1. Merges the training and the test sets to create one data set.
#add the columne that indicates who performed the activities
trainset <- cbind(subject_train, trainlabel, trainset)
testset <- cbind(subject_test, testlabel, testset)

#merge the training set and the test set
allset <- rbind(trainset,testset)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

# Step 1. Assign names to the combined set

names(allset) <- c('Subject','Activity',features[,V2])

#Step 2. Select column names with mean or std, there are 86 columns.Plus the subject and the activity, there are 88 columns
collist <-grep('(*Mean*)|(*std*)', names(allset), value=TRUE,ignore.case = TRUE)
meanAndsd <- allset[,c('Subject','Activity',collist),with=FALSE]

# 3.Uses descriptive activity names to name the activities in the data set
for (i in 1:dim(meanAndsd)[1]){
  activity_code <- as.numeric(meanAndsd$Activity[i])
  activity_name <- activity_labels$V2[activity_code]
  meanAndsd$Activity[i] <- activity_name
}

# activity_labels
# V1                 V2
# 1:  1            WALKING
# 2:  2   WALKING_UPSTAIRS
# 3:  3 WALKING_DOWNSTAIRS
# 4:  4            SITTING
# 5:  5           STANDING
# 6:  6             LAYING

# > table(meanAndsd$Activity)
# 
# 1    2    3    4    5    6 
# 1722 1544 1406 1777 1906 1944 

# > table(copy$Activity)
# 
# LAYING            SITTING           STANDING            WALKING 
# 1944               1777               1906               1722 
# WALKING_DOWNSTAIRS   WALKING_UPSTAIRS 
# 1406               1544 

#checked the count of different activities match

#4.Appropriately labels the data set with descriptive variable names.
#Have already done in  2 and 3

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

meanAndsd.melted <- melt(meanAndsd, id = c("Subject", "Activity"))
meanAndsd.mean <- dcast(meanAndsd.melted, Subject + Activity ~ variable, mean)
write.table(meanAndsd.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
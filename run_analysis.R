
train_filelist <- list.files(pattern = 'train/*\\.txt',all.files = TRUE,recursive = TRUE)
# > train_filelist
# [1] "train/Inertial Signals/body_acc_x_train.txt"  "train/Inertial Signals/body_acc_y_train.txt" 
# [3] "train/Inertial Signals/body_acc_z_train.txt"  "train/Inertial Signals/body_gyro_x_train.txt"
# [5] "train/Inertial Signals/body_gyro_y_train.txt" "train/Inertial Signals/body_gyro_z_train.txt"
# [7] "train/Inertial Signals/total_acc_x_train.txt" "train/Inertial Signals/total_acc_y_train.txt"
# [9] "train/Inertial Signals/total_acc_z_train.txt" "train/subject_train.txt"                     
# [11] "train/X_train.txt"                            "train/y_train.txt"                           
test_filelist <- list.files(pattern = 'test/*\\.txt',all.files = TRUE,recursive = TRUE)
# > test_filelist
# [1] "test/Inertial Signals/body_acc_x_test.txt"  "test/Inertial Signals/body_acc_y_test.txt" 
# [3] "test/Inertial Signals/body_acc_z_test.txt"  "test/Inertial Signals/body_gyro_x_test.txt"
# [5] "test/Inertial Signals/body_gyro_y_test.txt" "test/Inertial Signals/body_gyro_z_test.txt"
# [7] "test/Inertial Signals/total_acc_x_test.txt" "test/Inertial Signals/total_acc_y_test.txt"
# [9] "test/Inertial Signals/total_acc_z_test.txt" "test/subject_test.txt"                     
# [11] "test/X_test.txt"                            "test/y_test.txt"    

training <- lapply(train_filelist, fread)
names(training) <- gsub(".*/.*/(.*).txt$", "\\1", train_filelist)
# > names(training)
# [1] "body_acc_x_train"        "body_acc_y_train"        "body_acc_z_train"        "body_gyro_x_train"      
# [5] "body_gyro_y_train"       "body_gyro_z_train"       "total_acc_x_train"       "total_acc_y_train"      
# [9] "total_acc_z_train"       "train/subject_train.txt" "train/X_train.txt"       "train/y_train.txt"
train_all <- do.call(cbind, training)
# > dim(train_all)
# [1] 7352 1715

#do the same for testing
testing <- lapply(test_filelist,fread)
names(testing) <- gsub(".*/.*/(.*).txt$", "\\1", test_filelist)
test_all <- do.call(cbind, testing)
# > dim(test_all)
# [1] 2947 1715

res <- function(trainpath, testpath){
  ##load training set and testing  set
  training <- load(trainpath)
  testing <- load(testpath)
  ## 1. Merges the training and the test sets to create one data set.
  completeSet <- cbind(training, testing)
  
}
setwd("./UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set

setwd("./test")
X_test=read.table("X_test.txt")
y_test=read.table("y_test.txt")
subject_test=read.table("subject_test.txt")
test_table=cbind(subject_test,y_test,X_test)
setwd("..");setwd("train")
X_train=read.table("X_train.txt")
y_train=read.table("y_train.txt")
subject_train=read.table("subject_train.txt")
train_table=cbind(subject_train,y_train,X_train)
test_train_table=rbind(test_table,train_table)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

setwd("..")
features=read.table("features.txt")

ind_mean = grep("mean",features[,2])
ind_std = grep("std",features[,2])

## add +2 for the first two columns, which come from subject and y .txt files
mean_std_table = test_train_table[,c(1:2,c(ind_mean,ind_std)+2)]

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels = read.table("activity_labels.txt")

activity_vector=c()
for(i in seq(nrow(mean_std_table))){
  ind_activity = mean_std_table[i,2]
  activity_vector=c(activity_vector,as.character(activity_labels[ind_activity,2]))
}

mean_std_table = cbind(mean_std_table[,1],
                        activity_vector,
                        mean_std_table[,3:ncol(mean_std_table)])

# 4. Appropriately labels the data set with descriptive variable names

mean_variables = as.character(features[c(ind_mean),2])
std_variables = as.character(features[c(ind_std),2])

colnames(mean_std_table) = c("Subject","Activity",mean_variables,std_variables)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(dplyr)

tidy_data_set = mean_std_table %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean), matches("mean"), matches("std"))

write.table(tidy_data_set,file = "tidy_data_set.txt",row.names = FALSE)

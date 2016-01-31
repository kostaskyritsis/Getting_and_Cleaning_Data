# Codebook for the run_analysis.R script

The the code of the script is separated by # and the name of the task that it performs, as defined by the Assignment: Getting and Cleaning Data Course Project - Instructions page of the class.

The directory UCI HAR Dataset contains the .txt files with the data and it must be within your current working directory.

# 1. Merges the training and the test sets to create one data set

X_test and X_train are the vectors containing the data for all subjects and activities.

y_test and y_train are the vectors containing the information about the activity of each measurement (row).

subject_test and subject_train are the vectors containing the information about the subject of each measurement (row).

test_table and train_table are data frames, which contain the information about the subjects, the activities and the data of the test and train datasets respectively.

test_train_table is the data frame that contains both the test_table and the train_table data.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

features is the data frame that contains the information about the type of the measurements (variables -> columns).

ind_mean and ind_std are the vectors with the positions of the variables that contain the terms "mean" and "std".

mean_std_table is the data frame that contains only the measurements (variables -> columns) on the mean and standard deviation for each measurement (rows). 

Because the positions were extracted directly from feature.txt file, the number 2 was added to each position in order to subset properly the variables from test_train_table.

# 3. Uses descriptive activity names to name the activities in the data set

activity_labels is the data frame that contains the names of the activities and the ID number for each activity.

activity_vector is the vector that contains the names of the activities (the ID numbers for the activities, contained in the 2nd variable (column) were replaced with their respective names of activities).

The second column of mean_std_table is replaced with the values from the activity_vector.

# 4. Appropriately labels the data set with descriptive variable names

mean_variables and std_variables contain the names of the variables (columns).

By applying the colnames function the variables (columns) of the mean_std_table data frame are assigned with the names "Subject","Activity", mean_variables and std_variables.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

For the final task of the assignment, the functions %>%, group_by and summarise_each, from the dplyr package, are required. 

The %>% function passes the data set directly to the next command, the group_by function selects the variables Subject and Activity to group the data and the function summarise_each extracts the average from the rest of the variables, by defining funs(mean).

Tidy_data_set is the final data frame containing the tidy data with the average of each variable for each activity and each subject.

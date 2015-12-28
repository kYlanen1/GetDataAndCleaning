# Getting and Cleaning Data Project

The R script called run_analysis.R does the following: 

  -Merges the training and the test sets to create one data set.
  -Extracts only the measurements on the mean and standard deviation for each measurement. 
  -Uses descriptive activity names to name the activities in the data set
  -Appropriately labels the data set with descriptive variable names. 
  -From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each    subject
  
It assumes that the working directory is C:/Coursera/Getting and Cleaning Data/Course Project/Data

The outcome of the R script is the text file TidyData.txt which is attached to the cource project.
This data set is tidy because each variable is saved in it own column and each observation is saved in its own row.

For more information please read the CookBook.md file

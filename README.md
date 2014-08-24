r_programming_coursera: Getting and Cleaning Data
======================

The purpose of this file is to describe the scripting for the getting and cleaning data project

1/ 
Set working directory
2/ 
Check whether the data folder exists. This will be the folder where all content will be  downloaded
3/
Continue exercise only with the TRAIN and TEST files X, Y and SUBJECT. Inertial signals datasets will NOT be treated in this exercise
4/
The X_TRAIN and X_TEST files are appended underneath each other and only variables with mean and std values are subset. Variable names are cleaned towards nice descriptives.
5/
The Y_TRAIN and Y_TEST files are appended and values are replaced with their corresponding descriptive labels. Variable is renamed to activity
6/
SUBJECT_TRAIN and SUBJECT_TEST are appended
7/
The three appended datasets described above are merges into one dataset: TOTAL
8/ 
The TOTAL dataset is reshaped first and afterwards manipulated with the dcast function to get the mean of the requested combinations for all variables
9/
Final results are exported to a TXT file: subject_activity_mean.txt. This file is put into github for peer grading


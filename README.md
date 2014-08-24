GettingCleaningDataCourseProject
================================

Course project for Getting and Cleaning Data on Coursera

Variables are explained in CodeBook.md

Read individual files and combine them together into a single data frame

Extract only mean and std columns.

Change activity numbers to activity names

Remove dashes and parentheses to make variable names more readable

Run tapply on each variable column, by subject and activity
Flatten the matrix produced by tapply
cbind the vector to the data frame

cbind the subject and activity labels back to the end data frame

Write the tidy dataset out to tidy.txt

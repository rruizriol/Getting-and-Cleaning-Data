Getting and Cleaning Data Project Code Book
===========================================

### Original data
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Transformation
Test and Training data are merged for the X data, Y data and Subject data
Read activity data and apply to the Y data
The std and mean values, are extracted from the X data
Label all the data
Merge the generated data in one dataset
Create another dataset with the averages of all features

### Results dataset
merge_meanstd_data.txt<br/>
average_data.txt

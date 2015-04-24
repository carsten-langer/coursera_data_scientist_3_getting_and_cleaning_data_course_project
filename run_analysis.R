# R script for Coursera Data Scientist / Getting and Cleaning Data / course project work.
#
# Prerequisites
# The data is downloaded from course provided link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# The data zip file is extracted such that its folder `UCI HAR Dataset` is placed in the R working directory.

# Libraries
require(dplyr)

# Reading in the data
# X_train.txt uses basically a fixed length format, therefore it has 1 or 2 spaces between columns.
# data.table::fread cannot handle multiple separators, therefore read.table must be used.
# As read.table results in a data frame instead of a data table as in fread, for simplicity, all the code uses data frames.

# Get training data, get test data, merge and clean up
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_all <- rbind(subject_train, subject_test)
rm(subject_train)
rm(subject_test)

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_all <- rbind(x_train, x_test)
rm(x_train)
rm(x_test)

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_all <- rbind(y_train, y_test)
rm(y_train)
rm(y_test)

# Give x_all data columns the right name
features <- read.table("./UCI HAR Dataset/features.txt")
names(x_all) <- features$V2

# Give the activities a nice name
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities <- left_join(y_all, activity_labels, by = c("V1" = "V1"))

# Select the needed columns
# It would have been nice to use contains() method from dplyr select() function, but the names of x_all are not unique, as features$V2 contains duplicated names.
# Example: "fBodyGyro-bandsEnergy()-9,16" exists 3 times. This is the same for all columns with such names.
# It looks like the name should have been added with a -X, -Y, -Z, like "fBodyGyro-bandsEnergy()-X9,16"
# However, due to the duplicate column names, dplyr select() cannot be used.
# Therefore find the correct columns containing "mean" and "std" the old-fashioned way.
# Use grepl in the posix style, i.e. escape the "(" so that they are searched for literally.
cols <- grepl("-mean\\(\\)", features$V2) | grepl("-std\\(\\)", features$V2)
df <- x_all[, cols] %>%
        mutate(activity = activities$V2) %>%
        mutate(subject = subject_all$V1)
detach(package:dplyr)

# Calculate average per variable
# Melt data frame, and aggregate per group via dcast
require(reshape2)
df_molten <- melt(df, c("activity", "subject"))
means <- dcast(df_molten, activity + subject ~ variable, mean)
write.table(means, file = "average_per_activity_and_subject.txt", row.names = F)
detach(package:reshape2)


# Alternative A)
# Not so nice, as it requires anonymous function, as
## colMeans() requires only numeric columns in the data frame, so the variable columns activity and subject have to be removed from the data frame
## subset() requires a data frame, else it falls back to subset.default()
## I don't know how to pass the internal, temporary, grouped data frame from ddply to its function
## Therefore I create the anonymous function.
#require(plyr)
#means1 <- ddply(df, .(activity, subject), function(x){colMeans(subset(x, select = c(-activity, -subject)))})
#write.table(means1, file = "average_per_activity_and_subject_alternative1.txt", row.names = F)
#detach(package:plyr)


# Alternative B)
# Not so nice, as it requires 2 packages, reshape for melt/dcast and dplyr to summarize/group_by.
# As dcast can do the grouped aggregation, using the dplyr summary function seems not appropriate
#require(reshape2)
#require(dplyr)
#m <- melt(df, c("activity", "subject"))
#means2_molten <- summarize(group_by(m, activity, subject, variable), mv = mean(value))
#means2 <- dcast(means2_molten, activity + subject ~ variable, value.var = "mv")
#write.table(means2, file = "average_per_activity_and_subject_alternative2.txt", row.names = F)
#detach(package:dplyr)
#detach(package:reshape2)


# Alternative C)
# Nice as well, requires no extra packages, but requires an explicit statement on the number of columns in order
# to subset df to not contain the activity and subject columns.
#means3 <- aggregate(df[,1:66], by=list(activity = df$activity, subject = df$subject), mean)
#write.table(means3, file = "average_per_activity_and_subject_alternative3.txt", row.names = F)

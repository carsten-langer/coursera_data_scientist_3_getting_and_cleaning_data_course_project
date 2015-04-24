# Coursera Data Scientist / Getting and Cleaning Data / course project work


## Contents
This course project work includes the following files:

- _README.md_
- _CodeBook.md_: Describes the tidy data set.
- _average_per_activity_and_subject.txt_: Tidy data set: Average values per measurement per activity and subject.
- _run_analysis.R_: The R script to convert from raw to tidy data.

## Explanations on _run_analysis.R_
This outlines what the R script does.

### Prerequisites
* The data is downloaded from course provided link: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
* The data zip file is extracted such that its folder _UCI HAR Dataset_ is placed in the R working directory.

### Merge training and test data
For all 3 types of raw data _subject\_....txt_, _X\_....txt_, and _y\_....txt_, both train and test files are read in and the data frames combined via `rbind()` to 1 data frame `..._all` per type. The individual train and test data frames are removed to free up the memory.

### Labelling the data
The raw data file _features.txt_ contains the labels for all feature variables of the _X\_....txt_ files. It is read in and the labels applied via `names()` as column names to the `x_all` data frame.

The raw data file _activity_labels.txt_ contains the labels for all activities codes.
The data frame `y_all` contains the activity code fore each observation of the `x_all` data frame. The activity labels are read and joined with the `y_all` data frame such that in the resulting new data frame `activities` each observation now has not only the activity code but also the activity label.

### Chosing the columns of the tidy data set
The `x_all` data frame contains 561 variables. We are only interested in those variables, which describe the mean or the standard deviation of the underlying feature. Find these columns via `grepl()` and regular expressions filtering on "mean()" or "std()" as part of the feature variable labels. The resulting logical vector is then used to subset the columns of `x_all`.

Use `dplyr` piping (`%>%`) and `mutate` to further add the activity labels and subject as new columns. Store the result in a data frame `df`.

Detach, i.e. unload the `dplyr` package. This was basically done so that when testing some alternatives (see below) it was clear which alternative needs to load which package.

### Aggregating the tidy data set
To calculate the mean per feature variable, grouped by activity and subject, I use this approach:

`melt()` the `df` data frame, using `activity` and `subject` as id variable. That automatically selects all other variables as measured variables, whithout the need to code the names of the 60+ variables. The `molten_df` data frame then contains a column _variable_ containing the label of the feature variable, and a column _value_ containing the corresponding observation value.

`dcast()` the molten data frame back to a data frame with `activity + subject` forming the grouping in the first dimension (rows), and `variable` forming the second dimension (columns). As aggregation function I use `mean` as we need the average per feature variable. This casting creates 1 row per combination of `activity` and `subject` as an aggregation group, creates 1 column per `variable` to restore the original feature variables as columns, and applies the function `mean` to each subset of the _value_ observations grouped by the combination of both dimensions, i.e. per activity, subject and feature variable.

Finally the result is saved as a _average_per_activity_and_subject.txt_ file created with `write.table()` using `row.names = F`, as by the course work instructions.


### Alternatives
Some alternative ways to run the aggregation on the `df` data frame, leading to the same results (well, 1 slight rounding error was observed), but to me they seemed less favorable. They are kept in the source code to remember what else I tried and why I decided against it. They are commented out so they will not harm.
 
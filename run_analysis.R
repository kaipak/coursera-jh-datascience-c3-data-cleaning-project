###############################################################################
#
# Load 'X' training and test datasets and apply labels from features.txt. Cull
# this down to only columns containing mean or stdev labels and combine with 
# subject and y datasets. Finally, combine test and train data into single 
# table.
# 
# Separately, an averaging dataset is created from this combined dataset.
#
###############################################################################
library(tidyr)

features <- read.csv('UCI_HAR_ds/features.txt', header = FALSE, 
                     sep=' ', col.names = c('num', 'desc'), check.names=FALSE)
# Include only columns that are a mean or standard deviation
wanted_feat <- features[grepl('(mean|std)', features$desc),]

# Create the pared down test set
X_test <- read.csv('UCI_HAR_ds/test/X_test.txt', header=FALSE, sep='')
X_test <- select(X_test, wanted_feat$num)
colnames(X_test) <- wanted_feat$desc
# Add names of activity to our dataset
y_test <- read.csv('UCI_HAR_ds/test/y_test.txt', header=FALSE, 
                   col.names='activity_num')
y_test <- mutate(y_test, activity=case_when(activity_num == 1 ~ 'WALKING',
                                            activity_num == 2 ~ 'WALKING_UPSTAIRS',
                                            activity_num == 3 ~ 'WALKING_DOWNSTAIRS',
                                            activity_num == 4 ~ 'SITTING',
                                            activity_num == 5 ~ 'STANDING',
                                            activity_num == 6 ~ 'LAYING'))
# Get subject dataset 
subject_test <- read.csv('UCI_HAR_ds/test/subject_test.txt', header=FALSE, 
                         col.names='subject')
# Now combine all results into a test set
test_ds <- cbind(y_test, subject_test, X_test)

# Create the pared down train set
X_train <- read.csv('UCI_HAR_ds/train/X_train.txt', header=FALSE, sep='')
X_train <- select(X_train, wanted_feat$num)
colnames(X_train) <- wanted_feat$desc
y_train <- read.csv('UCI_HAR_ds/train/y_train.txt', header=FALSE, 
                    col.names='activity_num')
y_train <- mutate(y_train, activity=case_when(activity_num == 1 ~ 'WALKING',
                                              activity_num == 2 ~ 'WALKING_UPSTAIRS',
                                              activity_num == 3 ~ 'WALKING_DOWNSTAIRS',
                                              activity_num == 4 ~ 'SITTING',
                                              activity_num == 5 ~ 'STANDING',
                                              activity_num == 6 ~ 'LAYING'))
# Get subject dataset 
subject_train <- read.csv('UCI_HAR_ds/train/subject_train.txt', header=FALSE, 
                         col.names='subject')
# Now combine all results into a train set
train_ds <- cbind(y_train, subject_train, X_train)

# Combine all test and train.
full_ds <- rbind(test_ds, train_ds) %>% select(-('activity_num'))
# Create an averaged dataset
mean_ds <- group_by(full_ds, subject, activity) %>% summarize_all(funs(mean))

# Clean up!
rm(train_ds, test_ds, y_train, X_train, y_test, X_test, wanted_feat, 
   features, subject_train, subject_test)
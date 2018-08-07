library(tidyr)

# Load 'X' training and test datasets and apply labels from features.txt. Cull
# this down to only columns containing mean or stdev labels.
features <- read.csv('UCI_HAR_ds/features.txt', header = FALSE, 
                     sep=' ', col.names = c('num', 'desc'), check.names=FALSE)
# Get rid of special characters that may cause parsing issues
features$desc <- gsub("(-|\\(|\\)|\\,)", "", features$desc)
# Include only columns that are a mean or standard deviation
wanted_feat <- features[grepl('(mean|std)', features$desc),]

# Create the pared down test set
X_test <- read.csv('UCI_HAR_ds/test/X_test.txt', header=FALSE, sep='')
X_test <- select(X_test, wanted_feat$num)
colnames(X_test) <- wanted_feat$desc

# Create the pared down train set
X_train <- read.csv('UCI_HAR_ds/train/X_train.txt', header=FALSE, sep='')
X_train <- select(X_train, wanted_feat$num)
colnames(X_train) <- wanted_feat$desc

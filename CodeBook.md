# Code Book
This doc describes the datasets, variables, and essential functionality of the script.

What are essentially dataset column headers are kept in a separate flatfile in the original dataset called `features.txt`. This was turned into a dataset where `grepl('(mean|std)')` was applied so that we could get the column numbers and names we're interested in collecting. From, here a vector of feature numbers was used in a `select()` function call against the `X_(test|train)` datasets so as to extract only the columns of interest. These datasets were then column combined with the other flat files that were converted into datasets. The only other function of note in this process is the use of `case_when` to convert the activity numbers into human readable form:

```
mutate(y_test, activity=case_when(activity_num == 1 ~ 'WALKING',
                                  activity_num == 2 ~ 'WALKING_UPSTAIRS',
                                  activity_num == 3 ~ 'WALKING_DOWNSTAIRS',
                                  activity_num == 4 ~ 'SITTING',
                                  activity_num == 5 ~ 'STANDING',
                                  activity_num == 6 ~ 'LAYING')
```

`full_ds` is then `grouped_by` subject and activity and a table of mean values is produced using `summarize_all(funs(mean))` and saved as `mean_ds`. Intermediate datasets are cleaned up in the final line of code in the script which can be commented out if desired.

## Data Dictionary 
As this data is a tidied and extracted version from an existing set, the definitions regarding the 
dynamical measurements are roughly the same and will be copied here for convenience. New datasets and
variables that have been created will also be defined and clarified here.

### full_ds
#### subject
An ID number of the subject whose reading was taken. There were a total of 30 test subjects for these experiments.

#### activity
One of six activities that the subject was doing when measurements were taken. This column can take these values:
1. LAYING
2. SITTING
3. STANDING
4. WALKING
5. WALKING_DOWNSTAIRS
6. WALKING_UPSTAIRS

#### Dynamical readings.
For the remaining columns, various dynamics of the subjects movement were recorded which are described in the
experimenters' original notes.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

The set of variables that were estimated from these signals are: 

```
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.
```

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

```
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```

### mean_ds

The definitions for this dataset is identical to `full_ds`, however this dataset has been grouped by `subject` and `acitivty` so that a mean of all the readings is obtained. 

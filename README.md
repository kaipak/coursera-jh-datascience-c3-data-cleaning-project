# coursera-jh-datascience-c3-data-cleaning-project
This script tidies and cleans a very fragmented and splintered dataset into something that is more sane and usable 
by analytics tools. The data has been recorded in whitespace separated text files where headers and descriptions 
of the results are also separated. The bulk of the script therefore deals with recombining the data into tabular 
form with the correct headers applied to each observation.

`full_ds` is essentially the entire `test` and `train` data set combined into a singular tabular set. Whereas, `mean_ds` groups the data by `activity` and `subject` then computes a mean for each observation. 

The R script `run_analysis.R` completes the tidying of the datasets. For a future version, it would be much cleaner to turn the tidying into a function, but since there are only two datasets in this exercise, the slight redundancy got a pass.



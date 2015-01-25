---
title: "CodeBook.md"
author: "Ron Groth"
date: "January 24, 2015"
output: html_document
---
### Understanding the UCI HAR Data Set

The authors of the data have provided a brief web site that provides access to the raw data set and a high level overview of the data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

More detailes can be found in the data set's README.txt and the feature files it references.

./UCI HAR Dataset

* **activity_labels.txt** - the names of the activities performed by the subjects correlated to the values used with the data.
* **features_info.txt** - overview of the features in the data set
* **features.txt** - all of the detailed feature names
* **test and train directories**
    + **subject_test.txt and subject_train.txt** - the subject identifiers correlated to each data row
    + **X_test.txt and X_train.txt** - summarizations of the data in the Internal Signals directories
    + **y_test.txt and y_train.txt** - the activity performed for each row of measurements
    + **Intertial Signals directories** - the raw measurements before being summarized in the X data files

### Structure of run_analysis.R Script

The run_analysis.R script contains the following functions:

**checkForRawDataFile(rawDataZipFile)** - makes sure the raw data file is in the current working directory

**checkCorrectLocation(dirName)** - makes sure the expected data directory exists

**readData(dirName, dataType)** - works for both train and test data. Performs all reading and combining data to create separate train and test data frames

**mergeAndSort(df1, df2)** - used to combine the two data frames and sort them by subject and activity

**selectColumnsByMatch** - creates a new data frame based on the regex matches of provided list of patterns

**transformToDescriptive(names) - takes a vector of names and puts them into appropriate descriptive variable form

**run_analysis()** - the main function which drives the overall transformation of the data

The script calls run_analysis() so that it will be run upon sourcing.

### Data Cleaning Process

Steps taken by **run_analysis.R** script:

* unzip the zip file containing the raw data
* check that the **UCI HAR Dataset** directory exists
* read the test and train data and create data frames using a method parameterized with "train" and "test"
    + read the feature names from the features.txt file and create a vector containing them
    + read the subjects and place in a data frame
    + read the actvities and place in a data frame
    + read the activity labels
    + use activities as factors and create a vector of activities with the labels
    + read the summarized form of the activity measurements
    + create a data frame with the subject, activity and measurements
    + add names to data frame: subject, activity and the features
* combine the test and train data frames into one with rbind
* sort the rows of data based on subject and activity
* select columns we want in the data frame: subject, activity, mean, std
* transform the feature names into descriptive variable names
    + remove punctuation such as: (),-
    + change leading t and f to time and frequency
    + substitute full words for abbreviations
    + use camel casing to provide word distinction
    + remove errant extra Body instances
* create average of each variable for each activity and each subject using ddply() and numcolwise()
* write the tidy data set to a file called **summary.txt**

### Feature Descriptions

subject - the identifier for the participants: 1-30                                                
activity - the names of the activities

The following features are all averages of the variable values for each subject and the particular activity they were performing. For more detailed understanding of the features, please see the **feature_info.txt** file in the **UCI HAR Dataset** directory.

timeBodyAccelerationMeanX                               
timeBodyAccelerationMeanY                              
timeBodyAccelerationMeanZ                              
timeBodyAccelerationStandardDeviationX                 
timeBodyAccelerationStandardDeviationY                 
timeBodyAccelerationStandardDeviationZ                 
timeGravityAccelerationMeanX                           
timeGravityAccelerationMeanY                           
timeGravityAccelerationMeanZ                           
timeGravityAccelerationStandardDeviationX              
timeGravityAccelerationStandardDeviationY              
timeGravityAccelerationStandardDeviationZ              
timeBodyAccelerationJerkMeanX                          
timeBodyAccelerationJerkMeanY                          
timeBodyAccelerationJerkMeanZ                          
timeBodyAccelerationJerkStandardDeviationX             
timeBodyAccelerationJerkStandardDeviationY             
timeBodyAccelerationJerkStandardDeviationZ             
timeBodyGyroscopeMeanX                                 
timeBodyGyroscopeMeanY                                 
timeBodyGyroscopeMeanZ                                 
timeBodyGyroscopeStandardDeviationX                    
timeBodyGyroscopeStandardDeviationY                    
timeBodyGyroscopeStandardDeviationZ                    
timeBodyGyroscopeJerkMeanX                             
timeBodyGyroscopeJerkMeanY                             
timeBodyGyroscopeJerkMeanZ                             
timeBodyGyroscopeJerkStandardDeviationX                
timeBodyGyroscopeJerkStandardDeviationY                
timeBodyGyroscopeJerkStandardDeviationZ                
timeBodyAccelerationMagnitudeMean                      
timeBodyAccelerationMagnitudeStandardDeviation         
timeGravityAccelerationMagnitudeMean                   
timeGravityAccelerationMagnitudeStandardDeviation      
timeBodyAccelerationJerkMagnitudeMean                  
timeBodyAccelerationJerkMagnitudeStandardDeviation     
timeBodyGyroscopeMagnitudeMean                         
timeBodyGyroscopeMagnitudeStandardDeviation            
timeBodyGyroscopeJerkMagnitudeMean                     
timeBodyGyroscopeJerkMagnitudeStandardDeviation        
frequencyBodyAccelerationMeanX                         
frequencyBodyAccelerationMeanY                         
frequencyBodyAccelerationMeanZ                         
frequencyBodyAccelerationStandardDeviationX            
frequencyBodyAccelerationStandardDeviationY            
frequencyBodyAccelerationStandardDeviationZ            
frequencyBodyAccelerationMeanFrequencyX                
frequencyBodyAccelerationMeanFrequencyY                
frequencyBodyAccelerationMeanFrequency"                
frequencyBodyAccelerationJerkMeanX                     
frequencyBodyAccelerationJerkMeanY                     
frequencyBodyAccelerationJerkMeanZ                     
frequencyBodyAccelerationJerkStandardDeviationX        
frequencyBodyAccelerationJerkStandardDeviationY        
frequencyBodyAccelerationJerkStandardDeviationZ        
frequencyBodyAccelerationJerkMeanFrequencyX            
frequencyBodyAccelerationJerkMeanFrequencyY            
frequencyBodyAccelerationJerkMeanFrequencyZ            
frequencyBodyGyroscopeMeanX                            
frequencyBodyGyroscopeMeanY                            
frequencyBodyGyroscopeMeanZ                            
frequencyBodyGyroscopeStandardDeviationX               
frequencyBodyGyroscopeStandardDeviationY               
frequencyBodyGyroscopeStandardDeviationZ               
frequencyBodyGyroscopeMeanFrequencyX                   
frequencyBodyGyroscopeMeanFrequencyY                   
frequencyBodyGyroscopeMeanFrequencyZ                   
frequencyBodyAccelerationMagnitudeMean                 
frequencyBodyAccelerationMagnitudeStandardDeviation    
frequencyBodyAccelerationMagnitudeMeanFrequency        
frequencyBodyAccelerationJerkMagnitudeMean             
frequencyBodyAccelerationJerkMagnitudeStandardDeviation     
frequencyBodyAccelerationJerkMagnitudeMeanFrequency    
frequencyBodyGyroscopeMagnitudeMean                    
frequencyBodyGyroscopeMagnitudeStandardDeviation       
frequencyBodyGyroscopeMagnitudeMeanFrequency           
frequencyBodyGyroscopeJerkMagnitudeMean                
frequencyBodyGyroscopeJerkMagnitudeStandardDeviation   
frequencyBodyGyroscopeJerkMagnitudeMeanFrequency


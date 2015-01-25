# run_analysis.R

library(plyr)

## make sure the raw data file is in the current working directory
checkForRawDataFile <- function(filename) {
    if(!file.exists(filename)) {
        msg <- paste("please run script in directory containing the raw data file:", filename)
        stop(msg)
    }
}

## make sure we are we we need to be
checkCorrectLocation <- function(dirName) {
    # Make sure the "UCS HAR Dataset" directory is in the current dir
    if(!file.exists(dirName)) {
        stop("please set working directory to that containing 'UCI HAR Dataset'")
    }
    
    # show that we are where we want to be
    print(sprintf("The current directory contains: %s", dirName))
    print("Great, we seem to be in the right place.")
}

readData <- function(dirName, dataType) {
    
    # get the features headers
    featuresTable <- read.table(paste("./", dirName, "/", "features.txt", sep=""), sep=" ")
    headers <- featuresTable$V2
    
    # get the subject to data row relationships
    subject <- read.table(paste("./", dirName, "/", dataType, "/", "subject_", dataType, ".txt", sep=""))
    
    # get the activities
    activity <- read.table(paste("./", dirName, "/", dataType, "/", "y_", dataType, ".txt", sep=""))
    
    # read the activity labels
    activityLabels <- read.table(paste("./", dirName, "/", "activity_labels.txt", sep=""))
    
    # exchange the activity values for activity labels
    af <- as.factor(activity[,1])
    activity <- activityLabels$V2[af]
    
    # get the measurements
    measurements <- read.table(paste("./", dirName, "/", dataType, "/", "X_", dataType, ".txt", sep=""))
    
    # construct the data frame
    df <- data.frame(subject, activity, measurements)
    
    
    # put the headers on the data frame
    names(df) <- c("subject", "activity", as.character(headers))
    
    return(df)
}

mergeAndSort <- function(df1, df2) {
    combinedDF <- rbind(df1, df2)
    sortedDF <-combinedDF[with(combinedDF, order(subject, activity)), ]
    
    return(sortedDF)
}

selectColumnsByMatch <- function(df, toMatch) {
    
    df[unique(grep(paste(toMatch, collapse="|"), colnames(df), value=TRUE))]
}

transformToDescriptive <- function(names) {
    # remove punctuation
    names <- gsub("(", "", names, fixed=T)
    names <- gsub(")", "", names, fixed=T)
    names <- gsub("-", "", names, fixed=T)
    names <- gsub(",", "", names, fixed=T)
    
    # change leading t to time
    names <- sub("^t", "time", names)
    
    # change leading f to frequency
    names <- sub("^f", "frequency", names)
    
    # change Acc to Acceleration
    names <- sub("Acc", "Acceleration", names)
    
    # change Gyro to Gyroscope
    names <- sub("Gyro", "Gyroscope", names)
    
    # change Mag to Magnitude
    names <- sub("Mag", "Magnitude", names)
    
    # change mean to Mean
    names <- sub("mean", "Mean", names)
    
    # change std to Standard Deviation
    names <- sub("std", "StandardDeviation", names)
    
    # change Freq to Frequency
    names <- sub("Freq", "Frequency", names)
    
    # change gravity to Gravity
    names <- sub("gravity", "Gravity", names)
    
    # change anglet to angleTime
    names <- sub("anglet", "angleTime", names)
    
    # change BodyBody to Body
    names <- sub("BodyBody", "Body", names)
    return(names)
}

## "main" method
run_analysis <- function() {
    rawDataZipFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
    dataDir <- "UCI HAR Dataset"
    
    print("checking for raw data zip file")
    checkForRawDataFile(rawDataZipFile)

    print("unzip the raw data zip file")
    unzip(rawDataZipFile)
    
    print("checking for expected data directory")
    checkCorrectLocation(dataDir)
    
    print("reading and collating training data")
    trainDF <- readData(dataDir, "train")
    
    print("reading and collating test data")
    testDF <- readData(dataDir, "test")
    
    print("merging and sorting training and test data")
    allDF <- mergeAndSort(trainDF, testDF)
    
    print("selecting the mean and standard deviation columns")
    msDF <- selectColumnsByMatch(allDF, c("subject", "activity", "mean", "std"))
    
    print("transforming to descriptive variable names")
    names(msDF) <- transformToDescriptive(colnames(msDF))
    
    print("computing mean for subjects and their activity")
    summaryDF <- ddply(msDF, .(subject, activity), numcolwise(mean))
    
    print("writing summary.txt")
    write.table(summaryDF, file = "summary.txt", row.name=FALSE)
}

# cause script to run on source()
run_analysis()


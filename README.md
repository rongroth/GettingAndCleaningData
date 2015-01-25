---
title: "README.md"
author: "Ron Groth"
date: "January 24, 2015"
output: html_document
---

#### Raw Data
The raw data is in the file **getdata-projectfiles-UCI HAR Dataset.zip**.

#### Cleaning Script

```
source("./run_analysis.R")
```

**run_analysis.R** will:

- check for the existence of the raw data file
- unzip the file
- make sure the data directory it expects is there
- transform the data (details in CodeBook.md)
- write **tidy data set** to the file **summary.txt**

#### Code Book

The file **CodeBook.md** describes how the tidy data set is created and its features.

#### Tidy Data Set

Will be created by running the script. It will be written to **summary.txt**.

#### GitHub Repository Location

https://github.com/rongroth/GettingAndCleaningData


# Readme - Cleaning Dataset

## Goal
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 


## Basic assumption
The R code in run_analysis.R proceeds under the assumption that the zip file available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip is downloaded and extracted in the R Home Directory.

## Running the script
In order to run the script, Simply source the "run_analysis.R" script with the "UCI HAR Dataset" folder in the same parent folder.

## Script operation

* Step 0 - Preparing Script
    1. Sub-step 1 - Installing the libraries used for the script operation
    2. Sub-step 2 - Retriving labels for Activities and Features
    3. Sub-step 3 - Getting Test data from files
    4. Sub-step 4 - Getting Training data from files


* Step 1 - Merging
    1. Sub-step 1 - Merging training and testing data
    2. Sub-step 2 - Renaming Activity & Subject dataframes columns
    3. Sub-step 3 - Renaming Features dataframe columns with data from the list of feature names
    4. Sub-step 4 - Combining test and training rows into complete dataframe


* Step 2 - Extracting Mean & SD
    1. Sub-step 1 - Using Regexp to extract id of cols with Mean & SD
    2. Sub-step 2 - Making a list of columns to keep
    3. Sub-step 3 - Extracting columns we need from the complete data set


* Step 3 - Using descriptive activity names to name the activities
    1. Sub-step 1 - Converting Activity from numeric to characters in order to apply functions
    2. Sub-step 2 - Replacing Activity number by activity Name from List Activities
    3. Sub-step 3 - Using Activity as a Factor for further treatment


* Step 4 - Renaming columns with comprehensive names
    1. Sub-step 1 - Using Regexp to rename columns based on the abreviated names in original dataset


* Step 5 - Creating independant dataframe for data outputing
    1. Sub-step 1 - Converting Subjects as factor for later grouping
    2. Sub-step 2 - Creating the data table from the data frame 
    3. Sub-step 3 - Aggregating rows by Subject and Activity and using mean calculation
    4. Sub-step 4 - Re-ordering columns to place Activities and Subjects at the beginning of the data table
    5. Sub-step 5 - Writing the cleanned data table to a file

# GettingAndCleaningData

This is the project for the course Getting and Cleaning Data.  The script in R is located in the run_analysis.R as instructed and performs the following activities:

1. It checks if there is a file to download the data and creates one if there isn't a directory where to save the file.

2. It downloads the zip file from a website and turns the list of files and turns them into a variable.

3. Then the code reads the data and creates variables where the messy data is located.  There are three sets of data: activity data, test data and feature data.

4. Using rbind, it combines train and test data and adds names to the variables created.

5. Then the data is merged into a whole new dat set

6. Then mean and standard deviation is calculated from the data and then labels are created.

7. The variables are given names that could be better interpreted.

8. The data set is created as well as a data output.  The data set is in the tidydata file.

9. An html file is created using the kniter package.


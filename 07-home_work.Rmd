---
layout: page
title: R Fundamentals I
subtitle: Homework
---


Let's practice what you learned in this class. You will read data, transform columns, subset dataset, plot and extract information.

Write a script that reads the datasets "indicators2050.csv" and "cities.csv", and joins them on the column `city_id`. This dataset contain 2050 target values for population, households and employment. Using the R functionality you learned, can you answer the  following **questions**:

1. How many cities are in the dataset? 
2. Check if there are any cities with zero population and if yes, exclude them from further analysis.
3. What is the projected mean households size in the region?
4. Can you create a histogram of household size with a blue vertical line showing the 2050 median household size, and a black vertical line showing the current median household size which is 2.71? Can you figure how to limit the range of the x-axis to (1,4)?
5. Which cities have projected employment per capita larger than 50?
6. Consider cities with population between 1000 and 50000. Is there a clear outlier in the relationship between households and employment in those cities? Do majority of cities of this size have more jobs than households?


**Steps** to get there:

1. For reading and merging datasets, see Part 3 of this class. Since these are both csv files, using `read.csv` is simpler than `read.table`.
2. Using the `subset` function remove rows with zero population. You should now have 160 records. Check with the `dim` or `nrow` function.
3. Compute a new column of household size, using the households and population columns.
4. Use the `summary` function to view summary statistics, such as the mean and median.
5. For creating a histogram, see Part 6 of this class. For setting the range of the x-axis, use `?hist` to see additional arguments. Note that `col` for defining colors is a graphical parameter, for which the help file can be viewed by `?par`. For example, making the vertical line dashed, pass `lty=2` to the `abline` command.
6. Compute a new column of employment per capita.
7. Use the `subset` function to answer question 5.
8. For question 6, create a subset of the dataset corresponding to the given population (should have 92 records). Create a scatter plot of households and employment for this subsets, as well as a `x=y` line. To what city does the biggest outlier belong to? Answer the last question by a visual assessment of the scatter plot.



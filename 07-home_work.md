---
layout: page
title: R Fundamentals I
subtitle: Homework
---



Let's practice what you learned in this class. You will subset vectors and matrices, read data, transform columns, subset dataset, plot and extract information. Be ready to self-study material that we did not get to cover in the class.

## Part I

>
> ## Challenge 1 {.challenge}
>
> Make a matrix containing the numbers 1:50,
> with 5 columns and 10 rows.
> Did the `matrix` function fill your matrix by column, or by
> row, as its default behaviour?
> See if you can figure out how to change this.
> (hint: read the documentation for `matrix`!)
>

> ## Challenge 2 {.challenge}
>
> Please study the various ways of subsetting vectors in [Chapter 4 of this class](04-data-subsetting.html), 
> especially subsetting by logical operations. Then,
> given the following code:
>
> 
> ~~~{.r}
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> 
> 
> 
> ~~~{.output}
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> 
> ~~~
>
> Write a subsetting command to return the values in x that are greater than 4 and less than 7.
>

> ## Challenge 3 {.challenge}
>
> Please study the section on subsetting matrices in [Chapter 4](04-data-subsetting.html). 
>
> Given the following code:
>
> 
> ~~~{.r}
> m <- matrix(1:18, nrow = 3, ncol = 6)
> print(m)
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4] [,5] [,6]
> [1,]    1    4    7   10   13   16
> [2,]    2    5    8   11   14   17
> [3,]    3    6    9   12   15   18
> 
> ~~~
>
> 1. Which of the following commands will extract the values 11 and 14?
>
> A. `m[2,4,2,5]`
>
> B. `m[2:5]`
>
> C. `m[4:5,2]`
>
> D. `m[2,c(4,5)]`
>

> ## Challenge 4 {.challenge}
> Given the following list (where `hh` is the households data frame created in the class): 
>
> 
> ~~~{.r}
> xlist <- list(a = "PSRC", b = 1:10, data = head(hh))
> ~~~
>
> Using your knowledge of both list and vector subsetting, extract the number 2 from xlist. 
> Hint: the number 2 is contained within the "b" item in the list.

> ## Challenge 5 {.challenge}
>
> Vectorisation is one of the most important principles of R, see [Chapter 5](05-vectorisation.html) for details.
> We're interested in looking at the sum of the
> following sequence of fractions:
>
> 
> ~~~{.r}
>  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> ~~~
>
> This would be tedious to type out, and impossible for high values of
> n.  Use vectorisation to compute x when n=100. What is the sum when
> n=10,000?

> ## Challenge 6 {.challenge}
>
> Given a random matrix 
> 
> ~~~{.r}
> set.seed(123)
> rmat <- matrix(rnorm(30), nrow = 3, ncol = 10)
> ~~~
> find two ways to compute averages across the three rows in one line of code. 
>
> Now, instead of averages, compute the medians.  
> 


## Part II

Write a script that reads the datasets "indicators2050.csv" and "cities.csv", and joins them on the column `city_id`. This dataset contain 2050 target values for population, households and employment. Using the R functionality you learned, can you answer the  following **questions**:

1. How many cities are in the dataset? 
2. Check if there are any cities with zero population and if yes, exclude them from further analysis.
3. What is the projected mean households size in the region?
4. Can you create a histogram of household size with a blue vertical line showing the 2050 median household size, and a black vertical line showing the current median household size which is 2.71? Can you figure how to limit the range of the x-axis to (1,4)?
5. Which cities have projected employment per capita larger than 50?
6. Consider cities with population between 1000 and 50000. Is there a clear outlier in the relationship between households and employment in those cities? Do majority of cities of this size have more jobs than households?


**Steps** to get there:

1. For reading and merging datasets, see [Chapter 3](03-data-structures-part2.html) of this class. Since these are both csv files, using `read.csv` is simpler than `read.table`.
2. Study the use of the `subset` function in [Chapter 4](04-data-subsetting.html), section Subsetting data frames. Using the `subset` function remove rows with zero population. You should now have 160 records. Check with the `dim` or `nrow` function.
3. Compute a new column of household size, using the households and population columns.
4. Use the `summary` function to view summary statistics, such as the mean and median.
5. For creating a histogram, see [Chapter 6](06-data-manip.html) of this class. For setting the range of the x-axis, use `?hist` to see additional arguments. Note that `col` for defining colors is a graphical parameter, for which the help file can be viewed by `?par`. For example, making the vertical line dashed, pass `lty=2` to the `abline` command.
6. Compute a new column of employment per capita.
7. Use the `subset` function to answer question 5.
8. For question 6, create a subset of the dataset corresponding to the given population (should have 92 records). Create a scatter plot of households and employment for this subsets, as well as a `x=y` line. To what city does the biggest outlier belong to? Answer the last question by a visual assessment of the scatter plot.

![](img/4mnlal.jpg)


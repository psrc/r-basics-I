---
layout: page
title: R Fundamentals I
subtitle: Vectorisation
---



> ## Learning Objectives {.objectives}
>
> * To understand vectorised operations in R.
> * To understand the `apply` function.
>

Most of R's functions are vectorised, meaning that the function will
operate on all elements of a vector without needing to loop through
and act on each element one at a time. This makes writing code more
concise, easy to read, and less error prone.



~~~{.r}
x <- 1:4
x * 2
~~~



~~~{.output}
[1] 2 4 6 8

~~~

The multiplication happened to each element of the vector.

We can also add two vectors together:


~~~{.r}
y <- 6:9
x + y
~~~



~~~{.output}
[1]  7  9 11 13

~~~

Each element of `x` was added to its corresponding element of `y`:


~~~{.r}
x:  1  2  3  4
    +  +  +  +
y:  6  7  8  9
---------------
    7  9 11 13
~~~


Vectorised operations work element-wise on matrices:


~~~{.r}
m <- matrix(1:12, nrow = 3, ncol = 4)
m * -1  
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]   -1   -4   -7  -10
[2,]   -2   -5   -8  -11
[3,]   -3   -6   -9  -12

~~~
 

> ## Tip: element-wise vs. matrix multiplication {.callout}
>
> Very important: the operator `*` gives you element-wise multiplication!
> To do matrix multiplication, we need to use the `%*%` operator:
> 
> 
> ~~~{.r}
> m %*% matrix(1, nrow = 4, ncol = 1)
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1]
> [1,]   22
> [2,]   26
> [3,]   30
> 
> ~~~
> 
> 
> 
> ~~~{.r}
> matrix(1:4, nrow = 1) %*% matrix(1:4, ncol = 1)
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1]
> [1,]   30
> 
> ~~~
>
> For more on matrix algebra, see the [Quick-R reference
> guide](http://www.statmethods.net/advstats/matrix.html)

To combine a matrix with a vector, keep in mind that the element-wise combination happens by columns:

~~~{.r}
m
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]    1    4    7   10
[2,]    2    5    8   11
[3,]    3    6    9   12

~~~



~~~{.r}
x
~~~



~~~{.output}
[1] 1 2 3 4

~~~



~~~{.r}
m * x
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]    1   16   21   20
[2,]    4    5   32   33
[3,]    9   12    9   48

~~~
To do it by rows, first create a matrix from the vector and then combine the two matrices:

~~~{.r}
xm <- matrix(rep(x, 3), nrow = 3, byrow = TRUE)
xm
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    1    2    3    4
[3,]    1    2    3    4

~~~



~~~{.r}
m * xm
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]    1    8   21   40
[2,]    2   10   24   44
[3,]    3   12   27   48

~~~


> ## Challenge 1 {.challenge}
>
> Given the following matrix:
>
> 
> ~~~{.r}
> m <- matrix(1:12, nrow = 3, ncol = 4)
> m
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> 
> ~~~
>
> Write down what you think will happen when you run:
>
> 1. `m ^ -1`
> 2. `m * c(1, 0, -1)`
> 3. `m > c(0, 20)`
> 4. `m * c(1, 0, -1, 2)`
>
> Did you get the output you expected? If not, ask a helper!
>



## Applying functions across rows/columns

What if we need an operation (average, sum etc.)  across rows or across columns? 

<img src="fig/r-operations-across-axes.svg" alt="Operations Across Axes" />

To support this, we can use the `apply` function.

> ## Tip {.callout}
>
> To learn about a function in R, e.g. `apply`, we can read its help
> documention by running `help(apply)` or `?apply`.

`apply` allows us to repeat a function on all of the rows (`MARGIN = 1`) or columns (`MARGIN = 2`) of a data frame. For example, using the `m` matrix, instead of

~~~{.r}
mean(m[1,])
~~~



~~~{.output}
[1] 5.5

~~~



~~~{.r}
mean(m[2,])
~~~



~~~{.output}
[1] 6.5

~~~



~~~{.r}
mean(m[3,])
~~~



~~~{.output}
[1] 7.5

~~~
we do

~~~{.r}
apply(m, 1, mean) # average across rows
~~~



~~~{.output}
[1] 5.5 6.5 7.5

~~~
Also, we can do

~~~{.r}
apply(m, 2, min) # minimum across columns
~~~



~~~{.output}
[1]  1  4  7 10

~~~



~~~{.r}
apply(m, 2, sum) # sum across columns
~~~



~~~{.output}
[1]  6 15 24 33

~~~

> ## Tip: shortcuts for sums and means in matrices {.callout}
>
> Another way to compute row and column sums/means for matrices is
>
> 
> ~~~{.r}
> rowSums(m)  # equivalent to apply(m, 1, sum)
> colSums(m)  # equivalent to apply(m, 2, sum)
> rowMeans(m) # equivalent to apply(m, 1, mean)
> colMeans(m) # equivalent to apply(m, 2, mean)
> ~~~
> However, these shortcuts are not available for other functions like `median`, `min` or `max`. In such cases, the 
> `apply` function has to be used.
>
> The following should hold:
> 
> ~~~{.r}
> all(colSums(m) == apply(m, 2, sum) )
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] TRUE
> 
> ~~~


Similarly, with our `pierce` subset dataset created in the previous session, we can get household totals:

~~~{.r}
apply(pierce[,2:6], 2, sum)
~~~



~~~{.output}
hh2016 hh2020 hh2030 hh2040 hh2050 
320054 335245 386446 438732 488373 

~~~
and the all-cities `hh` dataset:

~~~{.r}
apply(hh[,2:6], 2, sum)
~~~



~~~{.output}
 hh2016  hh2020  hh2030  hh2040  hh2050 
1581863 1657497 1912422 2172765 2419919 

~~~

However, for a dataset with missing values:

~~~{.r}
df <- data.frame(id = letters[1:5], X = c(NA, rep(100, 4)), Y = c(rep(5, 3), NA, NA))
df
~~~



~~~{.output}
  id   X  Y
1  a  NA  5
2  b 100  5
3  c 100  5
4  d 100 NA
5  e 100 NA

~~~

we get:

~~~{.r}
apply(df[,2:3], 2, sum)
~~~



~~~{.output}
 X  Y 
NA NA 

~~~

because

~~~{.r}
sum(c(3, NA))
~~~



~~~{.output}
[1] NA

~~~


but

~~~{.r}
sum(c(3, NA), na.rm=TRUE)
~~~



~~~{.output}
[1] 3

~~~

Therefore

~~~{.r}
apply(df[,2:3], 2, sum, na.rm=TRUE)
~~~



~~~{.output}
  X   Y 
400  15 

~~~


## Challenge solutions

> ## Solution to challenge 1 {.challenge}
>
> Given the following matrix:
>
> 
> ~~~{.r}
> m <- matrix(1:12, nrow = 3, ncol = 4)
> m
> ~~~
> 
> 
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> 
> ~~~
>
>
> Write down what you think will happen when you run:
>
> 1. `m ^ -1`
>
> 
> ~~~{.output}
>           [,1]      [,2]      [,3]       [,4]
> [1,] 1.0000000 0.2500000 0.1428571 0.10000000
> [2,] 0.5000000 0.2000000 0.1250000 0.09090909
> [3,] 0.3333333 0.1666667 0.1111111 0.08333333
> 
> ~~~
>
> 2. `m * c(1, 0, -1)`
>
> 
> ~~~{.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    0    0    0    0
> [3,]   -3   -6   -9  -12
> 
> ~~~
>
> 3. `m > c(0, 20)`
>
> 
> ~~~{.output}
>       [,1]  [,2]  [,3]  [,4]
> [1,]  TRUE FALSE  TRUE FALSE
> [2,] FALSE  TRUE FALSE  TRUE
> [3,]  TRUE FALSE  TRUE FALSE
> 
> ~~~
>



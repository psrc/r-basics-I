---
layout: page
title: R Fundamentals I
subtitle: Subsetting data
---



> ## Learning Objectives {.objectives}
>
> * To be able to subset vectors, factors, matrices, lists, and data frames
> * To be able to extract individual and multiple elements:
>     * by index,
>     * by name,
>     * using comparison operations
> * To be able to skip and remove elements from various data structures.
>

R has many powerful subset operators and mastering them will allow you to
easily perform complex operations on any kind of dataset.

There are six different ways we can subset any kind of object, and three
different subsetting operators for the different data structures.

Let's start with the workhorse of R: atomic vectors.


~~~{.r}
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- letters[1:5]
x
~~~



~~~{.output}
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 

~~~

So now that we've created a dummy vector to play with, how do we get at its
contents?

## Accessing elements using their indices

To extract elements of a vector we can give their corresponding index, starting
from one:


~~~{.r}
x[1]
~~~



~~~{.output}
  a 
5.4 

~~~


~~~{.r}
x[4]
~~~



~~~{.output}
  d 
4.8 

~~~

The square brackets operator is just like any other function. For atomic vectors
(and matrices), it means "get me the nth element".

We can ask for multiple elements at once:


~~~{.r}
x[c(1, 3)]
~~~



~~~{.output}
  a   c 
5.4 7.1 

~~~

Or slices of the vector:


~~~{.r}
x[1:4]
~~~



~~~{.output}
  a   b   c   d 
5.4 6.2 7.1 4.8 

~~~

the `:` operator just creates a sequence of numbers from the left element to the right.
I.e. `x[1:4]` is equivalent to `x[c(1,2,3,4)]`.

We can ask for the same element multiple times:


~~~{.r}
x[c(1,1,3)]
~~~



~~~{.output}
  a   a   c 
5.4 5.4 7.1 

~~~

If we ask for a number outside of the vector, R will return missing values:


~~~{.r}
x[6]
~~~



~~~{.output}
<NA> 
  NA 

~~~

This is a vector of length one containing an `NA`, whose name is also `NA`.

If we ask for the 0th element, we get an empty vector:


~~~{.r}
x[0]
~~~



~~~{.output}
named numeric(0)

~~~

> ## Vector numbering in R starts at 1 {.callout} 
> 
> In many programming languages (C and python, for example), the first
> element of a vector has an index of 0. In R, the first element is 1.

## Skipping and removing elements

If we use a negative number as the index of a vector, R will return
every element *except* for the one specified:


~~~{.r}
x[-2]
~~~



~~~{.output}
  a   c   d   e 
5.4 7.1 4.8 7.5 

~~~


We can skip multiple elements:


~~~{.r}
x[c(-1, -5)]  # or x[-c(1,5)]
~~~



~~~{.output}
  b   c   d 
6.2 7.1 4.8 

~~~

> ## Tip: Order of operations {.callout}
>
> A common trip up for novices occurs when trying to skip
> slices of a vector. Most people first try to negate a
> sequence like so:
>
> 
> ~~~{.r}
> x[-1:3]
> ~~~
> 
> 
> 
> ~~~{.error}
> Error in x[-1:3]: only 0's may be mixed with negative subscripts
> 
> ~~~
>
> This gives a somewhat cryptic error.
>
> But remember the order of operations. `:` is really a function, so
> what happens is it takes its first argument as -1, and second as 3,
> so generates the sequence of numbers: `c(-1, 0, 1, 2, 3)`.
>
> The correct solution is to wrap that function call in brackets, so
> that the `-` operator applies to the results:
>
> 
> ~~~{.r}
> x[-(1:3)]
> ~~~
> 
> 
> 
> ~~~{.output}
>   d   e 
> 4.8 7.5 
> 
> ~~~
>

To remove elements from a vector, we need to assign the results back
into the variable:


~~~{.r}
x <- x[-4]
x
~~~



~~~{.output}
  a   b   c   e 
5.4 6.2 7.1 7.5 

~~~

> ## Challenge 1 {.challenge}
>
> Given the following code:
>
> 
> ~~~{.r}
> y <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(y) <- c('a', 'b', 'c', 'd', 'e')
> print(y)
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
> Come up with at least 3 different commands that will produce the following output:
>
> 
> ~~~{.output}
>   b   c   d 
> 6.2 7.1 4.8 
> 
> ~~~
>

## Subsetting through logical operations

We can subset through logical operations:


~~~{.r}
x[c(TRUE, TRUE, FALSE, FALSE)]
~~~



~~~{.output}
  a   b 
5.4 6.2 

~~~


Since comparison operators evaluate to logical vectors, we can also
use them to succinctly subset vectors:


~~~{.r}
x[x > 7]
~~~



~~~{.output}
  c   e 
7.1 7.5 

~~~

> ## Tip: Chaining logical operations {.callout}
>
> There are many situations in which you will wish to combine multiple conditions.
> To do so several logical operations exist in R:
>
>  * `|` logical OR (elementwise comparison): returns `TRUE`, if either the left or right are `TRUE`.
>  * `&` logical AND (elementwise comparison): returns `TRUE` if both the left and right are `TRUE`
>  * `!` logical NOT: converts `TRUE` to `FALSE` and `FALSE` to `TRUE`
>  * `&&` and `||` evaluates left to right looking at the first element only. 
>

Any function that returns a logical vector can be used for subsetting:

~~~{.r}
is.na(c(x, NA))
~~~



~~~{.output}
    a     b     c     e       
FALSE FALSE FALSE FALSE  TRUE 

~~~
Similarly other functions for identifying special values, e.g.`is.nan` (`Nan` values), `is.infinite` (`Inf` values), `is.finite` (values that are not `NA`, `NaN`, `Inf`).




## Subsetting by name

We can extract elements by using their name, instead of index:


~~~{.r}
x[c("a", "c")]
~~~



~~~{.output}
  a   c 
5.4 7.1 

~~~

This is usually a much more reliable way to subset objects: the
position of various elements can often change when chaining together
subsetting operations, but the names will always remain the same!

Unfortunately we can't skip or remove elements so easily.

To skip (or remove) a single named element we have to find the index of the corresponding column, say "a":

~~~{.r}
names(x) == "a"
~~~



~~~{.output}
[1]  TRUE FALSE FALSE FALSE

~~~
The condition operator is applied to every name of the vector `x`. Only the
first name is "a" so that element is TRUE.

`which` then converts this to an index:


~~~{.r}
which(names(x) == "a")
~~~



~~~{.output}
[1] 1

~~~

Only the first element is `TRUE`, so `which` returns 1. Now that we have indices
the skipping works because we have a negative index!


~~~{.r}
x[-which(names(x) == "a")]
~~~



~~~{.output}
  b   c   e 
6.2 7.1 7.5 

~~~



Skipping multiple named indices is similar, but uses a different comparison
operator:


~~~{.r}
x[-which(names(x) %in% c("a", "c"))]
~~~



~~~{.output}
  b   e 
6.2 7.5 

~~~

The `%in%` goes through each element of its left argument, in this case the
names of `x`, and asks, "Does this element occur in the second argument?".


> ## Tip: Getting help for operators {.callout}
>
> Remember you can search for help on operators by wrapping them in quotes:
> `help("%in%")` or `?"%in%"`.
>

So why can't we use `==` like before? That's an excellent question.

Let's take a look at just the comparison component:


~~~{.r}
names(x) == c('a', 'c')
~~~



~~~{.output}
[1]  TRUE FALSE FALSE FALSE

~~~

Obviously "c" is in the names of `x`, so why didn't this work? `==` works
slightly differently than `%in%`. It will compare each element of its left argument
to the corresponding element of its right argument.

Here's a mock illustration:


~~~{.r}
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c")
~~~

When one vector is shorter than the other, it gets *recycled*:


~~~{.r}
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c", "a", "c")
~~~

In this case R simply repeats `c("a", "c")` twice. If the longer
vector length isn't a multiple of the shorter vector length, then
R will also print out a warning message:


~~~{.r}
names(x) == c('a', 'c', 'e')
~~~



~~~{.error}
Warning in names(x) == c("a", "c", "e"): longer object length is not a multiple
of shorter object length

~~~



~~~{.output}
[1]  TRUE FALSE FALSE FALSE

~~~

This difference between `==` and `%in%` is important to remember,
because it can introduce hard to find and subtle bugs!


## Matrix subsetting

Matrices are also subsetted using the `[` function. In this case
it takes two arguments: the first applying to the rows, the second
to its columns:


~~~{.r}
set.seed(1)
m <- matrix(rnorm(6*4), ncol = 4, nrow = 6)
m[3:4, c(3,1)]
~~~



~~~{.output}
            [,1]       [,2]
[1,]  1.12493092 -0.8356286
[2,] -0.04493361  1.5952808

~~~

You can leave the first or second arguments blank to retrieve all the
rows or columns respectively:


~~~{.r}
m[, c(3,4)]
~~~



~~~{.output}
            [,1]        [,2]
[1,] -0.62124058  0.82122120
[2,] -2.21469989  0.59390132
[3,]  1.12493092  0.91897737
[4,] -0.04493361  0.78213630
[5,] -0.01619026  0.07456498
[6,]  0.94383621 -1.98935170

~~~

If we only access one row or column, R will automatically convert the result
to a vector:


~~~{.r}
m[3,]
~~~



~~~{.output}
[1] -0.8356286  0.5757814  1.1249309  0.9189774

~~~

If you want to keep the output as a matrix, you need to specify a *third* argument;
`drop = FALSE`:


~~~{.r}
m[3, , drop = FALSE]
~~~



~~~{.output}
           [,1]      [,2]     [,3]      [,4]
[1,] -0.8356286 0.5757814 1.124931 0.9189774

~~~

Unlike vectors, if we try to access a row or column outside of the matrix,
R will throw an error:


~~~{.r}
m[, c(3,6)]
~~~



~~~{.error}
Error in m[, c(3, 6)]: subscript out of bounds

~~~

It is useful to note that matrices
are laid out in *column-major format* by default. That is the elements of the
vector are arranged column-wise:


~~~{.r}
matrix(1:6, nrow = 2, ncol = 3)
~~~



~~~{.output}
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6

~~~

If you wish to populate the matrix by row, use `byrow = TRUE`:


~~~{.r}
matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
~~~



~~~{.output}
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6

~~~

Matrices can also be subsetted using their rownames and column names
instead of their row and column indices.

> ## Tip: Higher dimensional arrays {.callout}
>
> When dealing with multi-dimensional arrays, each argument to `[`
> corresponds to a dimension. For example, a 3D array, the first three
> arguments correspond to the rows, columns, and depth dimension.
>

~~~{.r}
a <- array(1:12, dim = c(2,3,2))
dim(a)
~~~



~~~{.output}
[1] 2 3 2

~~~



~~~{.r}
a[,,2]
~~~



~~~{.output}
     [,1] [,2] [,3]
[1,]    7    9   11
[2,]    8   10   12

~~~



## List subsetting

Now we'll introduce some new subsetting operators. There are three functions
used to subset lists. `[`, as we've seen for atomic vectors and matrices,
as well as `[[` and `$`.

Using `[` will always return a list. If you want to *subset* a list, but not
*extract* an element, then you will likely use `[`.


~~~{.r}
xlist <- list(a = "PSRC", b = 1:10, data = head(hh))
xlist[1]
~~~



~~~{.output}
$a
[1] "PSRC"

~~~

This returns a *list with one element*.

We can subset elements of a list exactly the same was as atomic
vectors using `[`. Comparison operations however won't work as
they're not recursive, they will try to condition on the data structures
in each element of the list, not the individual elements within those
data structures.


~~~{.r}
xlist[1:2]
~~~



~~~{.output}
$a
[1] "PSRC"

$b
 [1]  1  2  3  4  5  6  7  8  9 10

~~~

To extract individual elements of a list, you need to use the double-square
bracket function: `[[`.


~~~{.r}
xlist[[1]]
~~~



~~~{.output}
[1] "PSRC"

~~~

Notice that now the result is a vector, not a list.

You can't extract more than one element at once:


~~~{.r}
xlist[[1:2]]
~~~



~~~{.error}
Error in xlist[[1:2]]: subscript out of bounds

~~~

Nor use it to skip elements:


~~~{.r}
xlist[[-1]]
~~~



~~~{.error}
Error in xlist[[-1]]: invalid negative subscript in get1index <real>

~~~

But you can use names to both subset and extract elements:


~~~{.r}
xlist[["a"]]
~~~



~~~{.output}
[1] "PSRC"

~~~

The `$` function is a shorthand way for extracting elements by name:


~~~{.r}
xlist$data
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id county
1       1   2705   2735   2836   2939   3037 Normandy Park        33   King
2       2  24886  26527  32059  37708  43071        Auburn        33   King
3       3  45021  45724  48094  50515  52813    King-Rural        33   King
4       4  10135  11122  14449  17846  21072        SeaTac        33   King
5       5  22527  23240  25643  28097  30427     Shoreline        33   King
6       6  16769  17481  19881  22332  24658    Renton PAA        33   King

~~~



## Subsetting data frames

Data frames are lists underneath the hood, so similar rules
apply. However they are also two dimensional objects:

`[` with one argument will act the same was as for lists, where each list
element corresponds to a column. The resulting object will be a data frame:


~~~{.r}
head(hh[1])
~~~



~~~{.output}
  city_id
1       1
2       2
3       3
4       4
5       5
6       6

~~~

Similarly, `[[` will act to extract *a single column*:


~~~{.r}
head(hh[["city_id"]])
~~~



~~~{.output}
[1] 1 2 3 4 5 6

~~~

And `$` provides a convenient shorthand to extract columns by name:


~~~{.r}
head(hh$city_name)
~~~



~~~{.output}
[1] "Normandy Park" "Auburn"        "King-Rural"    "SeaTac"       
[5] "Shoreline"     "Renton PAA"   

~~~

With two arguments, `[` behaves the same way as for matrices:


~~~{.r}
hh[1:3,]
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id county
1       1   2705   2735   2836   2939   3037 Normandy Park        33   King
2       2  24886  26527  32059  37708  43071        Auburn        33   King
3       3  45021  45724  48094  50515  52813    King-Rural        33   King

~~~

If we subset a single row, the result will be a data frame (because
the elements are mixed types):


~~~{.r}
hh[3,]
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050  city_name county_id county
3       3  45021  45724  48094  50515  52813 King-Rural        33   King

~~~

But for a single column the result will be a vector (this can
be changed with the third argument, `drop = FALSE`).

Another way of subsetting data frames is using the `subset` command:

~~~{.r}
subset(hh, city_name == "Seattle")
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050 city_name county_id county
9       9 329066 344980 398615 453388 505387   Seattle        33   King

~~~



~~~{.r}
pierce <- subset(hh, county == "Pierce")
dim(pierce)
~~~



~~~{.output}
[1] 47  9

~~~



~~~{.r}
head(pierce)
~~~



~~~{.output}
   city_id hh2016 hh2020 hh2030 hh2040 hh2050    city_name county_id county
29      29  59710  60461  62995  65582  68039 Pierce-Rural        53 Pierce
53      53  13452  14098  16277  18503  20615           UU        53 Pierce
58      59  82851  88758 108668 129001 148304       Tacoma        53 Pierce
73      74   2736   2789   2969   3152   3326   Steilacoom        53 Pierce
74      75   3885   3918   4029   4142   4250         JBLM        53 Pierce
75      76   3530   4131   6156   8224  10188       DuPont        53 Pierce

~~~

> ## Challenge 2 {.challenge}
>
> Fix each of the following common data frame subsetting errors:
>
> 1. Extract observations for cities in county 33
>
> 
> ~~~{.r}
> hh[hh$county_id = 33,]
> ~~~
>
> 2. Extract all columns except one through five
>
> 
> ~~~{.r}
> hh[,-1:5]
> ~~~
>
> 3. Extract the rows where the number of households in 2016 is larger than 50,000
>
> 
> ~~~{.r}
> hh[hh$hh2016 > 50000]
> ~~~
>
> 4. Extract the first row, and the seventh and eighth columns
>   (`city_name` and `county_id`).
>
> 
> ~~~{.r}
> hh[1, 7, 8]
> ~~~
>
> 5. Advanced: extract rows that contain information for counties 61 and 35
>
> 
> ~~~{.r}
> hh[hh$county_id == 61 | 35,]
> ~~~
>

> ## Challenge 3 {.challenge}
>
> 1. Why does `hh[1:20]` return an error? How does it differ from `hh[1:20, ]`?
>
>
> 2. Create a new `data.frame` called `hh_small` that only contains rows 1 through 9
> and 19 through 23.
>

## Challenge solutions

> ## Solution to challenge 1 {.challenge}
>
> Given the following code:
>
> 
> ~~~{.r}
> y <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(y) <- c('a', 'b', 'c', 'd', 'e')
> print(y)
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
> Come up with at least 3 different commands that will produce the following output:
>
> 
> ~~~{.output}
>   b   c   d 
> 6.2 7.1 4.8 
> 
> ~~~
>
> 
> ~~~{.r}
> y[2:4] 
> y[-c(1,5)]
> y[c("b", "c", "d")]
> y[c(2,3,4)]
> ~~~
>
>


> ## Solution to challenge 2 {.challenge}
>
> Fix each of the following common data frame subsetting errors:
>
> 1. Extract observations for cities in county 33
>
> 
> ~~~{.r}
> # hh[hh$county_id = 33,]
> hh[hh$county_id == 33,]
> ~~~
>
> 2. Extract all columns except 1 through 5
>
> 
> ~~~{.r}
> # hh[,-1:5]
> hh[,-(1:5)]
> ~~~
>
> 3. Extract the rows where the number of households in 2016 is larger than 50,000
>
> 
> ~~~{.r}
> # hh[hh$hh2016 > 50000]
> hh[hh$hh2016 > 50000, ]
> ~~~
>
> 4. Extract the first row, and the seventh and eighth columns
>   (`city_name` and `county_id`).
>
> 
> ~~~{.r}
> # hh[1, 7, 8]
> hh[1, c(7, 8)]
> ~~~
>
> 5. Advanced: extract rows that contain information for counties  61 and 35
>
> 
> ~~~{.r}
> # hh[hh$county_id == 61 | 35,]
> hh[hh$county_id == 61 | hh$county_id == 35,]
> hh[hh$county_id %in% c(61, 35),]
> ~~~
>

> ## Solution to challenge 3 {.challenge}
>
> 1. Why does `hh[1:20]` return an error? How does it differ from `hh[1:20, ]`?
>
> Answer: `hh` is a data.frame so needs to be subsetted on two dimensions. `hh[1:20, ]` subsets the data to give the first 20 rows and all columns.
>
> 2. Create a new `data.frame` called `hh_small` that only contains rows 1 through 9
> and 19 through 23. 
>
> 
> ~~~{.r}
> hh_small <- hh[c(1:9, 19:23),]
> ~~~
>

---
layout: page
title: R Fundamentals I
subtitle: Reference
---

#### [Introduction to R and RStudio](01-rstudio-intro.html)

 - Use the escape key to cancel incomplete commands or running code 
   (Ctrl+C) if you're using R from the shell.
 - Basic arithmetic operations follow standard order of precedence:
   - Brackets: `(`, `)`
   - Exponents: `^` or `**`
   - Divide: `/`
   - Multiply: `*`
   - Add: `+`
   - Subtract: `-`
 - Scientific notation is available, e.g: `2e-3`
 - Anything to the right of a `#` is a comment, R will ignore this!
 - Functions are denoted by `function_name()`. Expressions inside the
   brackets are evaluated before being passed to the function, and 
   functions can be nested.
 - Mathematical functions: `exp`, `sin`, `log`, `log10`, `log2` etc.
 - Comparison operators: `<`, `<=`, `>`, `>=`, `==`, `!=`
 - Use `all.equal` to compare numbers!
 - `<-` is the assignment operator. Anything to the right is evaluate, then
   stored in a variable named to the left.
 - `ls` lists all variables and functions you've created
 - `rm` can be used to remove them
 - When assigning values to function arguments, you _must_ use `=`. 

#### [Seeking help](01-rstudio-intro.html)

 - `?` or `help()` to seek help for a function.
 - `??` to search for a function.
 - Wrap special operators in quotes when searching for help: `help("+")`.
 - [CRAN Task Views](http://cran.at.r-project.org/web/views).
 - [stackoverflow](http://stackoverflow.com/).


#### [Data structures](02-data-structures-part1.html)

**Basic data structures in R:**

 - atomic `?vector` (can only contain one type)
 - `?list` (containers for other objects)
 - `?data.frame` two dimensional objects whose columns can contain different types of data
 - `?matrix` two dimensional objects that can contain only one type of data.
 - `?factor` vectors that contain predefined categorical data.
 - `?array` multi-dimensional objects that can only contain one type of data

Remember that matrices are really atomic vectors underneath the hood, and that
data.frames are really lists underneath the hood (this explains some of the weirder
behaviour of R).

**Data types:**

 - `?numeric` real (decimal) numbers
 - `?integer` whole numbers only
 - `?character` text
 - `?complex` complex numbers
 - `?logical` TRUE or FALSE values

**Special types:**

 - `?NA` missing values
 - `?NaN` "not a number" for undefined values (e.g. `0/0`).
 - `?Inf`, `-Inf` infinity.
 - `?NULL` a data structure that doesn't exist

`NA` can occur in any atomic vector. `NaN`, and `Inf` can only 
occur in complex, integer or numeric type vectors. Atomic vectors
are the building blocks for all other data structures. A `NULL` value
will occur in place of an entire data structure (but can occur as list
elements).

**Useful functions for querying data structures:**

 - `?str` structure, prints out a summary of the whole data structure
 - `?typeof` tells you the type inside an atomic vector
 - `?class` what is the data structure?
 - `?head` print the first `n` elements (rows for two-dimensional objects)
 - `?tail` print the last `n` elements (rows for two-dimensional objects)
 - `?rownames`, `?colnames`, `?dimnames` retrieve or modify the row names
   and column names of an object.
 - `?names` retrieve or modify the names of an atomic vector or list (or
   columns of a data.frame).
 - `?length` get the number of elements in an atomic vector 
 - `?nrow`, `?ncol`, `?dim` get the dimensions of a n-dimensional object 
   (Won't work on atomic vectors or lists).

#### [Reading data](03-data-structures-part2.html)

 - `read.table` to read in data in a regular structure
   - `sep` argument to specify the separator
     - "," for comma separated
     - "\t" for tab separated
   - Other arguments:
     - `header=TRUE` if there is a header row

#### [Data subsetting](06-data-subsetting.html)

 - Elements can be accessed by: 
   - Index
   - Name
 - `:` to generate a sequence of numbers to extract slices 
 - `[` single square brackets:
   - *extract* single elements or *subset*:
        - vectors
   - *extract* single elements of a list
   - *extract* columns from a data.frame
 - `[` with two arguments to:
   - *extract* rows and/or columns of 
     - matrices
     - data.frames
 - `[[` double square brackets to subset lists
 - `$` to access columns or list elements by name
 - negative indices skip elements

#### [Vectorisation](05-vectorisation.html)

 - Most functions and operations apply to each element of a vector
 - `*` applies element-wise to matrices
 - `%*%` for true matrix multiplication
 - `any()` will return `TRUE` if any element of a vector is `TRUE`
 - `all()` will return `TRUE` if *all* elements of a vector are `TRUE`

 

---
layout: page
title: R Fundamentals I
subtitle: Data frames and reading in data
---



> ## Learning Objectives {.objectives}
>
> * Become familiar with data frames
> * Be able to read regular data into R
>

## Data frames

Data frames are similar to matrices, except each column can be a
different atomic type. A data frames is the standard structure for
storing and manipulating rectangular data sets.  Underneath the hood,
data frames are really lists, where each element is an atomic vector,
with the added restriction that they're all the same length.  As you
will see, if we pull out one column of a data frame,we will have a
vector. You will probably find that data frames are more complicated
than vectors and other data structures we have considered, but they
provide powerful capabilities.
 

Data frames can be created manually with the `data.frame` function:


~~~{.r}
df <- data.frame(id = c('a', 'b', 'c', 'd', 'e', 'f'), x = 1:6, y = 100:95)
df
~~~



~~~{.output}
  id x   y
1  a 1 100
2  b 2  99
3  c 3  98
4  d 4  97
5  e 5  96
6  f 6  95

~~~

As with matrices, you can use the functions `dim`, `nrow` and `ncol` to view the dimensions of the data frame.

 We can access a column
in a `data.frame` by using the `$` operator

~~~{.r}
df$x
~~~



~~~{.output}
[1] 1 2 3 4 5 6

~~~
or

~~~{.r}
df[,'x']
~~~



~~~{.output}
[1] 1 2 3 4 5 6

~~~

We can add columns or rows to a data.frame using `cbind` or `rbind`
(these are the two-dimensional equivalents of the `c` function):

## Adding columns to a data frame

To add a column we can use `cbind`:


~~~{.r}
df <- cbind(df, z = 6:1, caps = LETTERS[1:6])
df
~~~



~~~{.output}
  id x   y z caps
1  a 1 100 6    A
2  b 2  99 5    B
3  c 3  98 4    C
4  d 4  97 3    D
5  e 5  96 2    E
6  f 6  95 1    F

~~~
(`LETTERS` and `letters` are built-in constants.)

Since under the hood data frames are lists, we can add columns just like adding new elements to lists:

~~~{.r}
df$zero <- rep(0, 6)
df
~~~



~~~{.output}
  id x   y z caps zero
1  a 1 100 6    A    0
2  b 2  99 5    B    0
3  c 3  98 4    C    0
4  d 4  97 3    D    0
5  e 5  96 2    E    0
6  f 6  95 1    F    0

~~~


## Adding rows to a data frame 

To add a row we use `rbind`:


~~~{.r}
df <- rbind(df, data.frame(id = "g", x = 11, y = 42, z = 0, caps = 'G', zero = NA))
str(df)
~~~



~~~{.output}
'data.frame':	7 obs. of  6 variables:
 $ id  : chr  "a" "b" "c" "d" ...
 $ x   : num  1 2 3 4 5 6 11
 $ y   : num  100 99 98 97 96 95 42
 $ z   : num  6 5 4 3 2 1 0
 $ caps: chr  "A" "B" "C" "D" ...
 $ zero: num  0 0 0 0 0 0 NA

~~~


## Deleting rows and handling NA


There are multiple ways to delete a row containing `NA`:


~~~{.r}
df[-7, ]  # The minus sign tells R to delete the row
~~~



~~~{.output}
  id x   y z caps zero
1  a 1 100 6    A    0
2  b 2  99 5    B    0
3  c 3  98 4    C    0
4  d 4  97 3    D    0
5  e 5  96 2    E    0
6  f 6  95 1    F    0

~~~



~~~{.r}
df[!is.na(df$zero), ]  # is.na() returns TRUE where its argument is NA
~~~



~~~{.output}
  id x   y z caps zero
1  a 1 100 6    A    0
2  b 2  99 5    B    0
3  c 3  98 4    C    0
4  d 4  97 3    D    0
5  e 5  96 2    E    0
6  f 6  95 1    F    0

~~~



~~~{.r}
df <- na.omit(df)  # Another function for the same purpose; checks all variables
df
~~~



~~~{.output}
  id x   y z caps zero
1  a 1 100 6    A    0
2  b 2  99 5    B    0
3  c 3  98 4    C    0
4  d 4  97 3    D    0
5  e 5  96 2    E    0
6  f 6  95 1    F    0

~~~

## Combining data frames

We can also row-bind data.frames together:


~~~{.r}
rbind(df, df)
~~~



~~~{.output}
   id x   y z caps zero
1   a 1 100 6    A    0
2   b 2  99 5    B    0
3   c 3  98 4    C    0
4   d 4  97 3    D    0
5   e 5  96 2    E    0
6   f 6  95 1    F    0
7   a 1 100 6    A    0
8   b 2  99 5    B    0
9   c 3  98 4    C    0
10  d 4  97 3    D    0
11  e 5  96 2    E    0
12  f 6  95 1    F    0

~~~
 
## Merging data frames
Data frames can be merged on one or more columns. Create a second dataset and merge it with our `df` object:

~~~{.r}
df2 <- data.frame(id = letters[1:5], X = 101:105)
df2
~~~



~~~{.output}
  id   X
1  a 101
2  b 102
3  c 103
4  d 104
5  e 105

~~~



~~~{.r}
df <- merge(df, df2, by = "id", all = TRUE)
df
~~~



~~~{.output}
  id x   y z caps zero   X
1  a 1 100 6    A    0 101
2  b 2  99 5    B    0 102
3  c 3  98 4    C    0 103
4  d 4  97 3    D    0 104
5  e 5  96 2    E    0 105
6  f 6  95 1    F    0  NA

~~~


## Reading in data

Now we want to load our data into R. We will use PSRC land use data, particularly in this lesson the number of households in cities.
Before reading in data, it's a good idea to have a look at its structure. From a shell terminal, you can do:


~~~{.r}
cd data/ # navigate to the data directory of the project folder
head cities_households.csv
~~~




~~~{.output}
city_id,hh2016,hh2020,hh2030,hh2040,hh2050
1,2705,2735,2836,2939,3037
2,24886,26527,32059,37708,43071
3,45021,45724,48094,50515,52813
4,10135,11122,14449,17846,21072
5,22527,23240,25643,28097,30427
6,16769,17481,19881,22332,24658
7,45076,46704,52190,57792,63110
8,7300,8075,10690,13359,15894
9,329066,344980,398615,453388,505387

~~~

The file contains comma-separated values and a header row. We can use `read.table` to read this into R:


~~~{.r}
hh <- read.table(file = "data/cities_households.csv", header = TRUE, sep = ",")
head(hh)
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050
1       1   2705   2735   2836   2939   3037
2       2  24886  26527  32059  37708  43071
3       3  45021  45724  48094  50515  52813
4       4  10135  11122  14449  17846  21072
5       5  22527  23240  25643  28097  30427
6       6  16769  17481  19881  22332  24658

~~~

Because we know the structure of the data, we're able
to specify the appropriate arguments to `read.table`.
Without these arguments, `read.table` will do its
best to do something sensible, but it is always more
reliable to explicitly tell `read.table` the structure
of the data. `read.csv` function provides a convenient shortcut
for loading in CSV files.


~~~{.r}
# Here is the read.csv version of the above command
hh <- read.csv(file = "data/cities_households.csv")
head(hh)
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050
1       1   2705   2735   2836   2939   3037
2       2  24886  26527  32059  37708  43071
3       3  45021  45724  48094  50515  52813
4       4  10135  11122  14449  17846  21072
5       5  22527  23240  25643  28097  30427
6       6  16769  17481  19881  22332  24658

~~~

> ## Miscellaneous Tips {.callout}
>
> 1. Another type of file you might encounter are tab-separated
> format. To specify a tab as a separator, use `sep="\t"`.
>
> 2. You can also read in files from the Internet by replacing
> the file paths with a web address.
>
> 3. You can read directly from excel spreadsheets without
> converting them to plain text first by using the `xlsx` package.
>

To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later. It can be then run using the `source` function, using the file path
as its argument (or by pressing the "source" button in RStudio).

## Using data frames


To recap what we've just learned, let's have a look at our example
data (number of households in various cities for various years).

Remember, there are a few functions we can use to interrogate data structures in R:


~~~{.r}
class() # what is the data structure?
typeof() # what is its atomic type?
length() # how long is it? What about two dimensional objects?
attributes() # does it have any metadata?
str() # A full summary of the entire object
dim() # Dimensions of the object - also try nrow(), ncol()
~~~

Let's use them to explore the household dataset.


~~~{.r}
class(hh)
~~~



~~~{.output}
[1] "data.frame"

~~~

The household data is stored in a "data.frame". This is the default
data structure when you read in data, and (as we've heard) is useful
for storing data with mixed types of columns.

Let's add a column with the name of each city and county and merge the two datasets:


~~~{.r}
cities <- read.csv(file="data/cities.csv")
head(cities)
~~~



~~~{.output}
  city_id     city_name county_id county_name
1       1 Normandy Park        33        King
2       2        Auburn        33        King
3       3    King-Rural        33        King
4       4        SeaTac        33        King
5       5     Shoreline        33        King
6       6    Renton PAA        33        King

~~~

Let's merge the cities dataset with our households dataset.

~~~{.r}
hh <- merge(hh, cities, by="city_id", all = TRUE)
head(hh)
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id
1       1   2705   2735   2836   2939   3037 Normandy Park        33
2       2  24886  26527  32059  37708  43071        Auburn        33
3       3  45021  45724  48094  50515  52813    King-Rural        33
4       4  10135  11122  14449  17846  21072        SeaTac        33
5       5  22527  23240  25643  28097  30427     Shoreline        33
6       6  16769  17481  19881  22332  24658    Renton PAA        33
  county_name
1        King
2        King
3        King
4        King
5        King
6        King

~~~

The first thing you should do when reading data in, is check that it matches what
you expect, even if the command ran without warnings or errors. The `str` function,
short for "structure", is really useful for this:


~~~{.r}
str(hh)
~~~



~~~{.output}
'data.frame':	161 obs. of  9 variables:
 $ city_id    : int  1 2 3 4 5 6 7 8 9 10 ...
 $ hh2016     : int  2705 24886 45021 10135 22527 16769 45076 7300 329066 171 ...
 $ hh2020     : int  2735 26527 45724 11122 23240 17481 46704 8075 344980 176 ...
 $ hh2030     : int  2836 32059 48094 14449 25643 19881 52190 10690 398615 195 ...
 $ hh2040     : int  2939 37708 50515 17846 28097 22332 57792 13359 453388 213 ...
 $ hh2050     : int  3037 43071 52813 21072 30427 24658 63110 15894 505387 230 ...
 $ city_name  : chr  "Normandy Park" "Auburn" "King-Rural" "SeaTac" ...
 $ county_id  : int  33 33 33 33 33 33 33 33 33 33 ...
 $ county_name: chr  "King" "King" "King" "King" ...

~~~

We can see that the object is a `data.frame` with 161 observations (rows),
and 9 variables (columns). Below that, we see the name of each column, followed
by a ":", followed by the type of variable in that column, along with the first
few entries.

We can retrieve or modify the column or row names
of the data.frame:


~~~{.r}
colnames(hh) 
~~~



~~~{.output}
[1] "city_id"     "hh2016"      "hh2020"      "hh2030"      "hh2040"     
[6] "hh2050"      "city_name"   "county_id"   "county_name"

~~~



~~~{.r}
colnames(hh)[ncol(hh)] <- "county" # rename the last column
head(hh, n = 10)
~~~



~~~{.output}
   city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id county
1        1   2705   2735   2836   2939   3037 Normandy Park        33   King
2        2  24886  26527  32059  37708  43071        Auburn        33   King
3        3  45021  45724  48094  50515  52813    King-Rural        33   King
4        4  10135  11122  14449  17846  21072        SeaTac        33   King
5        5  22527  23240  25643  28097  30427     Shoreline        33   King
6        6  16769  17481  19881  22332  24658    Renton PAA        33   King
7        7  45076  46704  52190  57792  63110          Kent        33   King
8        8   7300   8075  10690  13359  15894       Tukwila        33   King
9        9 329066 344980 398615 453388 505387       Seattle        33   King
10      10    171    176    195    213    230      Kent PAA        33   King

~~~


~~~{.r}
rownames(hh)[1:20]
~~~



~~~{.output}
 [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14" "15"
[16] "16" "17" "18" "19" "20"

~~~

See those numbers in the square brackets on the left? That tells you
the number of the first entry in that row of output. 

There are a few related ways of retrieving and modifying this information.
`attributes` will give you both the row and column names, along with the
class information, while `dimnames` will give you just the rownames and
column names.

In both cases, the output object is stored in a `list`:


~~~{.r}
str(dimnames(hh))
~~~



~~~{.output}
List of 2
 $ : chr [1:161] "1" "2" "3" "4" ...
 $ : chr [1:9] "city_id" "hh2016" "hh2020" "hh2030" ...

~~~

We can look at some summary statistics:

~~~{.r}
summary(hh)
~~~



~~~{.output}
    city_id           hh2016           hh2020           hh2030      
 Min.   :  1.00   Min.   :     0   Min.   :     0   Min.   :     0  
 1st Qu.: 41.00   1st Qu.:   310   1st Qu.:   327   1st Qu.:   382  
 Median : 82.00   Median :  2736   Median :  2789   Median :  3089  
 Mean   : 82.79   Mean   :  9825   Mean   : 10295   Mean   : 11878  
 3rd Qu.:122.00   3rd Qu.:  8704   3rd Qu.:  9251   3rd Qu.: 10915  
 Max.   :173.00   Max.   :329066   Max.   :344980   Max.   :398615  
     hh2040           hh2050        city_name           county_id    
 Min.   :     0   Min.   :     0   Length:161         Min.   :33.00  
 1st Qu.:   407   1st Qu.:   474   Class :character   1st Qu.:33.00  
 Median :  3535   Median :  3936   Mode  :character   Median :53.00  
 Mean   : 13495   Mean   : 15031                      Mean   :46.98  
 3rd Qu.: 12060   3rd Qu.: 13976                      3rd Qu.:61.00  
 Max.   :453388   Max.   :505387                      Max.   :61.00  
    county         
 Length:161        
 Class :character  
 Mode  :character  
                   
                   
                   

~~~


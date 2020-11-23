# Get a sequences of dates in steps of one month
# from Sept 17, 2014 to today
date_sequence <- seq(from = ymd("2014-09-17"), 
                     to = today(), 
                     by='months')

# function to count packages on cran
# on a given date
count_cran_packages <- function(snapshot_date){
    repo <- sprintf(
        'https://cran.microsoft.com/snapshot/%s/',
        snapshot_date
    )
    available.packages(repos = repo) %>% 
        nrow()
}


# count packages on cran on each day in sequence
npackages_df <- tibble(date = date_sequence,
                       n = map_dbl(date, count_cran_packages)
) %>% 
    # counts of 0 occur due to errors, so zap them
    filter(n > 0)

jpeg("package_count.jpg")
plot(npackages_df, xlab = "", ylab = "# R packages", main = "Number of R packages on CRAN")
dev.off()

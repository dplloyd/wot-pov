library(tidyverse)
library(rvest)


html <- read_html("https://wot.fandom.com/wiki/Statistical_analysis")


data <- html_table(html)


glimpse(data)


# Odd numbered indexes has the detailed information
to_select <- seq(1,29,  by = 2)

chapter_data <- data[to_select]

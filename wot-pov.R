library(tidyverse)
library(rvest)


html <- read_html("https://wot.fandom.com/wiki/Statistical_analysis")


data <- html_table(html)


glimpse(data)


# Odd numbered indexes has the detailed information
to_select <- seq(1,29,  by = 2)

chapter_data <- data[to_select]


book_titles <- list(
    "New Spring",
    "The Eye of the World",
    "The Great Hunt",
    "The Dragon Reborn",
    "The Shadow Rising",
    "The Fires of Heaven",
    "Lord of Chaos",
    "A Crown of Swords",
    "The Path of Daggers",
    "Winter's Heart",
    "Crossroads of Twilight",
    "Knife of Dreams",
    "The Gathering Storm",
    "Towers of Midnight",
    "A Memory of Light"
)
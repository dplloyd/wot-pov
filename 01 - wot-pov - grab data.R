library(tidyverse)
library(rvest)



# Read data from website, and grab the tables
html <- read_html("https://wot.fandom.com/wiki/Statistical_analysis")
data <- html_table(html)

glimpse(data)


# Odd numbered indexes has the detailed information I'm after
to_select <- seq(1,29,  by = 2)
wot <- data[to_select]

# Fix MoL, where the table columns haven't pulled through correctly

wot[[15]] <- wot[[15]] |> 
    rename(Chapter = X1, Character = X2, `Word Count` = X3, Percentage = X4)

# Define the book titles
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

# Bind all list elements into a single dataframe, using the name of the list rows as the books and id.
names(wot) <- book_titles
wot <- bind_rows(wot, .id = "book")

# MoL still causing issues, but this fixes it.
wot <-  wot |> filter(Chapter != "Chapter")


# Fix formatting
wot <- janitor::clean_names(wot) |> 
    select(book, chapter,character,word_count)

wot$word_count <- 
    str_remove(wot$word_count,"[,]")

wot$word_count <- as.numeric(wot$word_count)

glimpse(wot)

# Write these data in case the website disappears...
write.csv(wot,"wot-pov.csv") 





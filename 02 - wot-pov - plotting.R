library(tidyverse)
library(ggtext)

wot <- read_csv("wot-pov.csv")

mean(wot$word_count,na.rm = TRUE)

wot |> filter(is.na(word_count))

book_titles <- tribble(~book, ~number,
    "New Spring", 0,
    "The Eye of the World",1,
    "The Great Hunt",2,
    "The Dragon Reborn",3,
    "The Shadow Rising",4,
    "The Fires of Heaven",5,
    "Lord of Chaos",6,
    "A Crown of Swords",7,
    "The Path of Daggers",8,
    "Winter's Heart",9,
    "Crossroads of Twilight",10,
    "Knife of Dreams",11,
    "The Gathering Storm",12,
    "Towers of Midnight",13,
    "A Memory of Light",14
)

# Add book number in chronological order (assign the prequel as 0)
wot <- left_join(wot, book_titles)


# Word count by book
book_wc <- wot |> group_by(number, book, character) |> summarise(wc = sum( word_count))

book_wc$book<- factor(book_wc$book, ordered = TRUE, levels = book_titles$book)

ggplot(book_wc) +
    geom_col(aes(x = fct_rev(book), y =  wc, fill = character)) +
    coord_flip() +
    theme_minimal()+
    theme(legend.position = "none")

# Unique POVs by book
pov_count <-
    wot |> group_by(number, book) |>
    summarise(pov_n = unique(character)
              ) |>
    filter(pov_n != "Quote") |>
    group_by(book) |>
    count(book)

pov_count$book <- factor(pov_count$book, ordered  = TRUE, levels = book_titles$book)


ggplot(pov_count) +
    geom_col(aes(x = fct_rev(book), y =  n)) +
    coord_flip() +
    theme_minimal()+
    theme(legend.position = "none")




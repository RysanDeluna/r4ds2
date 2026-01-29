library(tidyverse)

# The EDA is a creative process fueled by questions and answers regarding
# data. With every answer acquired, another question can arise.

# Important Questions that will always be useful on EDA:
# What type of variation occurs within my variables?
# What type of covariation occurs between my variables?
  
# Variation -----

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.5)

## Questions surrounding variables -----

### Typical values -----
# Which values are the most common? Why?
# Which values are rare? Why? Does that match your expectations?
# Can you see any unusual patterns? What might explain them?
  
smaller <- diamonds |>
  filter(carat < 3)

ggplot(smaller, aes(x = carat)) + 
  geom_histogram(binwidth = 0.01)

#### To understand the subgroups ----

# How are the observations within each subgroup similar to each other?
# How are the observations in separate clusters different from each other?
# How can you explain or describe the clusters?
# Why might the appearance of clusters be misleading?
  
### Unusual values (outliers) -----

ggplot(diamonds, aes(x=y)) + 
  geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(x=y)) +
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

unusual <- diamonds |>
  filter(y < 3 | y > 20) |>
  select(price, x, y, z) |>
  arrange(y)
unusual

## Ex ----
#Explore the distribution of each of the x, y, and z variables in diamonds. What do you learn? Think about a diamond and how you might decide which dimension is the length, width, and depth.
ggplot(diamonds, aes(x = x)) +       # depth
  geom_histogram(binwidth = 0.3) +
  coord_cartesian(xlim = c(2, 15))

ggplot(diamonds, aes(x = y)) +       # width
  geom_histogram(binwidth = 0.3) +
  coord_cartesian(xlim = c(2, 15))

ggplot(diamonds, aes(x = z)) +       # length
  geom_histogram(binwidth = 0.3) +
  coord_cartesian(xlim = c(2, 15))

# A: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(diamonds, aes(x = price)) +
  geom_histogram(binwidth = 2) +
  coord_cartesian(xlim = c(1400, 1700))

# R: Around the zoomed interval there is a gap on the data, meaning diamonds on
#    that range of price were not found or registered. 

# A: How many diamonds are 0.99 carat? How many are 1 carat? What do you think is the cause of the difference?





 



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
diamonds |>
  filter(carat == 0.99) |>
  count()
diamonds |>
  filter(carat == 1) |>
  count()

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.01) +
  coord_cartesian(xlim = c(0.7, 1.2))

# A: there are only 23 diamonds with 0.99 carat and 1558 diamonds
#    with 1 carat. I believe this is due the production method of these diamonds;
#    maybe a industry standard to make diamonds with exact number of carat or 
#    limitations given to the tools used on the confection of diamonds.
#    In the plot given, we see that on exact numbers (that is, with only one decimal
#    point) the amount of diamonds is higher than in-between them. Probably the 
#    diamonds with carats with 2 decimal points suffered from confection imprecision.

# Covariation ----

## categorical and a numerical variable -----

ggplot(diamonds, aes(x = price, y = after_stat(density))) + 
  geom_freqpoly(aes(color = cut), binwidth = 500, linewidth = 0.75)

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(mpg, aes(x = fct_reorder(class, hwy, median), y = hwy)) + # Reorder class based on median of hwy
  geom_boxplot()

### Ex ---- 
# A: Use what you’ve learned to improve the visualization of the departure times of cancelled vs. non-cancelled flights.

# og:
nycflights13::flights |> 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + (sched_min / 60)
  ) |> 
  ggplot(aes(x = sched_dep_time)) + 
  geom_freqpoly(aes(color = cancelled), binwidth = 1/4)

# R:
flight_ex <- nycflights13::flights |> 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + (sched_min / 60)
  )

ggplot(flight_ex, aes(x = sched_dep_time, y = after_stat(density))) +
  geom_freqpoly(aes(color = cancelled), binwidth=1/4)

ggplot(flight_ex, aes(x = sched_dep_time, y = cancelled)) +
  geom_boxplot()

# A: Install the lvplot package, and try using geom_lv() to display the distribution of price vs. cut. What do you learn? How do you interpret the plots?
library(lvplot)
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_lv()
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# Ex 5 (too long of a text to insert here)
ggplot(diamonds, aes(x = price, y = clarity)) +
  geom_violin(aes(fill = clarity))

ggplot(diamonds, aes(x = price)) + 
  geom_histogram(bins = 400) + 
  facet_wrap(~clarity)

ggplot(diamonds, aes(x = price)) +
  geom_freqpoly(aes(color = clarity))

ggplot(diamonds, aes(x = price)) +
  geom_density(aes(color = clarity))

## Two Categorical Variables ----
ggplot(diamonds, aes(x = cut, y = color)) +
  geom_count()

diamonds |> 
  count(color, cut) |>  
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))

## Two numerical Variables -----

ggplot(smaller, aes(x = carat, y = price)) +
  geom_point()

ggplot(smaller, aes(x = carat, y = price)) + 
  geom_point(alpha = 1 / 100)

# For large datasets, use bins 
ggplot(smaller, aes(x = carat, y = price)) + 
  geom_bin2d()

install.packages("hexbin")
ggplot(smaller, aes(x = carat, y = price)) +
  geom_hex()


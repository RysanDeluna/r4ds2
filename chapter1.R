library(tidyverse)
library(palmerpenguins)
library(ggthemes)


ggplot(
  data=penguins,
  mapping=aes(x=flipper_length_mm, y=body_mass_g),
) + geom_point(aes(color=species, shape=species)) +
  geom_smooth(method = "lm") +
  labs(
    title="Flipper X Body Mass",
    subtitle="How are they related?",
    x="Flipper Length (mm)", y="Body Mass (g)"
  ) +
  scale_color_colorblind()

# Exercises
# How many rows are in penguins? how many columns?
glimpse(penguins)

# What is bill_depth
?penguins

# scatterplot of billdepth x length
  ggplot(
    data=penguins,
    mapping=aes(y=species, x=bill_length_mm),
  ) + 
    geom_boxplot(aes(color=species))
# Scatter species bill_depth

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)


ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()


# Categorical variable  
ggplot(penguins, aes(x = fct_infreq(species))) + 
  geom_bar()

# Numerical Variables
ggplot(penguins, aes(x = body_mass_g)) + 
  geom_histogram(binwidth= 100)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

# Ex. 1.4.3
## 1
ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()

## 2
ggplot(penguins, aes(x = species))+
  geom_bar(fill="red")


## 4
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth=0.13)

# Relationships - N x C 
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.3)

# Relationships - C x C
ggplot(penguins, aes(x = island, fill = species)) + 
  geom_bar()

ggplot(penguins, aes(x = island, fill = species )) +
  geom_bar(position = 'fill')

# Relationships - N x N
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

# 3 or more variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

# Facets
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = island, shape = species)) +
  facet_wrap(~species)




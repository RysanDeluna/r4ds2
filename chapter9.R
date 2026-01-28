library(tidyverse)

mpg

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

# Ex 1 Create a scatterplot of hwy vs. displ where the points are pink filled in triangles.
ggplot(mpg, aes(y = hwy, x = displ)) +
  geom_point(fill="pink", shape=24)

# Ex 2 What happens if you map an aesthetic to something other than a variable name, like aes(color = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(mpg, aes(x = displ, y = hwy, color = displ < 5)) +
  geom_point()

# Segunda parte -----------
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth()

ggplot(mpg, aes(x=displ, y=hwy)) +
  geom_point() + 
  geom_point(
    data = mpg |> filter(class == "2seater"),
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"),
    shape = "circle open", size = 3, color = "red"
  )


library(ggridges)

ggplot(mpg, aes(x = hwy, y = drv, fill = drv, color = drv)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)

# Recreate the R code necessary to generate the following graphs. Note that wherever a categorical variable is used in the plot, it’s drv.
mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(se = FALSE)

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(se = FALSE, aes(group = drv))

mpg |>
  ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(se = FALSE, aes(color = drv, group = drv))

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) + 
  geom_smooth(se = FALSE, aes(group = drv, linetype = drv))

mpg |>
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) +
  geom_point(shape = "circle open", color = "white", size = 3)


# Facetting -------
mpg |> 
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)

mpg |> 
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)

mpg |> 
  ggplot(aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl, scale="free")

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(drv ~ .)

# Statistical Transformations ------
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

diamonds |>
  count(cut) |>
  ggplot(aes(x=cut, y=n)) +
  geom_bar(stat = "identity")

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar()

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Exercícios

ggplot(diamonds) +
  geom_pointrange(
    aes(x = cut, y = depth),
    stat = "summary",
    fun = median,
    fun.min = min,
    fun.max = max
  )

ggplot(diamonds) +
  geom_col(aes(x = cut, y = depth))

ggplot(diamonds) +
  stat_smooth(aes(x = depth, y = carat))

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar()

ggplot(diamonds) + 
  geom_bar(aes(x = cut, y = after_stat(prop), group = color, fill = color),
           position = "dodge")

# Position adjustments ------

# Left
ggplot(mpg, aes(x = drv, color = drv)) + 
  geom_bar()

# Right
ggplot(mpg, aes(x = drv, fill = drv)) + 
  geom_bar()

ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar()

# Left
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "fill")

# Right
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "dodge")

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(position = "jitter") #or

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_jitter()

# Ex1 how to improve the graph:
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_point()
# R:
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_jitter()

# Ex2 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity")

# The layered grammar of graphics ----- 
#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(
#    mapping = aes(<MAPPINGS>),
#    stat = <STAT>, 
#    position = <POSITION>
#  ) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>

ggplot(diamonds) +
  stat_smooth(aes(x=cut, y=carat))










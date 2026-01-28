library(nycflights13)
library(tidyverse)

View(flights)

flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# Dplyr For ROWS ----- 
flights |> filter(dep_delay > 120)              # Filter
flights |> arrange(year, month, day, dep_time)  # Reordena
flights |> distinct(.keep_all=TRUE)             # Busca rows únicas

# Dplyr for COLUMNS -----
flights |>   # Create columns based on transformations on other ones 
  mutate(    # Ver possíveis argumentos depois
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60, 
    .before = 1  # Para adicionar na esquerda do df
  )
flights |> select(year:day)  # See ?select
flights |> rename(tail_num = tailnum)  # Rename a column, see also janitor::clean_names()
flights |> relocate(time_hour, air_time)  # Realoca variáveis e também permite usar argumentos .before e .after

# Dplyr for Groups -----
flights |> 
  group_by(month) |>
  summarise(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

# Slice functions
flights |> slice_head(n = 5)
flights |> slice_tail(n = 1)
flights |> slice_min(dep_delay, n = 5)
flights |> slice_max(dep_delay, n = 5)
flights |> slice_sample(n = 5)  # Random rows
flights |> slice_min(dep_delay, prop=0.1)

# Back to groups ----------------------------------------------------------

flights |>
  group_by(dest) |>
  slice_max(arr_delay, n = 1, with_ties=FALSE) |>
  relocate(dest)
# .by
flights |>
  summarise(
    delay = mean(dep_delay, na.rm = TRUE),
    n = n(),
    .by = month
  )


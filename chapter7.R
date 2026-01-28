library(tidyverse)

students <- read_csv("https://pos.it/r4ds-students-csv", na=c("", "N/A"))
students |>
  rename(
    student_id = `Student ID`,
    full_name  = `Full Name`,
    meal_plan  = mealPlan,
    age = AGE
  ) |> # or janitor::clean_names()
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age))
  )


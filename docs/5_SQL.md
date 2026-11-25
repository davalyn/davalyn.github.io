# SQL

## Loading the datasets

We load the dengue and flu datasets from local CSV files. The Gapminder dataset is loaded from the dslabs package.


``` r
library(tidyverse)
library(dslabs)

dengue <- read_csv("data/dengue_data.csv", skip = 11)
flu <- read_csv("data/flu_data.csv", skip = 11)
gapminder_data <- dslabs::gapminder
```

## Checking and making the datasets tidy

The dengue and flu datasets are initially stored in wide format, with each country represented by a separate column. We transform these datasets into long format using `pivot_longer()`.


``` r
dengue_tidy <- dengue %>%
  pivot_longer(cols = -Date, names_to = "country", values_to = "dengue")

flu_tidy <- flu %>%
  pivot_longer(cols = -Date,names_to = "country", values_to = "flu")
```

The Gapminder dataset is already in tidy format.

## Standardizing country and date variables

The dengue and flu datasets contain weekly dates, while Gapminder contains yearly data. We standardize the country and year variables to make the datasets compatible for joining.


``` r
dengue_tidy <- dengue_tidy %>%
  mutate(country = as.character(country), 
         year = as.integer(substr(Date, 1, 4)))

flu_tidy <- flu_tidy %>%
  mutate(country = as.character(country), 
         year = as.integer(substr(Date, 1, 4)))

gapminder_tidy <- gapminder_data %>%
  mutate(country = as.character(country))
```



The datasets now have matching data types for `country` and `year`.

## Checking country names



The country names were checked across all three datasets using `unique()`. The datasets contain different numbers of countries, but four countries are present in all three: Argentina, Bolivia, Brazil and Mexico.

## Preparing the datasets for joining

Only countries present in all three datasets are selected. The weekly dengue and flu data are summarized into yearly averages to match the yearly Gapminder data.


``` r
# Select countries present in all three datasets
common_countries <- unique(dengue_tidy$country[
  dengue_tidy$country %in% flu_tidy$country &
  dengue_tidy$country %in% gapminder_tidy$country])

# Filter all datasets
dengue_tidy <- dengue_tidy %>%
  filter(country %in% common_countries)

flu_tidy <- flu_tidy %>%
  filter(country %in% common_countries)

gapminder_tidy <- gapminder_tidy %>%
  filter(country %in% common_countries)

# Calculate yearly averages
dengue_yearly <- dengue_tidy %>%
  group_by(country, year) %>%
  summarise(dengue = mean(dengue, na.rm = TRUE), .groups = "drop")

flu_yearly <- flu_tidy %>%
  group_by(country, year) %>%
  summarise(flu = mean(flu, na.rm = TRUE), .groups = "drop")
```

The dengue and flu datasets now contain yearly averages for each country. This allows them to be joined with Gapminder using `country` and `year`.

## Saving the datasets

The three prepared datasets are saved as CSV files so they can be imported into PostgreSQL.


``` r
write_csv(dengue_yearly, "data/dengue_yearly.csv")
write_csv(flu_yearly, "data/flu_yearly.csv")
write_csv(gapminder_tidy, "data/gapminder.csv")
```

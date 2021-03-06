mtcars %>%
  ggplot(aes(x = cyl, y = hp)) +
  geom_jitter()

b <- mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()

c <- mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()

grade_this({
  pass_if_equal(y = mtcars[, "mpg"],
                x = mtcars)
})

grade_this_code()(
  mock_this_exercise(
    .user_code     = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()", # user submitted code
    .solution_code = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()"  # from -solution chunk
  )
)


print(pass_if_equal(y = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()", # user submitted code
              x = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()"  # from -solution chunk
              ))


disp_hist_base <- function() hist(mtcars$disp)
disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()

vdiffr::expect_doppelganger("test1.png", b)
vdiffr::expect_doppelganger("test1.png", b)

b
ggsave(filename = "test1.svg")

testthat::test_that("base histogram works", {
  p <- function() hist(mtcars$disp)
  expect_doppelganger("base histogram", p)
})


diamonds %>%
  ggplot(aes(x = cut, y = carat)) +
  # geom_boxplot() +
  geom_jitter(alpha = 0.5) +
  geom_boxplot()

diamonds %>%
  head(1000) %>%
  ggplot(aes(x = color, y = cut)) +
  # geom_boxplot() +
  geom_jitter(alpha = 0.5)

mtcars %>%
  ggplot(aes(x = disp, y = mpg)) +
  geom_point()

mtcars %>%
  ggplot(aes(x = cyl, y = hp)) +
  geom_point() +
  labs(title = "Relationship between Gross horsepower and Number of Cylinders for 32 automobiles in 1974",
       x = "Number of Cylinders",
       y = "Gross horsepower")

mtcars %>%
  ggplot(aes(x = mpg, y = hp, colour = wt)) +
  geom_point()


faithfuld
ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
  geom_raster()

world <- map_data('world')

world %>%
  filter(region == "USA")


who_covid %>%
  mutate(name = case_when(name == "United States of America" ~ "USA",
                          name == "United Kingdom" ~ "UK",
                          TRUE ~ name))

for(i in 1:3) {
  sprintf("questions/q-%.3d.R", i)
}

for(i in 1:3) {
  cat(paste0("questions-ui/q-",stringr::str_pad(i, 3, side = "left", pad = "0"), ".rds"))
}


# txhousing ---------------------------------------------------------------
top3_cities <- txhousing %>%
  filter(year == 2000) %>%
  group_by(city) %>%
  summarise(tot_sales = sum(sales)) %>%
  arrange(-tot_sales) %>%
  head(3) %>%
  pull(city)


txhousing %>%
  filter(year == 2000, city %in% top3_cities) %>%
  group_by(city, month) %>%
  summarise(tot_sales = sum(sales)) %>%
  ggplot(aes(x = month, y = tot_sales, fill = city)) +
  geom_col()

# world bank GPD data -----------------------------------------------------


GDP <- read_csv(here::here("test/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_3052522.csv"), skip = 4,
                col_select = list(`Country Name`, `1960`:`2020`)) %>%
  janitor::clean_names() %>%
  mutate(country_name = case_when(country_name == "United Kingdom" ~ "UK",
                                  country_name == "United States" ~ "USA",
                                  TRUE ~ country_name))

names(GDP)[-1] <- substring(names(GDP)[-1], 2)

GDP_clean <- GDP %>%
  pivot_longer(cols = c(2:ncol(GDP)), names_to = "year", values_to = "GDP") %>%
  mutate(year = as.numeric(year))

GDP_clean %>%
  left_join(world, by = c("country_name" = "region")) %>%
  filter(year == 2020) %>%
  ggplot(aes(long, lat, group = group, fill = GDP)) +
  geom_polygon(colour = 'white') +
  coord_quickmap()


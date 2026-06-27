# neacessary libraries
library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)

# load data
customers <- read.csv("olist_customers_dataset.csv")
order_items <- read.csv("olist_order_items_dataset.csv")
payments <- read.csv("olist_order_payments_dataset.csv")
products <- read.csv("olist_products_dataset.csv")
category <- read.csv("product_category_name_translation.csv")
orders <- read.csv("olist_orders_dataset.csv")


# Merge
data <- orders %>%
  left_join(customers, by = "customer_id") %>%
  left_join(order_items, by = "order_id") %>%
  left_join(payments, by = "order_id") %>%
  left_join(products, by = "product_id") %>%
  left_join(category, by = "product_category_name")

# Basic Cleaning
# Convert date columns
data$order_purchase_timestamp <- as.POSIXct(data$order_purchase_timestamp)

# Check missing values
colSums(is.na(data))

# Remove duplicates if any
data <- distinct(data)

total_revenue<- sum(data$price , na.rm = TRUE)
total_revenue

data$month_year <- format(data$order_purchase_timestamp, "%Y-%m")

monthly_sales <- data %>%
  group_by(month_year) %>%
  summarise(revenue = sum(price, na.rm = TRUE))

ggplot(monthly_sales, aes(x = month_year, y = revenue, group = 1)) +
  geom_line() +
  theme(axis.text.x = element_text(angle = 90))

top_categories <- data %>%
  group_by(product_category_name_english) %>%
  summarise(revenue = sum(price, na.rm = TRUE)) %>%
  arrange(desc(revenue)) %>%
  head(10)

ggplot(top_categories, aes(x = reorder(product_category_name_english, revenue), y = revenue)) +
  geom_bar(stat = "identity") +
  coord_flip()

top_cities <- data %>%
  group_by(customer_city) %>%
  summarise(orders = n()) %>%
  arrange(desc(orders)) %>%
  head(10)

ggplot(top_cities, aes(x = reorder(customer_city, orders), y = orders)) +
  geom_bar(stat = "identity") +
  coord_flip()

ggplot(data, aes(x = payment_type)) +
  geom_bar()

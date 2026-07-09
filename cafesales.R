library(readr)
library(dplyr)
library(tidyr)
library(janitor)

df <- read_csv("dirty_cafe_sales.csv")
read.csv("dirty_cafe_sales.csv")

head(df)
tail(df)
dim(df)
colnames(df)
sapply(df , class)
colSums(is.na(df))
sum(duplicated(df))
sum(is.na(df))

df <- df %>%
  clean_names()

df$item[is.na(df$item)] <- "Unknown"
colSums(is.na(df))

df$quantity[is.na(df$quantity)] <- "Unknown"

df$price_per_unit[is.na(df$price_per_unit)]<- "Unknown"
df$total_spent[is.na(df$total_spent)]<- "Unknown"
df$payment_method[is.na(df$payment_method)] <- "Unknown"
df$location[is.na(df$location)] <- "Unknown"
df$transaction_date[is.na(df$transaction_date)] <- "Unknown"

colSums(is.na(df))

write_csv(df, "Cafe_sales_cleaned.csv")
getwd()

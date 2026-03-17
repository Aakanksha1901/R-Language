library(tidyr)
install.packages("ggplot2")
library(ggplot2)
library(dplyr)

AI_jobs <- read_csv("ai_job_dataset.csv")

print("First 5 Rows:")
head(AI_jobs)

print("Last 5 Rows:")
tail(AI_jobs)

print("Structure of Dataset")
str(AI_jobs)

#shape of dataset
dim(AI_jobs)

#summary of dataset
print("Summary Statistics")
summary(AI_jobs)


#Salary Distribution
ggplot(AI_jobs, aes(x = salary_usd)) +
  geom_histogram(bins = 30) +
  labs(title = "Salary Distribution",
       x = "Salary (USD)" ,
       y = "Count")

ggplot(AI_jobs , aes (x = years_experience , y = salary_usd)) +
  geom_point() +
  labs (title = "Salary vs Years of Experience" ,
        x = "Years of Experience" ,
        y = "Salary (USD)")


avg_salary <- AI_jobs %>%
  group_by(experience_level) %>%
  summarise(avg_salary = mean(salary_usd , na.rm = TRUE))

ggplot(avg_salary , aes (x = experience_level , y= avg_salary)) +
  geom_bar(stat = "identity") +
  labs (title = "Average salary by Years of Experience level" ,
        x = "Experience Level" ,
        y = "Average Salary")


ggplot(AI_jobs , aes(x = industry)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45 , hjust =1 )) +
  labs(title = "Number of Jobs by Industry" ,
       x = "Industry" ,
       y = "Count")


ggplot(AI_jobs , aes (x = factor (remote_ratio))) +
  geom_bar() +
  labs (title = "Remote Work Distribution",
        x = "Remote Ratio(0 = Onsite , 50 = Hybrid, 100= Remote)" , 
        y = "Number of JObs")


ggplot(AI_jobs , aes (x = employment_type , y = salary_usd)) +
  geom_boxplot() +
  labs (title = "Salary Distribution by Employment Type" ,
        x = "Employment Type" , 
        y = "Salary (USD)")


ggplot(AI_jobs , aes (x = education_required)) +
  geom_bar() +
  labs (title = "Education Requirement Distribution" ,
        x = "Education Level" ,
        y = "Count")


numeric_cols <- AI_jobs %>%
  select (where(is.numeric))


cor_matrix <- cor(numeric_cols , use = "complete.obs")
print("Correlation Matrix :")
print(cor_matrix)

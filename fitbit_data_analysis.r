#install the necessary packages
install.packages('tidyverse')
library(tidyverse)

#import the csv files into tables
daily_activity <- read.csv("/cloud/project/Capstone/dailyActivity_merged.csv")
sleep_activity <- read.csv("/cloud/project/Capstone/sleepDay_merged.csv")

#outer join the csv files on "UniqueID" which combines the date and
#participant id
merged_activity <- merge(x = daily_activity, y = sleep_activity,
                         by = "UniqueID", all = TRUE)

#a table only including the days where participants had 0 steps
#this assumes that the participant did not wear their device
daily_activity_deviceless <- filter(daily_activity, 
                                     daily_activity$TotalSteps == 0)

#variable to count the number of participant days recorded
total_customer_days_observed <- sum(merged_activity$TotalSteps >= 0)

#variable to count the number of participant days where
#participants wore their devices
daily_activity_count <- sum(merged_activity$TotalSteps > 0)

#variable to count the number of participant days where
#participants wore their device to sleep
sleep_activity_count <- sum(sleep_activity$UniqueID > 0)

#variable to count the number of participant days where
#participants did not wear their device
participant_days_without_steps <- sum(merged_activity$TotalSteps == 0)

#data frame that compares the values for days participants
#wore their devices and days participants wore their devices to sleep
act_vs_sleep <- data.frame(status = c("daily_activity_count", 
                                     "sleep_activity_count"),
                           participant_days = c(daily_activity_count,
                                     sleep_activity_count))

#data frame that compares the values for days participants
#wore their devices and days participants didn't wear their devices
days_with_and_without_steps <- data.frame(day_type = c("days_with_steps",
                                     "days_without_steps"),
                           number_of_participant_days = 
                             c(daily_activity_count,
                               participant_days_without_steps))

#bar graph that plots days participants wore their devices 
#and days participants wore their devices to sleep
ggplot(data = act_vs_sleep, aes(x = status, y = act_vs_sleep$participant_days)) +
  geom_bar(stat = "identity", fill = act_vs_sleep$participant_days) + 
  labs(title = "Total Activity Days vs. Sleep Days") +
  ylab("Participant Days") +
  xlab("Status")

#bar graph that plots days participants wore their devices 
#and days participants didn't wear their devices
ggplot(data = days_with_and_without_steps, 
       aes(x = day_type, y = days_with_and_without_steps$number_of_participant_days)) +
  geom_bar(stat = "identity", fill = days_with_and_without_steps$number_of_participant_days) + 
  labs(title = "Days With and Without Activity") +
  ylab("Participant Days") +
  xlab("Status")
  
#point plot that shows days where certain Ids did not wear their device
ggplot(data = daily_activity_deviceless) +
  geom_point(
    aes(x = ActivityDate, y = Id, 
    color = as.factor(Id))) + 
  labs(title = "Days Without Device") + 
  theme(legend.position = "none", axis.text.x = element_blank()) +
  ylab("Participant ID") +
  xlab("Date")

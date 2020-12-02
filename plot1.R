library(dplyr)
library(tidyr)
library(lubridate)
# Read in the col headers from the first line
colHeaders <- read.csv2("household_power_consumption.txt", header = TRUE , nrows = 1)
#Read only the required rows to save memory
data <- read.csv2("household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, na.strings = "?")
names(data) <- names(colHeaders)
data <- as_tibble(data)
#Convert Dates to date class
data$Date <- as.Date(data$Date, format = "%d/%m/%y")
#Convert data to numeric to be able to plot them
data[3:9] <- lapply(data[3:9], as.numeric)
png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
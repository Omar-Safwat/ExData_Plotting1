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
data$Date <- dmy(data$Date)
data <- unite(data, 'Date/Time', c(Date, Time), sep = " ")
data$`Date/Time` <- ymd_hms(data$`Date/Time`)

#Convert data to numeric to be able to plot them
data[2:8] <- lapply(data[2:8], as.numeric)

#plotting in png file
png(filename = "plot3.png", width = 480, height = 480)
with(data, plot(`Date/Time`, Sub_metering_1, xlab = "", 
                ylab = "Energy sub metering", type = "s"))
with(data, lines(`Date/Time`, Sub_metering_2, type = "s", col = "red"))
with(data, lines(`Date/Time`, Sub_metering_3, type = "s", col = "blue"))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()
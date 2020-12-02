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
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
with(data, 
{
  #Plot [1,1]
  plot(`Date/Time`, Global_active_power, xlab = "" ,
        ylab = "Global Active Power (kilowatts)", type = "l")
  #Plot [2,1]
  plot(`Date/Time`, Sub_metering_1, xlab = "", 
        ylab = "Energy sub metering", type = "s")
  lines(`Date/Time`, Sub_metering_2, type = "s", col = "red")
  lines(`Date/Time`, Sub_metering_3, type = "s", col = "blue")
  legend("topright",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1)
  #Plot [1,2]
  plot(`Date/Time`, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  #Plot [2,2]
  plot(`Date/Time`, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

dev.off()
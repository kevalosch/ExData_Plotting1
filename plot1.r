# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:
        
# Dataset: Electric power consumption [20Mb]

# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
        
# Date: Date in format dd/mm/yyyy

# Time: time in format hh:mm:ss

# Global_active_power: household global minute-averaged active power (in kilowatt)

# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)

# Voltage: minute-averaged voltage (in volt)

# Global_intensity: household global minute-averaged current intensity (in ampere)

# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).

# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.

# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# step 1 -> import the data set
require(readr)
install.packages("downloader")
library(downloader)
library(lubridate)
library(ggplot2)


# LOAD DATA DIRECTLY AS ZIP FILE FROM THE WEBSITE, UNPACK THE ZIP FILE AND CREATE THE DATAFRAME

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header = TRUE)
unlink(temp)
head(data)

data$Date <- dmy(data$Date)
head(data)
databackup <- data
filtered_data_coursera <- databackup %>% filter(Date == "2007-02-01" | Date == "2007-02-02")
summary(filtered_data_coursera)

# some cleaning/ data type changes
str(filtered_data_coursera)

filtered_data_coursera$Date <- as.Date(filtered_data_coursera$Date, format="%d/%m/%Y")
filtered_data_coursera$Time <- format(filtered_data_coursera$Time, format="%H:%M:%S")
filtered_data_coursera$Global_active_power <- as.numeric(filtered_data_coursera$Global_active_power)
filtered_data_coursera$Global_reactive_power <- as.numeric(filtered_data_coursera$Global_reactive_power)
filtered_data_coursera$Voltage <- as.numeric(filtered_data_coursera$Voltage)
filtered_data_coursera$Global_intensity <- as.numeric(filtered_data_coursera$Global_intensity)
filtered_data_coursera$Sub_metering_1 <- as.numeric(filtered_data_coursera$Sub_metering_1)
filtered_data_coursera$Sub_metering_2 <- as.numeric(filtered_data_coursera$Sub_metering_2)
filtered_data_coursera$Sub_metering_3 <- as.numeric(filtered_data_coursera$Sub_metering_3)


png("plot1.png", width=480, height=480)
hist(filtered_data_coursera$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kw)", ylab="Freq")
dev.off()



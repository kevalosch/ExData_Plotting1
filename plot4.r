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
library(downloader)
library(lubridate)
library(ggplot2)
library(tidyverse)

# LOAD DATA DIRECTLY AS ZIP FILE FROM THE WEBSITE, UNPACK THE ZIP FILE AND CREATE THE DATAFRAME

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data_kevin <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header = TRUE)
unlink(temp)
head(data_kevin)

## Create column in table with date and time merged together
date_time_combined <- strptime(paste(data_kevin$Date, data_kevin$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data_kevin <- cbind(powerdata, date_time_combined)

## change class of all columns to correct class
data_kevin$Date <- as.Date(data_kevin$Date, format="%d/%m/%Y")
data_kevin$Time <- format(data_kevin$Time, format="%H:%M:%S")
data_kevin$Global_active_power <- as.numeric(data_kevin$Global_active_power)
data_kevin$Global_reactive_power <- as.numeric(data_kevin$Global_reactive_power)
data_kevin$Voltage <- as.numeric(data_kevin$Voltage)
data_kevin$Global_intensity <- as.numeric(data_kevin$Global_intensity)
data_kevin$Sub_metering_1 <- as.numeric(data_kevin$Sub_metering_1)
data_kevin$Sub_metering_2 <- as.numeric(data_kevin$Sub_metering_2)
data_kevin$Sub_metering_3 <- as.numeric(data_kevin$Sub_metering_3)

## subset data from 2007-02-01 and 2007-02-02
subset_data_kevin <- subset(data_kevin, Date == "2007-02-01" | Date =="2007-02-02")

## plot the 4 graphs
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subset_data_kevin, plot(date_time_combined, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subset_data_kevin, plot(date_time_combined, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subset_data_kevin, plot(date_time_combined, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subset_data_kevin$date_time_combined, subset_data_kevin$Sub_metering_2,type="l", col= "red")
lines(subset_data_kevin$date_time_combined, subset_data_kevin$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subset_data_kevin, plot(date_time_combined, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()


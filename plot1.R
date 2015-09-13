## setwd("C:/Projects/Coursera/ExploratoryData")
## Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
## Different electrical quantities and some sub-metering values are available.

library(dplyr)
library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "../consumption.zip")
unzip("../consumption.zip")
 
## ../household_power_consumption.txt

data <- read.csv(file="../household_power_consumption.txt", nrows = 10, na.strings = "?", sep=";",  header = TRUE)
classes <- sapply(data,class)
table <- read.csv("../household_power_consumption.txt", sep = ";", nrows = 2075259,na.strings = "?", comment.char = " ", colClasses = classes)

## Approximate Memory Size 
 fileMB <- 2075259*9*8 / 2^20
 
 table$Date <- dmy(table$Date)
 DayInFeb <-  filter(table,Date >= mdy("2,1,2007"), Date<= mdy("2,2,2007"))
  
 ## hist(DayInFeb$Global_active_power,xlab="Global Active Power (Kilowatts)", ylab="Frequency", main = "Global Active Power", col="red")
 ## send to png device
 png(filename = "plot1.png",width = 480, height = 480)
 with(DayInFeb,hist(Global_active_power,xlab="Global Active Power (Kilowatts)", ylab="Frequency", main = "Global Active Power", col="red" ))
 dev.off()
 
 
      
 
 
## Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. 
## Different electrical quantities and some sub-metering values are available.
## Approximate Memory Size 
##fileMB <- 2075259*9*8 / 2^20


library(dplyr)
library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "../consumption.zip")
unzip("../consumption.zip")
 
## ../household_power_consumption.txt

data <- read.csv(file="../household_power_consumption.txt", nrows = 10, na.strings = "?", sep=";",  header = TRUE)
classes <- sapply(data,class)
table <- read.csv("../household_power_consumption.txt", sep = ";", nrows = 2075259,na.strings = "?", comment.char = " ", colClasses = classes)

 ## format date
 table$Date <- dmy(table$Date)
 ## Filter by date
 DaysInFeb <-  filter(table,Date >= mdy("2,1,2007"), Date<= mdy("2,2,2007"))
 
 ##write.csv(DaysInFeb, file = "tmpWorkingDates.csv")
 ## Free up memory
 rm(table)
 
 
 ##Join Date and Time
 DaysInFeb <- mutate(DaysInFeb, fulldate = paste(Date,Time))
 
 ## Create vector of dates
 newcolumndates <- strptime(DaysInFeb$fulldate, "%Y-%m-%d %H:%M:%S")
 
 ## Join date column to dataset
 chardates <- cbind(DaysInFeb,newcolumndates)
  
 ## plot( x= chardates$newcolumndates,  y =chardates$Global_active_power,ylab="Global Active Power (Kilowatts)", xlab=" " ,type = "l")
 
 ## send to png device
 
   png(filename = "plot2.png",width = 480, height = 480)
 ## with(DayInFeb,hist(Global_active_power,xlab="Global Active Power (Kilowatts)", ylab="Frequency", main = "Global Active Power", col="red" ))
   with(chardates,plot(x =newcolumndates, y =  Global_active_power, ylab="Global Active Power (Kilowatts)", xlab=" ", type="l" ))
   dev.off()
 
 
      
 
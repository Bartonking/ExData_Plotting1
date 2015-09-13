 
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
  
 
  
    
      
 ## send to png device
 
    png(filename = "plot4.png",width = 480, height = 480)
   ## create grid 2x2
    par(mfrow = c(2,2))
    # plot 1
    plot( x= chardates$newcolumndates,  y =chardates$Global_active_power,ylab="Global Active Power", xlab=" " ,type = "l")
    # plot 2
    plot( x= chardates$newcolumndates,  y =chardates$Voltage,ylab="Votage", xlab="datetime" ,type = "l")
    # plot 3
    plot( x= chardates$newcolumndates,  y =chardates$Sub_metering_1,ylab="Energy sub metering", xlab=" " ,type = "l" ,col="grey")
    lines( x= chardates$newcolumndates,  y =chardates$Sub_metering_2,  xlab=" " ,type = "l" ,col="red")
    lines( x= chardates$newcolumndates,  y =chardates$Sub_metering_3,  xlab=" " ,type = "l" ,col="blue")
    legend(x="topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("grey","blue","red"),lty=c(1,1,1))
    # plot 4
    plot( x= chardates$newcolumndates,  y =chardates$Global_reactive_power,ylab="Global Reactive Power", xlab="datetime" ,type = "l")  
    
    
    dev.off()
 
 
      
 
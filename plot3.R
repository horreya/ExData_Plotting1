#Load the necessary packages
library(lubridate)
library(graphics)
library(grDevices)

#Load the dataset into memory,  convert the date field into a date
#format, and select only the dates of interest. Then remove the original
#(very large!) dataset to free up memory
data<-read.table("household_power_consumption.txt",na.strings="?",sep=";",header=TRUE)
data<-within(data,DateTime<-paste(Date,Time))
data$DateTime<-parse_date_time(data$DateTime,"%d%m%y %H%M%S")
data$Date<-as.Date(data$DateTime,tz="UTC")
feb2007<-subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(data)

#Open PNG graphics device and generate appropriately labelled time series chart
png(file="plot3.png",bg="transparent",width=480,height=480,units="px")
with(feb2007,plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering",
                  xlab=""))
with(feb2007,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(feb2007,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",lwd=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
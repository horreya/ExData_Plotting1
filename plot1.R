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
feb2007<-subset(data, Date>= "2007-02-01" & Date<= "2007-02-02")
rm(data)

#Open PNG graphics device and generate appropriately labelled histogram
png(file="plot1.png",bg="transparent",width=480,height=480,units="px")
hist(feb2007$Global_active_power,main="Global Active Power",
     col="red",xlab="Global Active Power(kilowatts)")
dev.off()





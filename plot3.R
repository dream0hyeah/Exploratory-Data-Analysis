a<-read.table("household_power_consumption.txt",header=TRUE, sep=";", na.strings = "?", 
              colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
a$Date <- as.Date(a$Date, "%d/%m/%Y")
a <- subset(a,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
a <- a[complete.cases(a),]
library("dplyr")
b<-filter(a,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dateTime <- paste(b$Date, b$Time)
##dateTime <- setNames(dateTime, "DateTime")
t <- cbind(dateTime, b)
t$dateTime <- as.POSIXct(dateTime)

##Plot3
with(t, {
  plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
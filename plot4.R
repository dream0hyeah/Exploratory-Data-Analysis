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

##Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  ###bty=“n”不加边框，“o”为加边框
  legend("topright", col=c("black", "red", "blue"),lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
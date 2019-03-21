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

##Plot1
par(mfrow=c(1,1))
hist(t$Global_active_power,main="Global Active Power",xlab="Global Active Power(kilowatts)",col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

require(lubridate)
require(dplyr)

Sys.setlocale(category = "LC_ALL", locale = "english")
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=url, destfile = "power.zip")
unzip("power.zip")
power <- read.csv("household_power_consumption.txt", sep=";", dec = ".", na.strings = "?")
power$time <- as.POSIXct(dmy(power$Date) + hms(power$Time))
start <- as.numeric(ymd_hms("2007-02-1 00:00:00"))
end <- as.numeric(ymd_hms("2007-02-03 00:00:00"))
power_n <- filter(power, start<= as.numeric(time) & as.numeric(time) < end) %>% select(time, Global_active_power:Sub_metering_3)

png("plot4.png")

par(mfrow=c(2,2))

plot(power_n$time, power_n$Global_active_power, type = "n", xlab="", ylab="Global Active Power")
lines(power_n$time, power_n$Global_active_power)

plot(power_n$time, power_n$Voltage, type = "n", xlab="datetime", ylab="Voltage")
lines(power_n$time, power_n$Voltage)

plot(power_n$time, power_n$Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering")
lines(power_n$time, power_n$Sub_metering_1)
lines(power_n$time, power_n$Sub_metering_2, col="red")
lines(power_n$time, power_n$Sub_metering_3, col="blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"), bty = "n")

plot(power_n$time, power_n$Global_reactive_power, type = "n", xlab="datetime", ylab="Global_reactive_power")
lines(power_n$time, power_n$Global_reactive_power)
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red", "blue"))

dev.off()

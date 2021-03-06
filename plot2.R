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

png("plot2.png")
plot(power_n$time, power_n$Global_active_power, type = "n", xlab="", ylab="Global Active Power (kilowatts)")
lines(power_n$time, power_n$Global_active_power)
dev.off()
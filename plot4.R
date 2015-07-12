if (!require("dplyr")) {
  install.packages("dplyr")
}

library(dplyr)

# The function downloads the Samsung data and extracts it
download_data <- function () {
  zip.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' 
  zip.file <- 'dataset.zip'
  
  download.file(zip.url, destfile = zip.file, method = 'curl')
  unzip(zip.file)
}

#download_data()
data<-read.table("./ExData_Plotting1/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$DateD<-as.Date(data$Date, format="%d/%m/%Y")
data <- filter(data, DateD >= as.Date("2007-02-01"), DateD < as.Date("2007-02-03"))
data$DateTime<-strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
png(file = "./ExData_Plotting1/plot4.png", width=480, height=480, bg = "transparent")  
par(mfrow=c(2,2))
# plot 1
plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab="")
# plot 2
plot(data$DateTime, data$Voltage, type = "l", ylab = "Voltage", xlab="datetime")
# plot 3
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering", col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, lwd=1, bty = "n", cex=0.95)
# plot 4
plot(data$DateTime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")
dev.off()

library(data.table)
# Plot3

data <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(data)


## Format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")


## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
data <- data[complete.cases(data),]

## Converting dates
datetime <- paste(data$Date, data$Time)
data$Datetime <- as.POSIXct(datetime)

png("plot3.png", width=480, height=480)

## Generating Plot 3
## Generating Plot 3
with(data, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

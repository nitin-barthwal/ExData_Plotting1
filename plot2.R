library(data.table)
# Plot2

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

png("plot2.png", width=480, height=480)

## Generating Plot 2
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()

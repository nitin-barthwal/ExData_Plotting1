library(data.table)
# Plot1

data <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(data)


## Format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")


## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
data <- data[complete.cases(data),]


png("plot1.png", width=480, height=480)

## Create the histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()

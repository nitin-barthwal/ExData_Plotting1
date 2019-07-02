#Plot 1

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

aggTotals <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png", width=480, height=480)


## Generating Plot 1

  barplot(  aggTotals$Emissions/10^6 , 
         names.arg=aggTotals$year,
         xlab="Year",
         ylab="PM2.5 Emissions (10^6 Tons)",
         main="Total PM2.5 Emissions From All US Sources") 

dev.off()
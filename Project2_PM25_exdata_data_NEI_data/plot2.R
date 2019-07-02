#Plot 2

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips=="24510") from 1999 to 2008?

aggTotals <- aggregate(Emissions ~ year,NEI[NEI$fips=="24510",], sum)

png("plot2.png", width=480, height=480)


## Generating Plot 2

plot( aggTotals$year, aggTotals$Emissions/10^6 ,  type = "l",
      #    names.arg=aggTotals$year,
          xlab="Year",
          ylab="PM2.5 Emissions (10^6 Tons)",
          main="Total PM2.5 Emissions From Baltimore City") 

dev.off()

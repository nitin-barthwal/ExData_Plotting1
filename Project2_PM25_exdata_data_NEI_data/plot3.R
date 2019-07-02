#Plot 3
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.

aggTotals <- aggregate(Emissions ~ type + year,NEI[NEI$fips=="24510",], sum)

png("plot3.png", width=600, height=480)


## Generating Plot 3

qplot( year, Emissions/10^6 ,data= aggTotals,facets = .~type) + geom_line() +
ggtitle(expression("Total Baltimore " ~ PM[2.5] ~ "Emissions by Type and Year")) +
  ylab(expression("Total Baltimore " ~ PM[2.5] ~ "Emissions")) +
  xlab("Year") 
    

dev.off()

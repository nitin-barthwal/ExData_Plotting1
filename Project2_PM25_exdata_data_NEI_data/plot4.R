#Plot 4
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)


# Subset coal combustion related NEI data
combustionRelated <-  grepl('comb', SCC$SCC.Level.One
                            , ignore.case=TRUE)


coalRelated       <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, ]$SCC

combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

png("plot4.png")

ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity") +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()

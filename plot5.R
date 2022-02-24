library("data.table")
library("ggplot2")

# Load the NEI & SCC data frames.
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Extract motor vehicle emissions from the NEI data  
vehiclesSCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
                   , SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Extract motor vehicle emissions in Baltimore
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
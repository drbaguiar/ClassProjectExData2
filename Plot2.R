##Set working directory to data directory
setwd('C:/Users/bryan_000/Documents/GitHub/Data/')

if (!file.exists("summary_data.zip")) {
        zip.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
        zip.file <- 'summary_data.zip'
        download.file(zip.url, zip.file)
        unzip(zip.file)
}

if (!exists("NEI")){
        # Read files
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!exists("SCC")){
        # Read files
        SCC <- readRDS("Source_Classification_Code.rds")
}

BaltimoreCity <- subset(NEI, fips == "24510")

totalByYear <- tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)

png("plot02.png")
plot(names(totalByYear), totalByYear, type="l",
     xlab="Year", ylab=expression(PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
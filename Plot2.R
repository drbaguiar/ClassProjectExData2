if (!file.exists("dataset.zip")) {
        zip.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
        zip.file <- 'dataset.zip'
        download.file(zip.url, destfile = zip.file)
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

png("plot2.png")
plot(names(totalByYear), totalByYear, type="l",
     xlab="Year", ylab=expression(PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
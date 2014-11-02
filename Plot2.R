if (!file.exists("C:/Users/bryan_000/Documents/GitHub/Data/summary_data.zip")) {
        zip.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
        zip.file <- 'C:/Users/bryan_000/Documents/GitHub/Data/summary_data.zip'
        download.file(zip.url, destfile = zip.file)
        unzip(zip.file)
}

if (!exists("NEI")){
        # Read files
        NEI <- readRDS("C:/Users/bryan_000/Documents/GitHub/Data/summarySCC_PM25.rds")
}
if (!exists("SCC")){
        # Read files
        SCC <- readRDS("C:/Users/bryan_000/Documents/GitHub/Data/Source_Classification_Code.rds")
}

BaltimoreCity <- subset(NEI, fips == "24510")

totalByYear <- tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)

png("C:/Users/bryan_000/Documents/GitHub/Data/plot02.png")
plot(names(totalByYear), totalByYear, type="l",
     xlab="Year", ylab=expression(PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
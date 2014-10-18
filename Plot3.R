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
if (!require("plyr")){
      install.packages("plyr")  
}
if (!require("ggplot2")){
        install.packages("ggplot2")  
}

BaltimoreCity <- subset(NEI, fips == "24510")

typeByYear <- ddply(BaltimoreCity, .(year, type), function(x) sum(x$Emissions))
colnames(typeByYear)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=typeByYear, color=type, geom="line") +
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
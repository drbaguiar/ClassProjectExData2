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

coalSources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

coalPM25 <- NEI[NEI$SCC %in% coalSources$SCC,]

emissionsByYear <- ddply(coalPM25, "year", summarise, total = sum(Emissions))

png(filename="Plot4.png")
qplot(year, total, data=emissionsByYear, geom = "line") +
        ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
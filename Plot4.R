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

if (!require("plyr")){
        install.packages("plyr")  
}
if (!require("ggplot2")){
        install.packages("ggplot2")  
}

coalSources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

coalPM25 <- NEI[NEI$SCC %in% coalSources$SCC,]

emissionsByYear <- ddply(coalPM25, "year", summarise, total = sum(Emissions))

png(filename="C:/Users/bryan_000/Documents/GitHub/Data/Plot04.png")
qplot(year, total, data=emissionsByYear, geom = "line") +
        ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
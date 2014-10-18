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

subsetPM25 <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

motorSources <- SCC[grepl("*Vehicles", SCC$EI.Sector),]
motor <- subsetPM25[subsetPM25$SCC %in% motorSources$SCC,]

emissionsByYear <- ddply(motor, c("year", "fips"), summarise, total = sum(Emissions))

emissionsByYear$city <- ifelse(emissionsByYear$fips == "24510", "Baltimore", "Los Angeles")

png(filename="Plot6.png")
qplot(x      = year,
      xlab   = "Year",
      y      = total,
      ylab   = "Total Emissions",
      data   = emissionsByYear,
      color  = city,
      geom   = c("point", "smooth"),
      method = "loess")
dev.off()
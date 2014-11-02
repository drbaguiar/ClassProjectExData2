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

BaltimoreCity <- subset(NEI, fips == "24510" & type=="ON-ROAD")

BaltimoreByYear <- ddply(BaltimoreCity, .(year), function(x) sum(x$Emissions))
colnames(BaltimoreByYear)[2] <- "Emissions"

png("C:/Users/bryan_000/Documents/GitHub/Data/plot05.png")
qplot(year, Emissions, data=BaltimoreByYear, geom="line") +
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
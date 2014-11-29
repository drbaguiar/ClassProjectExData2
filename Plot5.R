source('C:/Users/bryan_000/Documents/GitHub/MyWork/StdOpen.R')
call("plyr")  
call("ggplot2")  

##Set destination file for download 
datafile1 <-paste(datadir,"summarySCC_PM25.rds",sep = "")
datafile2 <-paste(datadir,"Source_Classification_Code.rds",sep = "")
zip.file <-paste(datadir,"summary_data.zip",sep = "")

if (!file.exists(datafile1)) {
        zip.url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
        download.file(zip.url, zip.file)
        unzip(zip.file)
}

if (!exists("NEI")){
        # Read files
        NEI <- readRDS(datafile1)
}
if (!exists("SCC")){
        # Read files
        SCC <- readRDS(datafile2)
}

BaltimoreCity <- subset(NEI, fips == "24510" & type=="ON-ROAD")

BaltimoreByYear <- ddply(BaltimoreCity, .(year), function(x) sum(x$Emissions))
colnames(BaltimoreByYear)[2] <- "Emissions"

## write output to .png file
plot.file <-paste(datadir,"plot05.png",sep = "")
png(filename = plot.file, width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

qplot(year, Emissions, data=BaltimoreByYear, geom="line") +
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
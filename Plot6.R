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

subsetPM25 <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

motorSources <- SCC[grepl("*Vehicles", SCC$EI.Sector),]
motor <- subsetPM25[subsetPM25$SCC %in% motorSources$SCC,]

emissionsByYear <- ddply(motor, c("year", "fips"), summarise, total = sum(Emissions))

emissionsByYear$city <- ifelse(emissionsByYear$fips == "24510", "Baltimore", "Los Angeles")

## write output to .png file
plot.file <-paste(datadir,"plot06.png",sep = "")
png(filename = plot.file, width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

qplot(x=year,xlab= "Year",y= total,ylab   = "Total Emissions",data   = emissionsByYear,color  = city,geom   = c("point", "smooth"),method = "loess")
dev.off()
##Use my standard openning including call function
source('C:/Users/bryan_000/Documents/GitHub/MyWork/StdOpen.R')

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

totalByYear <- tapply(NEI$Emissions, NEI$year, sum)

## write output to .png file
plot.file <-paste(datadir,"plot01.png",sep = "")
png(filename = plot.file, width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

plot(names(totalByYear), totalByYear/1000, type="l",
     xlab="Year", ylab=expression(PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
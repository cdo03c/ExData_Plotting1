library(lubridate)

## This section retrieves and unpacks the zip file containing the data.
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/exdata_data_household_power_consumption.zip")){download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/exdata_data_household_power_consumption.zip")}
unzip(zipfile = "./data/exdata_data_household_power_consumption.zip", exdir = "./data")

##This section ingests the portion of the household power consumption data for 1 to 2 Jan 2007
##and converts the first column to Dates and the second column to a Time format.
pwconsump <- read.table(file = "./data/household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2880)
pwconsump$V1 <- as.Date(pwconsump$V1, format = "%d/%m/%Y")
pwconsump$V2 <- strptime(pwconsump$V2, format = "%H:%M:%S")
month(pwconsump$V2) <- month(pwconsump$V1)
day(pwconsump$V2) <- day(pwconsump$V1)
year(pwconsump$V2) <- year(pwconsump$V1)
pwconsump$v2 <- format(pwconsump$V2, format="%m %a %Y")

## This section produces and saves a line plot of the Global_active_power variable as a png.
png(filename = "plot2.png")
with (pwconsump, plot(pwconsump$V2, pwconsump$V3, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()

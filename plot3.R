## Plot3.R
##
## Description
##   Creates Plot #3 for programming assignment 1 for the Exploratory Data Analysis course
##   Data file used is the  “Individual household electric power consumption Data Set” 
##   from the UC Irvine Machine Learning Repository.
##
## Usage: MakePlot3(<DATA_FILE_TO_READ>[,<PNG_FILE_TO_WRITE>])
##
## Submitted in partial fulfilment of the Coursera Exploratory Data Analysis course (Jan. 2015) for hsub

# MakePlot3(x) - Reads a data set and writes plot 3 to a PNG file
# Parameters:
#     srcFilespec - Full path and filename of the data file to be loaded
#     destFilespec - Full path and filename to which the plot is to be written (PNG format)
#                    Defaults to "./plot3.png" if not specified.
MakePlot3 <- function(srcFilespec, destFilespec = ".\\plot3.png") {
  data <- LoadData(srcFilespec)
  
  png(file = destFilespec)
  
  plot(data$Timestamp, data$Sub_metering_1, type = "n", 
       xlab = "", ylab = "Energy sub metering")
  lines(data$Timestamp, data$Sub_metering_1, type = "l", col = "black")
  lines(data$Timestamp, data$Sub_metering_2, type = "l", col = "red")
  lines(data$Timestamp, data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lwd = 1,
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  dev.off()
}

# LoadData(x) - Helper function used to parse and preprocess the data file in preparation for plotting
# Parameters:
#     filespec - Full path and filename of the data file to be loaded
# Returns: Properly parsed and subsetted table containing the data to be used for the plot
LoadData <- function(filespec) {
  colTypes = c(rep("character", 2), rep("double", 7))
  rawData <- read.table(filespec, header = TRUE, sep = ";", na.strings = c("?"), colClasses = colTypes)
  
  subsetData <- rawData[rawData$Date == "1/2/2007" | rawData$Date == "2/2/2007",]
  Timestamp <- strptime(paste(subsetData$Date, subsetData$Time), "%d/%m/%Y %H:%M:%S")
  
  data <- cbind(Timestamp, subset(subsetData, select = -c(Date, Time)))
  data
}
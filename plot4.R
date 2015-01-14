## Plot4.R
##
## Description
##   Creates Plot #4 for programming assignment 1 for the Exploratory Data Analysis course
##   Data file used is the  “Individual household electric power consumption Data Set” 
##   from the UC Irvine Machine Learning Repository.
##
## Usage: MakePlot4(<DATA_FILE_TO_READ>[,<PNG_FILE_TO_WRITE>])
##
## Submitted in partial fulfilment of the Coursera Exploratory Data Analysis course (Jan. 2015) for hsub

# MakePlot4(x) - Reads a data set and writes plot 4 to a PNG file
# Parameters:
#     srcFilespec - Full path and filename of the data file to be loaded
#     destFilespec - Full path and filename to which the plot is to be written (PNG format)
#                    Defaults to "./plot4.png" if not specified.
MakePlot4 <- function(srcFilespec, destFilespec = ".\\plot4.png") {
  data <- LoadData(srcFilespec)

  png(file = destFilespec)  
  
  par(mfrow = c(2, 2))
  
  plot(data$Timestamp, data$Global_active_power, type = "n", 
       xlab = "", ylab = "Global Active Power")
  lines(data$Timestamp, data$Global_active_power, type = "l")
  
  plot(data$Timestamp, data$Voltage, type = "n", 
       xlab = "datetime", ylab = "Voltage")
  lines(data$Timestamp, data$Voltage, type = "l")
  
  plot(data$Timestamp, data$Sub_metering_1, type = "n", 
       xlab = "", ylab = "Energy sub metering")
  lines(data$Timestamp, data$Sub_metering_1, type = "l", col = "black")
  lines(data$Timestamp, data$Sub_metering_2, type = "l", col = "red")
  lines(data$Timestamp, data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lwd = 1, bty = "n",
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$Timestamp, data$Global_reactive_power, type = "n", 
       xlab = "datetime", ylab = "Global_reactive_power")
  lines(data$Timestamp, data$Global_reactive_power, type = "l")
  
  dev.off()
  
  par(mfrow = c(1, 1))  # Reset to default
}

# LoadData(x) - Helper function used to parse and preprocess the data file in preparation for plotting
# Parameters:
#     filespec - Full path and filename of the data file to be loaded
# Returns: Properly parsed and subsetted table containing the data to be used for the plot
LoadData <- function(filespec) {
  colTypes = c(rep("character", 2), rep("double", 7))
  rawData <- read.table(filespec, header = TRUE, sep = ";", na.strings = c("?"), colClasses = colTypes)
  
  subsetData <- rawData[rawData$Date == "1/2/2007" | rawData$Date == "2/2/2007",]
  rm(rawData)
  Timestamp <- strptime(paste(subsetData$Date, subsetData$Time), "%d/%m/%Y %H:%M:%S")
  
  data <- cbind(Timestamp, subset(subsetData, select = -c(Date, Time)))
  data
}

#
# Load, clean an plot global active power as histogram in file called plot1.png
# data is supposed to be in a file called "household_power_consumption.txt" in current directory
# Please note that it uses library dplyr


# load and clean data from file
loadAndCleanData <- function(filename = "household_power_consumption.txt"){
    library(dplyr)
    # loading raw data with only numeric conversions. and where NAs are coded as questionmark.
    rawdata <- read.csv2(filename, na.strings="?", stringsAsFactors = FALSE, dec = ".")
    ## filtering only on two first days of February 2007
    dateFilter = c("1/2/2007","2/2/2007")
    data <- filter(rawdata, Date %in% dateFilter)
    
    ## format date and time
    formattedData <- mutate(data, Date = as.Date(Date), Time = as.POSIXct(strptime(Time, "%T")))
    formattedData
}

#plot data as an histogram in current graphice device.
plotToCurrentDevice <- function(data){
    hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main ="Global Active Power")
}

#open a png device
png("plot1.png", width=480, height=480)
#plots
plotToCurrentDevice(loadAndCleanData())
#close file
dev.off()






    
    



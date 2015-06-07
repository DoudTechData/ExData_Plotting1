#
# Load, clean an plot energy sub metering over time in file called plot3.png
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
    formattedData <- mutate(data, datetime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))
    formattedData
}

#plot data as a plot over time in current graphice device.
plotToCurrentDevice <- function(data){
    plot(data$datetime,data$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
    points(data$datetime,data$Sub_metering_2, type="l", col="red")
    points(data$datetime,data$Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, col = c("black", "blue", "red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}

#--  save the locale (we need to switch to US) ----
backkup_locale <- Sys.getlocale('LC_TIME')
Sys.setlocale('LC_TIME', 'C')


#open a png device
png("plot3.png", width=480, height=480)
#plots
plotToCurrentDevice(loadAndCleanData())
#close file
dev.off()



#---------  restore changes of locale -------------------   
Sys.setlocale('LC_TIME', backkup_locale)










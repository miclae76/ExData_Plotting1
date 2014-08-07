## EDA Course Project 1 - plot4

## Cleanup workspace and 
rm(list=ls())

## Read data sample to get class makes load approx. twice quicker
zipfile = "data.zip"
file = "household_power_consumption.txt"
data_sample <- read.table(unz(zipfile, file), header = TRUE, nrows = 5, sep=";")
classes <- sapply(data_sample, class)
data_full <- read.table(unz(zipfile, file), 
                        header = TRUE, 
                        sep =";",
                        colClasses = classes,
                        na.strings = "?")


## Get subset for the requested data
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
data$Datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
rm(data_full)

## Open device
png(filename = "plot4.png", width = 480, height = 480, units = 'px')

## Plot 4 charts 2x2
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Datetime, Global_active_power, 
             type = "l",
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        
        plot(Datetime, Voltage, 
             type = "l",
             ylab = "Voltage (volt)")
        
        plot(Datetime, Sub_metering_1, 
             type ="l", 
             xlab = "",
             ylab ="Global Active Power (kilowatts)")
        lines(Datetime, Sub_metering_2, col='Red')
        lines(Datetime, Sub_metering_3, col='Blue')
        legend("topright", 
               col = c("black", "red", "blue"), 
               lty = 1, 
               lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Datetime, Global_reactive_power, 
             type = "l",
             ylab = "Global Reactive Power (kilowatts)")
        })

## Close device
dev.off()
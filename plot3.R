## EDA Course Project 1 - plot3 

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
rm(data_full)

## Open device
png(filename = "plot3.png", width = 480, height = 480, units = 'px')

## Plot Linechart 
data$Datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
with(data, {
        plot(Datetime , Sub_metering_1, 
             type = "l",
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        lines(Datetime, Sub_metering_2, col='Red')
        lines(Datetime, Sub_metering_3, col='Blue')
})
legend("topright", 
       col = c("black", "red", "blue"), 
       lty = 1, 
       lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close device
dev.off()
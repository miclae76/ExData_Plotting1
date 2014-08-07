## EDA Course Project 1 - plot1 

## Cleanup workspace
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
# Drop full dataset to free memory
rm(data_full)

## Open device
png(filename = "plot1.png", width = 480, height = 480, units = 'px')

## Plot 1 bar chart
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col  = "Red"
     )

## Close device
dev.off()


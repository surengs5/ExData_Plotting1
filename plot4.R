library(data.table)              #package with useful file handling functions
## Using setwd setup the working directory and keep a copy of datafile in the working directory
## reading all colClasses as character to prevent the warnings from fread
## enhancement to do later, replace fread with read.csv.sql to subset the 2 days data during the read itself
pwr_dataset_df <- fread("household_power_consumption.txt", sep="auto", header="auto", data.table=TRUE, colClasses="character")

## Extract the subset of data for the first two days in Feb month and coerce the data types
pwr_df <- data.frame(subset(pwr_dataset_df[pwr_dataset_df$Date == "1/2/2007" | pwr_dataset_df$Date == "2/2/2007"]))
pwr_df$Global_active_power <- as.numeric(pwr_df$Global_active_power)
pwr_df$Global_reactive_power <- as.numeric(pwr_df$Global_reactive_power)
pwr_df$Voltage <- as.numeric(pwr_df$Voltage)
pwr_df$Sub_metering_1 <- as.numeric(pwr_df$Sub_metering_1)
pwr_df$Sub_metering_2 <- as.numeric(pwr_df$Sub_metering_2)
pwr_df$Sub_metering_3 <- as.numeric(pwr_df$Sub_metering_3)

## Create an extra POSIXlt variable with date and time components combined
pwr_df$DateTime <- strptime(paste(pwr_df$Date, pwr_df$Time), "%d/%m/%Y %H:%M:%S")

## Start with an empty graph values with no main title and x, y axis defined
## Add data points with colors and setup legend of colored content
## Create plot4 on screen device, copy it as a plot4 ping file and close device
par(mfrow = c(2, 2))
## Plot graph 1
with(pwr_df, plot(pwr_df$DateTime, pwr_df$Global_active_power, type="l", main=" ", ylab="Global Active Power", xlab=""))

## Plot graph 2
with(pwr_df, plot(pwr_df$DateTime, pwr_df$Voltage, type="l", main=" ", ylab="Voltage", xlab="datetime"))

## Adjust the top and bottom margins for the lower two plots to get the right scale level into png file
par(mar=c(4.1,4.1,2.1,2.1))

## Plot graph 3
with(pwr_df, plot(pwr_df$DateTime, pwr_df$Sub_metering_1, main="", type="l", col="black", lwd=3, ylab="Energy sub metering", xlab=""))
lines(pwr_df$DateTime, pwr_df$Sub_metering_2, type="l", col="red", lwd=2)
lines(pwr_df$DateTime, pwr_df$Sub_metering_3, type="l", col="blue", lwd=2)
legend("topright", bty="n", lty=1, cex=.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot graph 4
with(pwr_df, plot(pwr_df$DateTime, pwr_df$Global_reactive_power, type="l", main=" ", xlab="datetime", ylab="Global_reactive_power"))

dev.copy(png, file = "plot4.png", width = 480, height = 480, restoreConsole = TRUE)
dev.off()
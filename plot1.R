library(data.table)              #package with useful file handling functions
## Using setwd setup the working directory and copy datafile to the working directory
pwr_dataset_df <- fread("household_power_consumption.txt", sep="auto", header="auto", data.table=TRUE, colClasses=c("date", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## Extract the subset of data for the first two days in Feb month and coerce the data types
pwr_df <- subset(pwr_dataset_df[pwr_dataset_df$Date == "2/1/2007" | pwr_dataset_df$Date == "2/2/2007"])
pwr_df$Date <- as.Date(pwr_df$Date)
pwr_df$Global_active_power <- as.numeric(pwr_df$Global_active_power)
pwr_df$Global_reactive_power <- as.numeric(pwr_df$Global_reactive_power)
pwr_df$Voltage <- as.numeric(pwr_df$Voltage)
pwr_df$Global_intensity <- as.numeric(pwr_df$Global_intensity)
pwr_df$Sub_metering_1 <- as.numeric(pwr_df$Sub_metering_1)
pwr_df$Sub_metering_2 <- as.numeric(pwr_df$Sub_metering_2)
pwr_df$Sub_metering_3 <- as.numeric(pwr_df$Sub_metering_3)

## Create plot1 on screen device, copy it as a plot1 ping file and close device
with(pwr_df, hist(pwr_df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png")
dev.off()

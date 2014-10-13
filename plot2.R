library(data.table)              #package with useful file handling functions
## Using setwd setup the working directory and keep a copy of datafile in the working directory
## reading all colClasses as character to prevent the warnings from fread
## enhancement to do later, replace fread with read.csv.sql to subset the 2 days data during the read itself
pwr_dataset_df <- fread("household_power_consumption.txt", sep="auto", header="auto", data.table=TRUE, colClasses="character")

## Extract the subset of data for the first two days in Feb month and coerce the data types
pwr_df <- data.frame(subset(pwr_dataset_df[pwr_dataset_df$Date == "1/2/2007" | pwr_dataset_df$Date == "2/2/2007"]))
pwr_df$Global_active_power <- as.numeric(pwr_df$Global_active_power)

## Create an extra POSIXlt variable with date and time components combined
pwr_df$DateTime <- strptime(paste(pwr_df$Date, pwr_df$Time), "%d/%m/%Y %H:%M:%S")

## Create plot2 on screen device, copy it as a plot2 ping file and close device
with(pwr_df, plot(pwr_df$DateTime, pwr_df$Global_active_power, type="l", main=" ", ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file = "plot2.png")
dev.off()
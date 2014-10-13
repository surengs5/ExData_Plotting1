library(data.table)              #package with useful file handling functions
## Using setwd setup the working directory and as preparation keep a copy of datafile in the working directory
pwr_dataset_df <- fread("household_power_consumption.txt", sep="auto", header="auto", data.table=TRUE, colClasses="character")

## Extract the subset of data for the first two days in Feb month and coerce the data types
pwr_df <- subset(pwr_dataset_df[pwr_dataset_df$Date == "1/2/2007" | pwr_dataset_df$Date == "2/2/2007"])
pwr_df$Global_active_power <- as.numeric(pwr_df$Global_active_power)

## Create plot1 on screen device, copy it as a plot1 ping file and close device
with(pwr_df, hist(pwr_df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png")
dev.off()

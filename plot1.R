# first, set the corect working directory and then copy the unzipped from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip file into this directory, then follow the below steps.

# load dplyr package
        library(dplyr) 

# get data
        dat <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))

# create truncated dataset by subsetting specified dates
        data <- filter(dat, Date == "1/2/2007" | Date == "2/2/2007")

# remove dat from environment to free up RAM
        rm(dat)
        
# convert date and time to proper formats
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        data$timetemp <- paste(data$Date, data$Time)
        data$Time <- strptime(data$timetemp, format = "%Y-%m-%d %H:%M:%S")

# create histogram of global active power
        png(file = "plot1.png", width = 480, height = 480)
        hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
        dev.off()


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

# create panel of graphs
        png(file = "plot4.png", width = 480, height = 480)
        par(mfrow = c(2, 2))
        with(data, {
                plot(x = data$Time, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
                plot(x = data$Time, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
                plot(x = data$Time, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
                lines(x = data$Time, y = data$Sub_metering_2, type = "l", col = "red")
                lines(x = data$Time, y = data$Sub_metering_3, type = "l", col = "blue")
                legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                plot(x = data$Time, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
        })
        dev.off()


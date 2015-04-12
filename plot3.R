## Plot scripts
# Check for existence of file in users' current working directory
if(!file.exists("./household_power_consumption.txt")) {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl"); unzip("./household_power_consumption.zip")}

plot3 <- function() {
    require(data.table)
    hpc <- read.csv("./household_power_consumption.txt", sep=";", na.strings = "?")
    # Subset just the dates 2007-02-01 and 2007-02-01
    hpcsub <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")
    # Fix Date / Time Variables, creating new variable DateTime on the DF
    hpcsub$DateTime <- strptime(paste(hpcsub$Date, hpcsub$Time), "%d/%m/%Y %H:%M:%S")
    # Open png file for graphics device in current wd
    png(file = "plot3.png", width = 480, height = 480)
    # Create empty plot with size, labels, using the range of the Sub metering variables to set the y axis limits.
    lim <- range(hpcsub$Sub_metering_1, hpcsub$Sub_metering_2, hpcsub$Sub_metering_3, na.rm = TRUE)
    with(hpcsub, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = lim, type = "n"))
    # Add the lines for the Sub meters (note a curiosity that Sub_metering_1 for this range is all zeroes)
    with(hpcsub, lines(DateTime, Sub_metering_1))
    with(hpcsub, lines(DateTime, Sub_metering_2, col = "red"))
    with(hpcsub, lines(DateTime, Sub_metering_3, col = "blue"))
    # Add the legend in the top right corner
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c("black", "red", "blue"))
    # Close the device
    dev.off()
    
}

## Plot scripts
# Check for existence of file in users' current working directory
if(!file.exists("./household_power_consumption.txt")) {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip", method = "curl"); unzip("./household_power_consumption.zip")}

plot1 <- function() {
    require(data.table)
    hpc <- read.csv("./household_power_consumption.txt", sep=";", na.strings = "?")
    # Subset just the dates 2007-02-01 and 2007-02-01
    hpcsub <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")
    # Fix Date / Time Variables, creating new variable DateTime on the DF
    hpcsub$DateTime <- strptime(paste(hpcsub$Date, hpcsub$Time), "%d/%m/%Y %H:%M:%S")
    # Open png file for graphics device in current wd
    png(file = "plot1.png", width = 480, height = 480)
    # Create plot with size, labels, color
    with(hpcsub, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
    # Close device
    dev.off()
}

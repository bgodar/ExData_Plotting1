# Read in data and subset only 2007-02-01 and 2007-02-02

pow <- read.table("household_power_consumption.txt", header = TRUE,
                  sep = ";", na.strings = "?",
                  stringsAsFactors = FALSE)
pow$Date <- as.Date(pow$Date, "%d/%m/%Y")
powr <- subset(pow, Date == "2007-02-01" | Date == "2007-02-02")
rm("pow")

# Create new column with date and time
library(dplyr)
powr <- mutate(powr, FullTime = paste(Date, Time))
powr$FullTime <- strptime(powr$FullTime, "%Y-%m-%d %H:%M:%S")

# Open PNG graphic device
png(filename = "plot4.png")

# Make plot

par(mfrow = c(2,2), cex = 0.7)
# Plot 1
with(powr, plot(FullTime, Global_active_power, 
                ylab = "Global Active Power", 
                xlab = "", type = "l"))
# Plot 2
with(powr, plot(FullTime, Voltage, ylab = "Voltage", 
                xlab = "datetime", type = "l"))
# Plot 3 (need to add/figure out legend)
with(powr, plot(FullTime, Sub_metering_1, type = "n", 
                ylab = "Energy sub metering", xlab = ""))
lines(powr$FullTime, powr$Sub_metering_1)
lines(powr$FullTime, powr$Sub_metering_2, col = "red")
lines(powr$FullTime, powr$Sub_metering_3, col = "blue")
legend("topright",  c("Sub_metering_1", "Sub_metering_2",
                      "Sub_metering_3"), col = c("black", 
                      "red", "blue"), lty= 1, bty = "n")
# Plot 4
with(powr, plot(FullTime, Global_reactive_power, 
                ylab = "Global_reactive_power", 
                xlab = "datetime", type = "l"))

# Close PNG file device
dev.off()

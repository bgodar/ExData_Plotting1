# Read in data and subset only 2007-02-01 and 2007-02-02

pow <- read.table("household_power_consumption.txt", header = TRUE,
                  sep = ";", na.strings = "?",
                  stringsAsFactors = FALSE)
pow$Date <- as.Date(pow$Date, "%d/%m/%Y")
powr <- subset(pow, Date == "2007-02-01" | Date == "2007-02-02")
rm("pow")

# Open PNG graphics device
png(filename = "plot1.png")

# Create Plot 1
hist(powr$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Close PNG file device
dev.off()
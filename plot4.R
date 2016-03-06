# Read in data
pathToData <- "./household_power_consumption.txt"
data <- read.table(pathToData, header=TRUE, stringsAsFactors=FALSE, sep=";", 
                   dec=".")

# Convert dates into proper dates
data$Date <- strptime(data$Date,format="%d/%m/%Y")

# Subset data to date range inclusively between 1/2/2007 and 2/2/2007
subsetdata <- subset(data, data$Date >= strptime("01/02/2007", format="%d/%m/%Y") 
                     & testdata$Date <= strptime("02/02/2007", format="%d/%m/%Y"))

# Make columns as numerics
subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)
subsetdata$Sub_metering_1 <- as.numeric(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_2 <- as.numeric(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_3 <- as.numeric(subsetdata$Sub_metering_3)
subsetdata$Voltage <- as.numeric(subsetdata$Voltage)
subsetdata$Global_reactive_power <- as.numeric(subsetdata$Global_reactive_power)

# Get combined date+time vector to be used for x axis in plot
datetime <- strptime(paste(testsubsetdata$Date, testsubsetdata$Time, sep=" "), 
                     "%Y-%m-%d %H:%M:%S")

png("plot4.png", width=480, height=480)

# Set parameters - 2x2 output of plots
par(mfrow = c(2,2))

# Plot first plot - Global Active Power
plot(datetime, subsetdata$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

# Plot second plot - Voltage
plot(datetime, subsetdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot third plot - Energy Sub Metering
plot(datetime, subsetdata$Sub_metering_1, type="l", ylab="Energy sub metering", 
     xlab="", col="black")
lines(datetime, subsetdata$Sub_metering_2, type="l", col="red")
lines(datetime, subsetdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=3, col=c("black", "red", "blue"), bty="n", cex=0.9)

#Plot fourth plot - Global Reactive Power
plot(datetime, subsetdata$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()
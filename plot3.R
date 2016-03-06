# Read in data
pathToData <- "./household_power_consumption.txt"
data <- read.table(pathToData, header=TRUE, stringsAsFactors=FALSE, sep=";", 
                   dec=".")

# Convert dates into proper dates
data$Date <- strptime(data$Date,format="%d/%m/%Y")

# Subset data to date range inclusively between 1/2/2007 and 2/2/2007
subsetdata <- subset(data, data$Date >= strptime("01/02/2007", format="%d/%m/%Y") 
                     & testdata$Date <= strptime("02/02/2007", format="%d/%m/%Y"))

# Make Global_active_power and sub_metering_X columns as numerics
subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)
subsetdata$Sub_metering_1 <- as.numeric(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_2 <- as.numeric(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_3 <- as.numeric(subsetdata$Sub_metering_3)

# Get combined date+time vector to be used for x axis in plot
datetime <- strptime(paste(testsubsetdata$Date, testsubsetdata$Time, sep=" "), 
                     "%Y-%m-%d %H:%M:%S")

# Plot x-y plot and output to png
png("plot3.png", width=480, height=480)
plot(datetime, subsetdata$Sub_metering_1, type="l", ylab="Energy sub metering", 
     xlab="", col="black")
lines(datetime, subsetdata$Sub_metering_2, type="l", col="red")
lines(datetime, subsetdata$Sub_metering_3, type="l", col="blue")

# Add legend to plot
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=3, col=c("black", "red", "blue"), cex=0.9)

dev.off()
# Read in data
pathToData <- "./household_power_consumption.txt"
data <- read.table(pathToData, header=TRUE, stringsAsFactors=FALSE, sep=";", 
                   dec=".")

# Convert dates into proper dates
data$Date <- strptime(data$Date,format="%d/%m/%Y")

# Subset data to date range inclusively between 1/2/2007 and 2/2/2007
subsetdata <- subset(data, data$Date >= strptime("01/02/2007", format="%d/%m/%Y") 
                     & testdata$Date <= strptime("02/02/2007", format="%d/%m/%Y"))

# Make Global_active_power column a numeric
subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)

# Get combined date+time vector to be used for x axis in plot
datetime <- strptime(paste(testsubsetdata$Date, testsubsetdata$Time, sep=" "), 
                     "%Y-%m-%d %H:%M:%S")

# Plot x-y plot and output to png
png("plot2.png", width=480, height=480)
plot(datetime, subsetdata$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()
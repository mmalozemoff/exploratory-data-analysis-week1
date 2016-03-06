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

# Plot histogram and output to PNG
png("plot1.png", width=480, height=480)
hist(subsetdata$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

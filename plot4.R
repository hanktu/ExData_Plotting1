## Read electric power consumption data
# Read a few rows to get the right column headers
dataPreview <- read.csv("exdata-data-household_power_consumption/household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?",
                        nrows = 5)
headers <- names(dataPreview)
# Read only a subset of the file to obtain data for 2007-02-01 and 2007-02-02
data <- read.csv("exdata-data-household_power_consumption/household_power_consumption.txt", 
                 header = TRUE, 
                 sep = ";",
                 na.strings = "?",
                 col.names = headers,
                 skip = 66636,
                 nrows = 2880)

# Convert the "Date" column to Date class.
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# Create a new column that merges date and time
data$Date_Time <- strptime(paste(data$Date, data$Time), format = "%F %T")


## Plot histogram
png(filename = "plot4.png",
    width = 480,
    height = 480)

par(mfrow=c(2,2))

# Create first plot
plot(data$Date_Time, data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Create second plot
plot(data$Date_Time, data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Create third plot
plot(data$Date_Time, data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
points(data$Date_Time, data$Sub_metering_2,
       type = "l",
       col = "red")
points(data$Date_Time, data$Sub_metering_3,
       type = "l",
       col = "blue")
legend("topright", 
       bty = "n",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))

# Create fourth plot
plot(data$Date_Time, data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
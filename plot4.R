#load the data file into R and then make it into a tbl_df for ease of use with dplyr
household_power_consumption <- read.csv("~/household_power_consumption.txt", sep=";", na.strings="?")
dataall <- household_power_consumption

#specify to R that the Date and Time variables are what they are
dataall$Date <- as.Date(dataall$Date, format="%d/%m/%Y")

#create a new df with only the dates of interest to work with
datasmall <- subset(dataall, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#join date and time and specify to R that Time variable is what it is
Time <- paste(as.Date(datasmall$Date), datasmall$Time)
data$Time <- as.POSIXct(Time)

#Check my code to make sure Date and Time are registered as such
str(datasmall$Date)
str(datasmall$Time)


#tidy up global environment
rm(dataall)
data<-datasmall
rm(datasmall)

#create mega plot
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma=c(0,0,2,0))
plot(data$Time, data$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(data$Time, data$Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
with(data, {
  plot(Sub_metering_1~Time, type="l", ylab="Energy sub metering", xlab = "")
  lines(Sub_metering_2~Time, col = "red")
  lines(Sub_metering_3~Time, col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, bty = "n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data$Time, data$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")



#save plot to a png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
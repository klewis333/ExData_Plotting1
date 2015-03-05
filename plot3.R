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

#create plot of Energy sub metering by Sub_Metering type with a legend
with(data, {
  plot(Sub_metering_1~Time, type="l", ylab="Energy sub metering", xlab = "")
  lines(Sub_metering_2~Time, col = "red")
  lines(Sub_metering_3~Time, col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#save plot to a png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
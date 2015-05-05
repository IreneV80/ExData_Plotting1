# Creating a new folder in the working directory if the folder does not yet exists
if (!file.exists("CourseProject1")) {
        dir.create ("CourseProject1")
}

# Downloading the data and unzipping the data
fileURL<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./CourseProject1/exdata_data_household_power_consumption.zip") 
file<-unzip("./CourseProject1/exdata_data_household_power_consumption.zip", exdir="./CourseProject1/unzipped")

# Read the data into R
data<-read.table(file, header=TRUE, sep=";", na.strings="?")

#change the class of the Date variable to Date
data[, 'Date'] <- as.Date(data[, 'Date'], format="%d/%m/%Y")

#select the data from 2007-02-01 and 2007-02-02
data2<- data[data$Date >= '2007-02-01' & data$Date <= '2007-02-02', ]

#Creating a new variable that combines the date and time variables
data2$datetime<-paste(data2$Date, data2$Time)
#Changing the class of the new datetime variable to POSIXlt POSIXt
data2[["datetime"]] <- strptime(data2[["datetime"]], format="%Y-%m-%d %H:%M:%S")

#plot4
# change the system settings so the days of the week will be in English instead of Dutch
Sys.setlocale("LC_ALL","C")

####opening an empty png file in the working directory with the default height & width of 480x480 (this graph changes too much if I copy the graph from the screen to png afterwards)
png(file ="plot4.png")  

##creating a plot with space for 4 different charts (2 by 2) and setting the margins
par(mfrow=c(2,2),mar = c(4,4,2,1))
with(data2, {
        ##1st plot top left:recreating plot 1, but with a different label of the y-axis
        plot(data2$datetime,data2$Global_active_power,type="l",xlab="", ylab= "Global Active Power") 
        ##2nd plot top right: creating a new plot, comparable to plot 1, but with Voltage on the y-axis
        plot(data2$datetime,data2$Voltage,type="l",xlab="datetime", ylab= "Voltage")
        ##3rd plot bottom left: recreating plot 3, but without a border around the legend
        plot(data2$datetime,data2$Sub_metering_1,type="l",ylim=c(0,38), xlab="", ylab= "Energy sub metering")     
        par(new=TRUE)
        plot(data2$datetime,data2$Sub_metering_2,type="l",col="red",ylim=c(0,38), xlab="", ylab= "Energy sub metering")
        par(new=TRUE)
        plot(data2$datetime,data2$Sub_metering_3,type="l",col="blue",ylim=c(0,38), xlab="", ylab= "Energy sub metering")
        legend("topright",names(data2)[7:9], col=c("black","red","blue"),lty=1,cex=1,bty="n")
        par(new=FALSE)
        ##4th plot bottom right:creating a new plot, comparable to plot 1, but with Global reactive Power on the y-axis
        plot(data2$datetime,data2$Global_reactive_power,type="l",ylim=c(0,0.5),xlab="datetime", ylab= "Global_reactive_power")
})

# N.B.: Although the original plots have a transparent background, I decided to leave it white. This based
# on a thread on the discussion forum that the graph will be better visible without a checkerboard
# in the background to indicate transparency.

#close the png device
dev.off()

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

#plot3
# change the system settings so the days of the week will be in English instead of Dutch
Sys.setlocale("LC_ALL","C")

##opening an empty png file in the working directory with the default height & width of 480x480
png(file ="plot3.png") 

#create a line chart with only the data of Sub_metering_1, 
#removing the label of the X-axis and changing the label of the Y-axis and changing the limit of the Y-Axis
#changing the size of the axis title and labels
plot(data2$datetime,data2$Sub_metering_1,type="l",ylim=c(0,38), xlab="", ylab= "Energy sub metering",cex.axis=0.9,cex.lab=0.9)
#use par(new=TRUE) to indicate that the 2nd plot has to be created in the previous plot and add a line in red for Sub_metering_2
par(new=TRUE)
plot(data2$datetime,data2$Sub_metering_2,type="l",col="red",ylim=c(0,38), xlab="", ylab= "Energy sub metering",cex.axis=0.9,cex.lab=0.9)
#use par(new=TRUE) to indicate that the 3rd plot has to be created in the previous plot and add a line in blue for Sub_metering_3
par(new=TRUE)
plot(data2$datetime,data2$Sub_metering_3,type="l",col="blue",ylim=c(0,38), xlab="", ylab= "Energy sub metering",cex.axis=0.9,cex.lab=0.9)
#add a legend to the graph
legend("topright",names(data2)[7:9], col=c("black","red","blue"),lty=1,cex=0.9)

# N.B.: Although the original plots have a transparent background, I decided to leave it white. This based
# on a thread on the discussion forum that the graph will be better visible without a checkerboard
# in the background to indicate transparency.

#close the PNG device
dev.off()



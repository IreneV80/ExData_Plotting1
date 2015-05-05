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

#opening an empty png file in the working directory with the default height & width of 480x480
png(file ="plot1.png") 


#plot1
#create a histogram with bars in the color red, adding a title to the graph, changing the label of the X-axis 
hist(data2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# N.B.: Although the original plots have a transparent background, I decided to leave it white. This based
# on a thread on the discussion forum that the graph will be better visible without a checkerboard
# in the background to indicate transparency.

#close the PNG device
dev.off()
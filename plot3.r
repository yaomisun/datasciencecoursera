file_path<-"./household_power_consumption.txt"

myData<-read.table(file_path, sep=";", header = TRUE)
head(myData)
myData$Date= as.Date(myData$Date, "%d/%m/%Y")

#get set
myset<-myData[myData$Date >="2007-02-01"& myData$Date <="2007-02-02", ]

#add weekday to dataset
myset$FullDate<-with (myset,as.POSIXct(paste(myset$Date, myset$Time), format="%Y-%m-%d %H:%M:%S"))

sub1<-as.numeric(as.character(myset$Sub_metering_1))
sub2<-as.numeric(as.character(myset$Sub_metering_2))
sub3<-as.numeric(as.character(myset$Sub_metering_3))

par(mar=c(4,4,2,10))
plot(myset$FullDate, sub1, type="l",ylim=c(0, 40),yaxt="none",xlab="", ylab = "Energy sub metering")
axis(2, seq(0, 35, 10))

par(new=TRUE)
plot(myset$FullDate, sub2, type="l", ylim=c(0, 40), yaxt="none",xlab="", ylab = "Energy sub metering", col="red")
par(new=TRUE)
plot(myset$FullDate, sub3, type="l", ylim=c(0, 40), xlab="",yaxt="none", ylab = "Energy sub metering", col="blue")

legend("topright", lty=1,col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))



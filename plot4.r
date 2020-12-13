file_path<-"./household_power_consumption.txt"

myData<-read.table(file_path, sep=";", header = TRUE)
head(myData)
myData$Date= as.Date(myData$Date, "%d/%m/%Y")

#get set
myset<-myData[myData$Date >="2007-02-01"& myData$Date <="2007-02-02", ]

#add weekday to dataset
myset$FullDate<-with (myset,as.POSIXct(paste(myset$Date, myset$Time), format="%Y-%m-%d %H:%M:%S"))
activep<-as.numeric(myset$Global_active_power)

reactivep<-as.numeric(myset$Global_reactive_power)
Vol_No<-as.numeric(as.character( myset$Voltage))

sub1<-as.numeric(as.character(myset$Sub_metering_1))
sub2<-as.numeric(as.character(myset$Sub_metering_2))
sub3<-as.numeric(as.character(myset$Sub_metering_3))


par(mfrow = c(2, 2), mar=c(4,4,2,6))
with(myset, {
  plot(myset$FullDate,activep/500, type="l",xlab="", ylab = "Global Active Power")
  plot(myset$FullDate, as.numeric(Vol_No),yaxt="none",type="l",xlab="datetime", ylab = "Voltage")
  axis(2, at=seq(234, 246, 4))
  
  plot(myset$FullDate, sub1, type="l",ylim=c(0, 40),yaxt="none",xlab="", ylab = "Energy sub metering")
  axis(2, seq(0, 35, 10))
  
  par(new=TRUE)
  plot(myset$FullDate, sub2, type="l", ylim=c(0, 40), yaxt="none",xlab="", ylab = "Energy sub metering", col="red")
  par(new=TRUE)
  plot(myset$FullDate, sub3, type="l", ylim=c(0, 40), xlab="",yaxt="none", ylab = "Energy sub metering", col="blue")
  
  legend("topright", lty=1,bty="n", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  

  plot(myset$FullDate, reactivep/400, ylim=c(0,0.5),type="l",xlab="datetime", ylab = "Global_reactive_power")
})

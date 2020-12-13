file_path<-"./household_power_consumption.txt"

myData<-read.table(file_path, sep=";", header = TRUE)
head(myData)
myData$Date= as.Date(myData$Date, "%d/%m/%Y")

#get set
myset<-myData[myData$Date >="2007-02-01"& myData$Date <="2007-02-02", ]

#combine date to dataset
myset$FullDate<-with (myset,as.POSIXct(paste(myset$Date, myset$Time), format="%Y-%m-%d %H:%M:%S"))

activep<-as.numeric(myset$Global_active_power)

par(mar=c(4,4,2,8))
plot(myset$FullDate,activep/500, type="l",xlab="", ylab = "Global Active Power (Kilowatts)")


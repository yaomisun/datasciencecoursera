#read raw date

file_path<-"./household_power_consumption.txt"

myData<-read.table(file_path, sep=";", header = TRUE)
head(myData)
myData$Date= as.Date(myData$Date, "%d/%m/%Y")

#get set
myset<-myData[myData$Date >="2007-02-01"& myData$Date <="2007-02-02", ]
head(myset)

#using base plotting for his
activep<-as.numeric(myset$Global_active_power)

par(mar=c(4,4,2,6))
hist(activep/500, col="red", main="Global Active Power", xlab="Global Active Power (Kilowatts)" )
axis(1, at=seq(0, 6, by =2), labels = seq(0,6,2))


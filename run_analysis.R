#https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
#code book example:https://www.transtats.bts.gov/Fields.asp?Table_ID=236&SYS_Table_Name=T_ONTIME&User_Table_Name=On-Time%20Performance&Year_Info=1&First_Year=1987&Last_Year=2017&Rate_Info=0&Frequency=Monthly&Data_Frequency=Annual,Quarterly,Monthly


file_path<-"./UCIHARDataset/test/subject_test.txt"
subject_test_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(subject_test_data)

file_path<-"./UCIHARDataset/test/X_test.txt"
X_test_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(X_test_data)

file_path<-"./UCIHARDataset/test/y_test.txt"
y_test_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(y_test_data)


file_path<-"./UCIHARDataset/train/subject_train.txt"
subject_train_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(subject_train_data)

file_path<-"./UCIHARDataset/train/X_train.txt"
X_train_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(X_train_data)

file_path<-"./UCIHARDataset/train/y_train.txt"
y_train_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(y_train_data)



file_path<-"./UCIHARDataset/features.txt"
feature_data <- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(feature_data)


file_path<-"./UCIHARDataset/activity_labels.txt"
labels<- read.table(file_path, header = FALSE) #if they used some other way of saving the file than a default write.table, this step will be different
View(labels)


#combine train and test
y_data<-rbind(y_test_data,y_train_data)
View(y_data)

x_data<-rbind(X_test_data,X_train_data)
View(x_data)

subject_data<-rbind(subject_test_data,subject_train_data)
View(subject_data)

##Extracts only the measurements on the mean and standard deviation for each measurement.
searchfeature<-feature_data$V2 %in% grep("mean|std",feature_data$V2, value=TRUE)
View(searchfeature)
Needed_Features<-subset(feature_data, searchfeature)
View(Needed_Features)
x_final<-subset(x_data, select=searchfeature)
View(x_final)

#change column names
colnames(y_data)[1]="labels"

colnames(x_final)<-Needed_Features$V2

colnames(subject_data)[1]<-"subject"

final_set<-cbind(subject_data, y_data, x_final)

#combine all data into one set
final_labeled<-transform(merge(final_set, labels, by.x = "labels", by.y = "V1", all.x = TRUE))
names(final_labeled)
head(final_labeled)
names(final_labeled)[names(final_labeled)=="V2"]<-"RealLabels"

#do analysis of summary on each activity
library(dplyr)
subjectlabels<-final_labeled %>%group_by(RealLabels, subject)%>%summarise_each(funs(mean))
head(subjectlabels)




IoTAnalysis <- function()

# Initialization
        #workdir <- "C:/Users/danielsw/OneDrive/Data Science Specialization/DataProject"
        #if (!file.exists(workdir)) {
        #        dir.create(workdir)
        #}
        #setwd(workdir)
        #download.file(path, destfile = filename)
        #dateDownloaded <- date()
        #Rootpath <- path + "/UCI HAR Dataset"
        #Trainpath <- Rootpath + "/train"
        #Testpath <- Rootpath + "/test"

# Read all data files

# 1- Load training set (X_TRAIN + Y_TRAIN)
DataTrainTable = read.table("UCI HAR Dataset/train/X_train.txt")
# Load training labels column to the dataframe
DataTrainLabelTable <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = c("Activity_ID"))
# Add id column to the dataframe for merge
DataTrainTable$ID <- as.numeric(rownames(DataTrainTable))
DataTrainLabelTable$ID <- as.numeric(rownames(DataTrainLabelTable))


# 2- Load testing set (X_TEST + Y_TEST)
DataTestTable = read.table("UCI HAR Dataset/test/X_test.txt")
# Add test lables column to the dataframe
DataTestLabelTable = read.table("UCI HAR Dataset/test/Y_test.txt", col.names = c("Activity_ID"))
# Add subject id column to the dataframe
DataTestTable$ID <- as.numeric(rownames(DataTestTable))
DataTestLabelTable$ID <- as.numeric(rownames(DataTestLabelTable))

# 3- Read activity labels data
ActivityLabelsTable = read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_ID", "Activity_Label"),)


# 4- Read features data and transform it to mean and std deviation
DataFeaturesTable = read.table("UCI HAR Dataset/features.txt", col.names = c("Feature_ID", "Feature_Label"),)
Features <- DataFeaturesTable[grepl("mean\\(\\)", DataFeaturesTable$Feature_Label) | grepl("std\\(\\)", DataFeaturesTable$Feature_Label),]

# 5- Read subject data (SUBJECT_TRAIN + SUBJECT_TEST)
DataSubjectTrainTable = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("Subject_ID"))
DataSubjectTestTable = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject_ID"))
# Add id column to the dataframe for merge
DataSubjectTrainTable$ID <- as.numeric(rownames(DataSubjectTable))
DataSubjectTestTable$ID <- as.numeric(rownames(DataSubjectTestTable))


# 6- Merge DataFrames (TRAINING + TEST + SUBJECT + ACTIVITIES) and Data Cleanse
# 6.1- SUBJECTTRAIN + Y_TRAIN
Training_Table <- merge(DataSubjectTrainTable, DataTrainLabelTable, all = TRUE)
# 6.2- TRAINING_TABLE + DATATRAINTABLE
Training_Table <- merge(Training_Table, DataTrainTable, all = TRUE)
# 6.3- SUBJECTTEST + Y_TEST
Test_Table <- merge(DataSubjectTestTable, DataTestLabelTable, all = TRUE)
# 6.4- TEST_TABLE + X_TABLE
Test_Table <- merge(Test_Table,DataTestTable, all = TRUE)
# 6.5- TRAINING_TABLE + TEST_TABLE
DataSetA <- rbind(Training_Table, Test_Table)
# 6.6- DATASETA + FEATURES
DataSetB <- DataSetA[, c(c(1, 2, 3), Features$Feature_ID + 3)]
# 6.7- DATASETB + ACTIVITYLABELSTABLE
DataSetC = merge(DataSetB, ActivityLabelsTable)
# 6.8- Add Activity Lables to the dataset
Features$Feature_Label = gsub("\\(\\)", "", Features$Feature_Label)
Features$Feature_Label = gsub("-", ".", Features$Feature_Label)
for (i in 1:length(Features$Feature_Label)) {
        colnames(DataSetC)[i + 3] <- Features$Feature_Label[i]
}
# 6.9- Creates Final Tidy DataSet
columns <- c("ID", "Activity_Label")
TempDataSet <- DataSetC[, !(names(DataSetC) %in% columns)]
TidyDataSet <- aggregate(TempDataSet, by = list(Subject = TempDataSet$Subject_ID, Activity = TempDataSet$Activity_ID), FUN = mean, na.rm = TRUE)
columns <- c("Subject", "Activity")
TidyDataSet <- TidyDataSet[, !(names(TidyDataSet) %in% columns)]

# 7- Merges and Write final Tidy Data Set
TidyDataSet = merge(TidyDataSet, ActivityLabelsTable)
write.csv(file="IoTTidyDataSet.csv", x=TidyDataSet)
print("Data Extraction & Transformation Completed, check file IoTTidyDataSet.csv at working directory")
return()


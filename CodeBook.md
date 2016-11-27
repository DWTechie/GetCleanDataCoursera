The process of extracting and transforming the IoT data has follow these steps:

1) Train Data was loaded from csv files into dataframes following a taxonomy "Data" + scope of data + "Table" . For each dataframe, a ID column was created to support the merge process. The IDs were associated to the row index of each dataframe
2) Test Data was loaded from csv files into dataframes
3) Activity Labels were loaded from the csv file into a dataframe
4) Features data was loaded in a dataframe and the data was transformed to contain only the mean and standard deviation data inside a column called 'Feature_Label"
5) Subject Identificators were loaded from Train and Test data
6) All dataframes were merged together into DataSetC. Feature labels were cleaned to tidy the data
7) Final DataSet combining training data, test data, subjects and activities were combined in the final submission file.

The script lines are commented with the exact steps numbers listed here for easier tracking of the data changes.

Columns from the file:

#3 Subject ID - Identifies to which subject the activity data belongs too
#Data Columns:
*.mean.X - contains the mean of the train data from the activity of the subject related to axle X
*.mean.Y - contains the mean of the train data from the activity of the subject related to axle Y
*.mean.Z - contains the mean of the train data from the activity of the subject related to axle Z
*.std.X - contains the standard deviation of the train data from the activity of the subject related to axle X
*.std.Y - contains the standard deviation of the train data from the activity of the subject related to axle Y
*.std.Z - contains the standard deviation of the train data from the activity of the subject related to axle Z

BodyAcc - Body accelerometer sensor
GravityAcc - Gravity speed sensor, measures the drop rate
BodyAccJerk - Body accelerometer sensor measures the impulse speed (jumps)
BodyGyro - Body gyroscope sensor, measures the rotation speed

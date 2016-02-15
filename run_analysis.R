# Merge training and testing set 
train.x <- read.table("train/X_train.txt")
test.x <- read.table("test/X_test.txt")
tt.x <- rbind(train.x, test.x)

# Extracts only variable representing mean and std
meanStd.var.filter <- grep("-mean[(]|-std[()]",names.tt[,2])
tt.x.f <- tt.x[,meanStd.var.filter]
names.tt <- read.table("features.txt")
names(tt.x.f) <- names.tt[meanStd.var.filter,2]

# merge y training and testing data frames and
# add information about activities (y sets) to tt.x.f
train.y <- read.table("train/y_train.txt")
test.y <- read.table("test/y_test.txt")
tt.y <- rbind(train.y, test.y)
tt.f <- cbind(tt.x.f, tt.y)
names(tt.f)[length(tt.f)] <- "Activity.Id"

# load library dplyr
library(dplyr)

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
tt.f <- mutate(tt.f, Activity.Name=activities[Activity.Id,2])

# Appropriately labels the data set with descriptive variable names.
names(tt.f) <- gsub("^t","time",names(tt.f))
names(tt.f) <- gsub("^f","frequency",names(tt.f))
names(tt.f) <- gsub("[-]",".",names(tt.f))

# Add student column to data
student.x <- read.table("train/subject_train.txt")
student.y <- read.table("test/subject_test.txt")
student.tt <- rbind(student.x, student.y)
tt.f <- cbind(student.tt, tt.f)
names(tt.f)[1] <- "Student.Id"

# Creates a second tidy data set with the average of 
# each variable for each activity and each subject.
# 1. Group data by activity and student
my_data.grouped <- group_by(tt.f, Activity.Name, Student.Id)
# 2. Get mean for each group
summarise_each(my_data.grouped, c("mean"))






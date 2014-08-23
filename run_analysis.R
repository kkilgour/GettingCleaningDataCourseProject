# Step 1: Combine train and test sets
# Read individual files
xtrain <- data.frame()
xtrain <- rbind(xtrain, read.csv('./UCI HAR Dataset/train/X_train.txt', sep='', header=FALSE))

xtest <- data.frame()
xtest <- rbind(xtest, read.csv('./UCI HAR Dataset/test/X_test.txt', sep='', header=FALSE))

subtrain <- data.frame()
subtrain <- rbind(subtrain, read.csv('./UCI HAR Dataset/train/subject_train.txt', sep='', header=FALSE))

subtest <- data.frame()
subtest <- rbind(subtest, read.csv('./UCI HAR Dataset/test/subject_test.txt', sep='', header=FALSE))

ytrain <- data.frame()
ytrain <- rbind(ytrain, read.csv('./UCI HAR Dataset/train/y_train.txt', sep='', header=FALSE))

ytest <- data.frame()
ytest <- rbind(ytest, read.csv('./UCI HAR Dataset/test/y_test.txt', sep='', header=FALSE))

# Combine files by type
x <- data.frame()
x <- rbind(x, xtrain)
x <- rbind(x, xtest)

# Set column name for x
cn <- read.csv('./UCI HAR Dataset/features.txt', sep='', header=FALSE)
c <- t(cn$V2)
colnames(x) <- c[1,]

y <- data.frame()
y <- rbind(y, ytrain)
y <- rbind(y, ytest)
colnames(y) <- 'Activity'

sub <- data.frame()
sub <- rbind(sub, subtrain)
sub <- rbind(sub, subtest)
colnames(sub) <- 'Subject'

# Combine into one data frame
data <- data.frame()
data <- cbind(x, sub)
data <- cbind(data, y)

# Clean up old data frames
rm(xtrain)
rm(xtest)
rm(ytrain)
rm(ytest)
rm(subtrain)
rm(subtest)
rm(x)
rm(y)
rm(sub)

# Step 2: Extract only mean and standard deviation measurements

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
colnames(y) <- 'activity'

sub <- data.frame()
sub <- rbind(sub, subtrain)
sub <- rbind(sub, subtest)
colnames(sub) <- 'subject'

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
# Thanks to http://txt2re.com/index.php3?s=fBodyBodyAccJerkMag-mean()&-3 for the regex generation
meancols <- grep(".*?(mean)", names(data))
stdcols <- grep(".*?(std)", names(data))
df <- data[, c(meancols, stdcols, 562, 563)]

# Step 3: Use descriptive activity names
al <- data.frame()
al <- read.csv('./UCI HAR Dataset/activity_labels.txt', sep='', header=FALSE)
df$activity <- al[df$activity,2]

# Step 4: Make variable names a bit more readable
colnames(df) <- gsub("-|\\()", "", colnames(df))

# Step 5: Export as second tidy dataset
df$fac <- paste(df$subject, df$activity)
cols <- 1:79
m <- matrix(nrow=180, ncol=0)
end <- data.frame(m)
for (i in cols) {
	e <- tapply(df[,i], df$fac, mean)
	end <- cbind(end, e)
}
colnames(end) <- colnames(df[1:79])

# Split rownames up and cbind
#is <- 1:180
#act <- data.frame()
#subject <- data.frame()
#r <- strsplit(rownames(end)," ")
#for (i in is) {
#	subject <- rbind(rn, r[[i]][1])
#	act <- rbind(rn, r[[i]][2])
#}

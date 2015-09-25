##run_analysis.R - Getting and Cleaning Data Course Project - It performs the 5 required steps - ############ 1:5 below

if[!file.exists("X_train.txt") | !file.exists("X_test.txt") ) stop("one or more input datasets are missing.")

 library(datasets)
 library(plyr)
 library(dplyr) 
 library(reshape2); 
 
   xtr <- read.table("X_train.txt", sep = "", blank.lines.skip = TRUE )
   xts <- read.table("X_test.txt", sep = "", blank.lines.skip = TRUE )

### class(xts)[1] "data.frame"
### dim(xts)  [1] 2947  561
### class(xtr)[1] "data.frame"
### dim(xtr)  [1] 7352  561

### combine X_train, X_test

   nnxt <- data.frame()

   nnxt <- rbind(nnxt, xtr, xts)

### class(nnxt) [1] "data.frame
### dim(nnxt)   [1] 10299   561
  
### assign measurements to subject/activity pair  

    DS2 <- data.frame(Sub = 1:30, ActvtyID = c("walking","walking_upstairs","walking_down_stairs","sitting","standing","lying")

### class(DS2) [1] "data.frame"
### dim(DS2)   [1] 30

########## 1,3. merge training and test to create one data set with meaningful actvity names

    nxtm <- merge(DS2,nnxt)

### class(nxtm)  [1] "data.frame"
### dim(nxtm)    [1] 308970    563

########### 2. extract only the measurements on means/std on the selected measurements 
### subset the merged df - 

  nmm <- as.data.frame( c(nxtm[1:2],nxtm[203],nxtm[216],nxtm[229],nxtm[242],nxtm[255]))

########## 4.   create meaningful labels for the newly created  tidy data.frame.
  
   xlabel <- c( "Subj", "ActvtyID" , "AVG-TBodyAccMagMean", "AVG-TGravityAccMagMean", "AVG-TBodyAccJerkMagMean","AVG-TBodyGyroMagMean","AVG-TBodyGyroJerkMagMean"  )
   names(nmm) <- xlabel

########## 5.  A create a  second, independent tidy data set with the average of each variable for each activity and each subject.

         nxtdy <- aggregate(. ~ Subj + ActvtyID,  data = nmm, mean)

########### write the tidy data set to a text file.

   write.table(nxtdy, file = "nxtidy.txt", quote = FALSE, sep = " ", eol = '\n', dec = ".",  col.names = FALSE )

 file.exists("nxtidy.txt")

### [1] TRUE

q()
 












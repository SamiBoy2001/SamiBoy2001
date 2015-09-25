##run_analysis.R - Getting and Cleaning Data Course Project 



if[!file.exists("X_train.txt") | !file.exists("X_test.txt") ) stop("one or more input datasets are missing.")

library(util); library(reshape2); library(data.frame)

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
### dim(nnxt)   [1] 10300   561
  
### assign measurements to subject/activity pair

    DS2 <- data.frame(subject = 1:30, activity = c("walking","walking_upstairs","walking_down_stairs","sitting","standing","lying")

### class(DS2) [1] "data.frame"
### dim(DS2)   [1] 30  2


    nxtm <- merge(DS2,nnxt)

### class(nxtm)  [1] "data.frame"
### dim(nxtm)    [1] 308970    563

### melt newly merged values to reshape dataset to include only the selected set of measurements for each subject/activity pair.
  
    
    nxtmelt <- melt(nxtm, id.var =c("subject", "activity"), measure.vars = c("V201","V214","V227","V240","V253"),  na.rm = TRUE ) 

### dcast the molted data into R data.frame

    nxtd <- dcast(nxtmelt, value ~  variable , mean )

### create meaningful labels for the newly cast tidy data.frame.

  
   xlabel <- c( "Subj/ActvtyID" , "AVG-TBodyAccMagMean", "AVG-TGravityAccMagMean", "AVG-TBodyAccJerkMagMean","AVG-TBodyGyroMagMean","AVG-TBodyGyroJerkMagMean"  )
   names(nxtd) <- xlabel

       head(nxtd)
###    Subj/ActvtyID AVG-TBodyAccMagMean AVG-TBodyAccMagStd AVG-TGravityAccMagMean AVG-TGravityAccMagStd AVG-TBodyAccJerkMagMean
###           1          -0.3842836         -0.4683453             -0.7022636            -0.8006964              -0.7943785
###           2          -0.3827122         -0.4262198             -0.6941093            -0.6623246              -0.8692288
###           3          -0.5361829         -0.4554411             -0.5154099            -0.5559450              -0.8758107
###           4          -0.5666637         -0.4484275             -0.4302327            -0.5357352              -0.8319079
###           5          -0.6779965         -0.6123924             -0.4588396            -0.5104448              -0.8289983
###           6          -0.6879561         -0.6026347             -0.5280879            -0.4692016              -0.7851353
    tail(nxtd)
    Subj/ActvtyID AVG-TBodyAccMagMean AVG-TBodyAccMagStd AVG-TGravityAccMagMean AVG-TGravityAccMagStd AVG-TBodyAccJerkMagMean
###           25          -0.5734453         -0.7393470             -0.6815771            -0.5342159              -0.7238450
###           26          -0.4741126         -0.7046635             -0.8158497            -0.6552844              -0.7459303
###           27          -0.4183619         -0.6765072             -0.6891694            -0.7645228              -0.7233935 
###           28          -0.4041563         -0.5627135             -0.6731994            -0.7428532              -0.7870956
###           29          -0.4498744         -0.3765796             -0.5904639            -0.7233425              -0.8381887
###           30          -0.6015294         -0.3991866             -0.5719557            -0.6821019              -0.7632079
 
### write the tidy data set

   write.table(nxtd, file = "nxtidy.txt", quote = FALSE, sep = " ", eol = '\n', dec = ".",  col.names = TRUE)

 file.exists("nxtidy.txt")

### [1] TRUE

q()
 












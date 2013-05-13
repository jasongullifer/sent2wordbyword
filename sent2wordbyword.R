RSVPSplit <- function(filename,wordsPreceedingTarget = 18,inputTargetColumnName="Target.Word",inputSentenceColumnName="Sentence",wordsAfterTarget=15,skipChar = "-->",eprimeTargetColumnName = "tTarget19",fileEncoding="latin1"){

data <- read.csv(filename,encoding=fileEncoding)

newFrame <- as.data.frame(matrix(skipChar,length(rownames(data)),wordsPreceedingTarget + 1 + wordsAfterTarget),stringsAsFactors =FALSE)

colnames(newFrame)[wordsPreceedingTarget+1] <- eprimeTargetColumnName

data[,inputSentenceColumnName] <- as.character(data[,inputSentenceColumnName])

for (row in as.numeric(rownames(data))){
  warningFlag1=TRUE
  warningFlag2=FALSE
  startingVar <- 1
  currentSent <- strsplit(data[row,inputSentenceColumnName], " +")

  for (word in unlist(currentSent)){
    warningFlag3=FALSE
    if(word %in% data[-row,inputTargetColumnName]){
      warningFlag3=TRUE
    }
      
    if(word == data[row,inputTargetColumnName] | word == paste(data[row,inputTargetColumnName],".",sep="")){
      
      if(startingVar > wordsPreceedingTarget+1){
        warningFlag2=TRUE
      }
      
      newFrame[row,eprimeTargetColumnName] <- word
      startingVar <- wordsPreceedingTarget + 2
      warningFlag1=FALSE
    } else{
      newFrame[row,startingVar] <- word
      startingVar = startingVar+1
    }

    if(warningFlag3==TRUE){warning(paste(sep="","One of your sentences (#",row, ") contained a word (\"",word,"\") that is a target word for another sentence!! You will have to fix this manually."))}


      
  }
  if(warningFlag1==TRUE){warning(paste(sep="","A target (",data[row,inputTargetColumnName], "; sentence #",row,") was not matched in your sentences. You should check this out."))}
  if(warningFlag2==TRUE){warning(paste(sep="","One of your sentences (#",row, ") contained duplicate target words!!! You will have to fix this manually."))}

}
as.data.frame(cbind(data,newFrame))
}

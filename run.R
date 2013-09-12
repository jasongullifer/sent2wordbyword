source('sent2wordbyword.R')

#g1<-read.csv('g1.csv',encoding='latin1')
#g2<-read.csv('g2.csv',encoding='latin1')

g1_out <- RSVPSplit(filename="g1.csv",inputTargetColumnName="TargetWord",fileEncoding='utf8')
g2_out <- RSVPSplit(filename="g2.csv",inputTargetColumnName="TargetWord",fileEncoding='utf8')

write.csv(g1_out,'g1_out.csv')
write.csv(g2_out,'g2_out.csv')

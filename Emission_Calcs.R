PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')
PrevID<-as.character(PrevCal[,1])

#reconcile naming conventions
xx<-which(PrevID=="BA")
zz<-which(PrevID!="BA")
PrevID[xx]<-'BA-01-04'
PrevID2<-PrevID
for(i in 1:length(zz)){
  if(as.numeric(PrevID[zz[i]])>1000)PrevID2[zz[i]]<-as.character(paste('CRMS',as.character(as.numeric(PrevID[zz[i]])),sep=''))
  if(as.numeric(PrevID[zz[i]])<1000)PrevID2[zz[i]]<-as.character(paste('CRMS0',as.character(as.numeric(PrevID[zz[i]])),sep=''))
}


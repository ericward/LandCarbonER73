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

ANPPann<-read.csv('ANPPannual.csv')

AE<-ANPPann
AE[,4]<-NA
BE<-AE

AEsites<-unique(PrevID2)
for(i in 1:length(AEsites)){
  for(j in 1:3){
  xxx<-which(PrevID2==AEsites[i]&PrevCal[,4]==j)
  AE[(i-1)*5+j,4]<-mean(as.numeric(PrevCal$AGVF.annual.percent.loss[xxx]),na.rm=T)  
  }
}

BEsites<-unique(PrevID2)
for(i in 1:length(BEsites)){
  for(j in 1:3){
    xxx<-which(PrevID2==BEsites[i]&PrevCal[,4]==j)
    BE[(i-1)*5+j,4]<-mean(as.numeric(PrevCal$BGVF.annual.percent.loss[xxx]),na.rm=T)  
  }
}

write.csv(AE,'AbovegroundEmissions.csv',row.names=F)
write.csv(BE,'BelowgroundEmissions.csv',row.names=F)
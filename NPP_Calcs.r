ANPP<-read.csv('LUCAS_ANPP_calcs_ER73_Stagg_201906.csv')
BNPP<-read.csv('LUCAS_BNPP_calcs_ER73_Stagg_201906.csv')
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

#Get Marsh Type for ANPP BNPP
ANPPtype<-rep(NA,dim(ANPP)[1])
for(i in 1:dim(ANPP)[1]){
  ANPPtype[i]<-as.character(PrevCal$Wetland.Subclass.LUCAS[which(PrevID2==ANPP[i,1])[1]])
}

BNPPtype<-rep(NA,dim(BNPP)[1])
for(i in 1:dim(ANPP)[1]){
  BNPPtype[i]<-as.character(PrevCal$Wetland.Subclass.LUCAS[which(PrevID2==BNPP[i,1])[1]])
}

#to start and end with winter (min living biomass), use Production listed under T3-T6
#Camille already has calculated, so simply need to sum interval productions

#########Notes on calculations#############
#Changes calculated according to Smalley 1959
#four cases based on Live.Change.g and Dead.Change.g being positive or negative, respectively
#reduces to NPP = max(ANPP$Live.Change.g+max(ANPP$Dead.Change.g,0),0)
#Change in live, plus any positive change in dead material
#if result is negative, NPP is zero (it can't be negative in this algorithm)
#conservative estimate of NPP, always zero or postive but probably underestimates losses and thus production when production is high
#you can check this by uncommenting following two lines, they should print zeros
#print(sum(as.numeric(ANPP$Interval.Production.g)-max(as.numeric(ANPP$Live.Change.g)+max(as.numeric(ANPP$Dead.Change.g),0),0),na.rm=T))
#print(sum(as.numeric(BNPP$Interval.Production.g)-max(as.numeric(BNPP$Live.Change.g)+max(as.numeric(BNPP$Dead.Change.g),0),0),na.rm=T))

ANPPsites<-unique(ANPP[,1])
ANPPannual<-matrix(NA,length(ANPPsites)*5,4)
for(i in 1:length(ANPPsites)){
  xx<-which(ANPP[,1]==ANPPsites[i]&(ANPP$Event=='T3'|ANPP$Event=='T4'|ANPP$Event=='T5'|ANPP$Event=='T6'))
  ANPPannual[((i-1)*5+1):((i-1)*5+5),1]<-ANPP[xx[1],1]
  ANPPannual[((i-1)*5+1):((i-1)*5+5),2]<-ANPPtype[xx[1]]
  for(j in 1:5){
    ANPPannual[((i-1)*5+j),3]<-j  
    xxx<-which(ANPP[,1]==ANPPsites[i]&(ANPP$Event=='T3'|ANPP$Event=='T4'|ANPP$Event=='T5'|ANPP$Event=='T6')&as.numeric(ANPP[,2])==j)
    ANPPannual[((i-1)*5+j),4]<-sum(as.numeric(ANPP$Interval.Production.g[xxx]))
  }
}

BNPPsites<-unique(BNPP[,1])
BNPPannual<-matrix(NA,length(BNPPsites)*5,4)
for(i in 1:length(BNPPsites)){
  xx<-which(BNPP[,1]==BNPPsites[i]&(BNPP$Event=='T3'|BNPP$Event=='T4'|BNPP$Event=='T5'|BNPP$Event=='T6'))
  BNPPannual[((i-1)*5+1):((i-1)*5+5),1]<-BNPP[xx[1],1]
  BNPPannual[((i-1)*5+1):((i-1)*5+5),2]<-BNPPtype[xx[1]]
  for(j in 1:5){
    BNPPannual[((i-1)*5+j),3]<-j  
    xxx<-which(BNPP[,1]==BNPPsites[i]&(BNPP$Event=='T3'|BNPP$Event=='T4'|BNPP$Event=='T5'|BNPP$Event=='T6')&as.numeric(BNPP[,2])==j)
    BNPPannual[((i-1)*5+j),4]<-sum(as.numeric(BNPP$Interval.Production.g[xxx]))
  }
}

colnames(ANPPannual)<-c('Site','Wetland_Type','Transect','ANPP.g')
colnames(BNPPannual)<-c('Site','Wetland_Type','Transect','BNPP.g')

write.csv(ANPPannual,'ANPPannual.csv',row.names=F)
write.csv(BNPPannual,'BNPPannual.csv',row.names=F)

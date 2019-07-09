columns<-c('WetlandType','AboveLive.g.m-2','BelowLive.g.m-2','AboveVF.g.m-2','BelowVF.g.m-2','BelowS.g.m-2','ANPP.g.m-2.y-1','BNPP.g.m-2.y-1','AboveMort.g.m-2.y-1','BelowMort.g.m-2.y-1','AVF_Emission.percent','BVF_Emission.percent')
dataOUT<-matrix(NA,2,length(columns))
colnames(dataOUT)<-columns

AL<-read.csv('AbovegroundLive.csv')
BL<-read.csv('BelowgroundLive.csv')
AVF<-read.csv('AbovegroundVF.csv')
BVF<-read.csv('BGVFbySite.csv')
BS<-read.csv('BGSbySite.csv')
ANPP<-read.csv('ANPPannual.csv')
BNPP<-read.csv('BNPPannual.csv')
AM<-read.csv('AbovegroundMortality.csv')
BM<-read.csv('BelowgroundMortality.csv')
AE<-read.csv('AbovegroundEmissions.csv')
BE<-read.csv('BelowgroundEmissions.csv')

dataOUT[1,1]<-'Estuarine Herbaceous'
dataOUT[2,1]<-'Palustrine Herbaceous'

EHsites<-unique(AL[which(AL[,2]==dataOUT[1,1]),1])
PHsites<-unique(AL[which(AL[,2]==dataOUT[2,1]),1])

EHbySite<-matrix(NA,length(EHsites),length(columns))
colnames(EHbySite)<-columns
EHbySite[,1]<-dataOUT[1,1]

PHbySite<-matrix(NA,length(PHsites),length(columns))
colnames(EHbySite)<-columns
PHbySite[,1]<-dataOUT[2,1]

for(i in 1:length(EHsites)){
xx<-which(AL[,1]==EHsites[i])
EHbySite[i,2]<-mean(as.numeric(AL[xx,4]),na.rm=T)
EHbySite[i,3]<-mean(as.numeric(BL[xx,4]),na.rm=T)
EHbySite[i,4]<-mean(as.numeric(AVF[xx,4]),na.rm=T)

EHbySite[i,7]<-mean(as.numeric(ANPP[xx,4]),na.rm=T)
EHbySite[i,8]<-mean(as.numeric(BNPP[xx,4]),na.rm=T)
EHbySite[i,9]<-mean(as.numeric(AM[xx,4]),na.rm=T)
EHbySite[i,10]<-mean(as.numeric(BM[xx,4]),na.rm=T)
EHbySite[i,11]<-mean(as.numeric(AE[xx,4]),na.rm=T)
EHbySite[i,12]<-mean(as.numeric(BE[xx,4]),na.rm=T)
xxx<-which(PrevID2==EHsites[i])
yyy<-PrevCal[xxx[1],1]
zzz<-which(BGVF[,1]==yyy)
EHbySite[i,5]<-mean(as.numeric(BVF[zzz,3]),na.rm=T)
EHbySite[i,6]<-mean(as.numeric(BS[zzz,3]),na.rm=T)
}

for(i in 1:length(PHsites)){
  xx<-which(AL[,1]==PHsites[i])
  PHbySite[i,2]<-mean(as.numeric(AL[xx,4]),na.rm=T)
  PHbySite[i,3]<-mean(as.numeric(BL[xx,4]),na.rm=T)
  PHbySite[i,4]<-mean(as.numeric(AVF[xx,4]),na.rm=T)
  
  PHbySite[i,7]<-mean(as.numeric(ANPP[xx,4]),na.rm=T)
  PHbySite[i,8]<-mean(as.numeric(BNPP[xx,4]),na.rm=T)
  PHbySite[i,9]<-mean(as.numeric(AM[xx,4]),na.rm=T)
  PHbySite[i,10]<-mean(as.numeric(BM[xx,4]),na.rm=T)
  PHbySite[i,11]<-mean(as.numeric(AE[xx,4]),na.rm=T)
  PHbySite[i,12]<-mean(as.numeric(BE[xx,4]),na.rm=T)
  xxx<-which(PrevID2==PHsites[i])
  yyy<-PrevCal[xxx[1],1]
  zzz<-which(BGVF[,1]==yyy)
  PHbySite[i,5]<-mean(as.numeric(BVF[zzz,3]),na.rm=T)
  PHbySite[i,6]<-mean(as.numeric(BS[zzz,3]),na.rm=T)
}

write.csv(EHbySite,'ER73_EstHerb_Stock_Flow_by_Site.csv',row.names=F)
write.csv(PHbySite,'ER73_PalHerb_Stock_Flow_by_Site.csv',row.names=F)

for(i in 2:length(columns)) dataOUT[1,i]<-round(mean(as.numeric(EHbySite[,i]),na.rm=T),3)
for(i in 2:length(columns)) dataOUT[2,i]<-round(mean(as.numeric(PHbySite[,i]),na.rm=T),3)

write.csv(dataOUT,'ER73_Mean_Stocks_Flows_by_Wetland_Type_20190709.csv',row.names = F)
        
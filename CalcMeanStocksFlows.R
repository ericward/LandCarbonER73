columns<-c('WetlandType','AboveLive','BelowLive','AboveVF','BelowVF','BelowS','ANPP','BNPP','AboveMort','BelowMort','AVF_Emission','BVF_Emission')
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
PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')

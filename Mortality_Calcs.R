ANPPann<-read.csv('ANPPannual.csv')
BNPPann<-read.csv('BNPPannual.csv')
ANPP<-read.csv('LUCAS_ANPP_calcs_ER73_Stagg_201906.csv')
BNPP<-read.csv('LUCAS_BNPP_calcs_ER73_Stagg_201906.csv')
PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')

AM<-ANPPann
AM[,4]<-NA
BM<-AM

#Four cases:
#Negative Live Change and Negative Dead Change: Mortality equals Live Change (times -1)
#Positive Live Change and Positive Dead Change: Mortality equals Dead Change
#Negative Live Change and Positive Dead Change: Mortality equals the greater of the two previous
#Positive Live Change and Negative Dead Change: Zero mortality
#So, Mortality = max(Dead Change, -Live Change, 0)


ANPPsites<-unique(ANPP[,1])
for(i in 1:length(ANPPsites)){
  for(j in 1:5){
    xxx<-which(ANPP[,1]==ANPPsites[i]&(ANPP$Event=='T3'|ANPP$Event=='T4'|ANPP$Event=='T5'|ANPP$Event=='T6')&as.numeric(ANPP[,2])==j)
    zzz<-cbind(as.numeric(ANPP$Live.Change.g[xxx])/as.numeric(ANPP$Plot.Area.m2[xxx]),as.numeric(ANPP$Dead.Change.g[xxx])/as.numeric(ANPP$Plot.Area.m2[xxx]),rep(0,length(xxx)))
    AM[((i-1)*5+j),4]<-sum(apply(zzz,1,max))*0.5
  }
}

BNPPsites<-unique(BNPP[,1])
for(i in 1:length(BNPPsites)){
  for(j in 1:5){
    xxx<-which(BNPP[,1]==BNPPsites[i]&(ANPP$Event=='T3'|BNPP$Event=='T4'|BNPP$Event=='T5'|BNPP$Event=='T6')&as.numeric(BNPP[,2])==j)
    zzz<-cbind(as.numeric(BNPP$Live.Change.g[xxx])/as.numeric(BNPP$Core.Area.m2[xxx]),as.numeric(BNPP$Dead.Change.g[xxx])/as.numeric(BNPP$Core.Area.m2[xxx]),rep(0,length(xxx)))
    BM[((i-1)*5+j),4]<-sum(apply(zzz,1,max))*0.5
  }
}

colnames(AL)<-c('Site','Wetland_Type','Transect','AboveMortality.g.m-2.y-1')
colnames(BL)<-c('Site','Wetland_Type','Transect','BelowMortality.g.m-2.y-1')

write.csv(AM,'AbovegroundMortality.csv',row.names=F)
write.csv(BM,'BelowgroundMortality.csv',row.names=F)
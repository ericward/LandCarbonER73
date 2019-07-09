ANPPann<-read.csv('ANPPannual.csv')
BNPPann<-read.csv('BNPPannual.csv')
ANPP<-read.csv('LUCAS_ANPP_calcs_ER73_Stagg_201906.csv')
BNPP<-read.csv('LUCAS_BNPP_calcs_ER73_Stagg_201906.csv')
PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')

AL<-ANPPann
AL[,4]<-NA
BL<-AL

ANPPsites<-unique(ANPP[,1])
for(i in 1:length(ANPPsites)){
  for(j in 1:5){
    xxx<-which(ANPP[,1]==ANPPsites[i]&(ANPP$Event=='T3'|ANPP$Event=='T7')&as.numeric(ANPP[,2])==j)
    AL[((i-1)*5+j),4]<-mean(as.numeric(ANPP$Live.Biomass.g[xxx]),na.rm=T)/as.numeric(ANPP$Plot.Area.m2[xxx[1]])*0.5
  }
}

BNPPsites<-unique(BNPP[,1])
for(i in 1:length(BNPPsites)){
  for(j in 1:5){
    xxx<-which(BNPP[,1]==BNPPsites[i]&(ANPP$Event=='T3'|BNPP$Event=='T7')&as.numeric(BNPP[,2])==j)
    BL[((i-1)*5+j),4]<-mean(as.numeric(BNPP$Live.Roots.g[xxx]),na.rm=T)/as.numeric(BNPP$Core.Area.m2[xxx[1]])*0.5
  }
}

colnames(AL)<-c('Site','Wetland_Type','Transect','AboveLive.g.m-2')
colnames(BL)<-c('Site','Wetland_Type','Transect','BelowLive.g.m-2')

write.csv(AL,'AbovegroundLive.csv',row.names=F)
write.csv(BL,'BelowgroundLive.csv',row.names=F)
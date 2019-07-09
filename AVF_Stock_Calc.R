ANPPann<-read.csv('ANPPannual.csv')
ANPP<-read.csv('LUCAS_ANPP_calcs_ER73_Stagg_201906.csv')
AL<-ANPPann
AL[,4]<-NA

ANPPsites<-unique(ANPP[,1])
for(i in 1:length(ANPPsites)){
  for(j in 1:5){
    xxx<-which(ANPP[,1]==ANPPsites[i]&(ANPP$Event=='T3'|ANPP$Event=='T7')&as.numeric(ANPP[,2])==j)
    AL[((i-1)*5+j),4]<-mean(as.numeric(ANPP$Dead.Biomass.g[xxx]),na.rm=T)/as.numeric(ANPP$Plot.Area.m2[xxx[1]])*0.5
  }
}

colnames(AL)<-c('Site','Wetland_Type','Transect','AboveDead.g.m-2.y-1')
write.csv(AL,'AbovegroundVF.csv',row.names=F)
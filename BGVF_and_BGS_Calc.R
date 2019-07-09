PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')
SoilCores<-read.csv('LUCAS_Soil_Cores_ER73_Baustian_201906.csv')

#Convert depth range to minimum maximum depth
max.depth.cm<-numeric()
min.depth.cm<-numeric()
for(i in 1:dim(SoilCores)[1]){
  xx<-strsplit(as.character(SoilCores[i,4]),'-')
  min.depth.cm<-c(min.depth.cm,unlist(xx)[1])
  max.depth.cm<-c(max.depth.cm,unlist(xx)[2])
}


#check intervals are always 2 cm


#calculate TC 0-30 cm g m-2
TC.g.m.2.per.cm<-SoilCores[,9]*10^4 #convert g cm-3 to g m-2 ground area per 1 cm depth interval
SoilCores<-cbind(SoilCores,min.depth.cm,max.depth.cm,TC.g.m.2.per.cm)
uID<-unique(SoilCores$Site)

#########Changed method to use mean value, dropping missing values
#Impute missing values for TC
# xx<-which(is.na(SoilCores[,10]))
# for(i in 1:length(xx)){
#   if(SoilCores$Site[xx[i]]==SoilCores$Site[xx[i]-1]&SoilCores$Site[xx[i]]==SoilCores$Site[xx[i]+1]){
#     SoilCores[xx[i],10]<-SoilCores[xx[i]-1,10]/2+SoilCores[xx[i]+1,10]/2
#   } 
#   if(SoilCores$Site[xx[i]]!=SoilCores$Site[xx[i]-1]&SoilCores$Site[xx[i]]==SoilCores$Site[xx[i]+1]){
#     SoilCores[xx[i],10]<-SoilCores[xx[i]+1,10]
#   }
#   if(SoilCores$Site[xx[i]]==SoilCores$Site[xx[i]-1]&SoilCores$Site[xx[i]]!=SoilCores$Site[xx[i]+1]){
#     SoilCores[xx[i],10]<-SoilCores[xx[i]-1,10]
#   }
# }
# 
# #check all imputed
# print(length(which(is.na(SoilCores[,10]))))



#Calculate BGVF as mean TC times 30 cm depth
BGVF<-matrix(NA,1,3)
BGVF[1,1]<-as.character(uID[1])
xx<-which(SoilCores$Site==uID[1]&as.numeric(max.depth.cm)<=30)
BGVF[1,3]<-mean(SoilCores[xx,12],na.rm=T)*30
BGVF[1,2]<-as.character(SoilCores[xx[1],2])

for(i in 2:length(uID)){
  BGVF<-rbind(BGVF,matrix(NA,1,3))
  BGVF[i,1]<-as.character(uID[i])
  xx<-which(SoilCores$Site==uID[i]&as.numeric(max.depth.cm)<=30)
  BGVF[i,3]<-mean(SoilCores[xx,12],na.rm=T)*30
  BGVF[i,2]<-as.character(SoilCores[xx[1],2])
}

#Calculate BGS as mean TC times 70 cm depth
BGS<-matrix(NA,1,3)
BGS[1,1]<-as.character(uID[1])
xx<-which(SoilCores$Site==uID[1]&as.numeric(min.depth.cm)>=30)
BGS[1,3]<-mean(SoilCores[xx,12],na.rm=T)*70
BGS[1,2]<-as.character(SoilCores[xx[1],2])

for(i in 2:length(uID)){
  BGS<-rbind(BGS,matrix(NA,1,3))
  BGS[i,1]<-as.character(uID[i])
  xx<-which(SoilCores$Site==uID[i]&as.numeric(min.depth.cm)>=30)
  BGS[i,3]<-mean(SoilCores[xx,12],na.rm=T)*30
  BGS[i,2]<-as.character(SoilCores[xx[1],2])
}




write.csv(BGVF,"BGVFbySite.csv",row.names=F)
write.csv(BGS,"BGSbySite.csv",row.names=F)

write.csv(SoilCores,"LUCAS_Soil_Cores_ER73_Baustian_201906_reformat.csv")
PrevCal<-read.csv('LUCAS_Stocks_ER73_Stagg_201906.csv')
SoilCores<-read.csv('LUCAS_Soil_Cores_ER73_Baustian_201906.csv')

#calculate TC 0-30 cm g m-2
TC.g.m.2<-SoilCores[,9]*2*10^4 #convert g cm-3 to g m-2 ground area for 2 cm depth intervals
SoilCores<-cbind(SoilCores,TC.g.m.2)
uID<-unique(SoilCores$Site)

BGVF<-matrix(NA,2,1)
BGVF[1,1]<-uID[1]
xx<-which(SoilCores$Site==uID[1])
BGVF[1,2]<-sum(SoilCores[xx,10])

for(i in uID[-1]){
  BGVF<-rbind(BGVF,matrix(NA,2,1))
  BGVF[i,1]<-uID[i]
  xx<-which(SoilCores$Site==uID[i])
  BGVF[i,2]<-sum(SoilCores[xx,10])
}
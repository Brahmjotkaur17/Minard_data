library(dplyr)
library(ggplot2)
library(readxl)
library(gridExtra)
#specify path of minard-data excel sheet
minard_data <- read_excel("C:/Users/Brahm/Desktop/Assign_A1.2DV/minard-data.xlsx")
troops <- minard_data %>% select(long=LONP,lat=LATP,SURV, DIR,DIV)
cities <- minard_data %>% select(long=LONC,lat=LATC, CITY)
cities<-na.omit(cities)
temps<-minard_data %>% select(long=LONT,temp=TEMP,month=MON,DATE_temp=DAY)
temps<-na.omit(temps)
plot1 <- ggplot(troops, aes(long,lat)) +geom_path(aes(size=SURV,color=DIR,group=DIV),lineend = "round", linejoin = "round")
plot2<-plot1 + geom_text(aes(label=CITY),data = cities,size=3)
a<-c(1,2,3)*10^5
finalGraph<-plot2+scale_size("SURVIVORS",range = c(1,10),breaks = a)+
  xlab("Longitude")+ylab("Latitude")+ggtitle("Russian Campaign of 1812-1813")+
  scale_color_manual("DIRECTIONS",values = c("orange","grey40"))+coord_cartesian(xlim=c(24,38))+
  theme_bw()
plot_temp<-ggplot(temps,aes(long,temp))+geom_point()+
  geom_path(aes(color=DATE_temp))+geom_text(aes(label=month))+
  coord_cartesian(xlim=c(24,38))+
  theme_bw()
grid.arrange(finalGraph,plot_temp,nrow=2,heights=c(3,1))
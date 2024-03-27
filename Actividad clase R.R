Suma <- 2+2
Suma 
2+Suma
CHO<-535000
VERO<-1350000
CHO+VERO
Total<-CHO+VERO
#hola
X<-35
Y<-22
W<-34
Z<-25
X+Y
V1<-c(1,2,3)
V2<-c(4,5,6)
V3<-c(7,8,9)
V4<-c("M","D","Z")
DF_V<-data.frame(V4,V1,V2,V3)
View(DF_V)
install.packages("readr")
library("readr")
library(readr)
datos_titulacion_2_ <- read_csv("datos_titulacion (2).csv")
View(datos_titulacion_2_)
Titulacion<-read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/titulacion_amino_acidos/main/datos_titulacion%20(2).csv")
head(Titulacion)
install.packages("ggplot2")                     
library(ggplot2)
grafica<-ggplot(Titulacion,aes(x=Volumen,y=pH))+
  geom_point()+
labs(title="Titulacion de aminoacidos",x="volumen",y="pH")
grafica


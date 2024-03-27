install.packages("readr")
library(readr)
read_cvs(file=("datos_titulacion_2_")
titulacion <-read_csv(file="datos_titulacion_2_")

##############
#llamar desde un repositorio 
repositorio
head(repositorio)#para ver el encabaezado
View(repositorio)#para ver la tabla
###########################
#grafica
install.packages("ggplot2")
library(ggplot2)
grafica <- ggplot(repositorio,
                  aes(x=Volumen,
                      y=pH))+
  geom_line()+
  labs(title = "Titulacion cisteina", 
       x= "Volumen ácido (uL)", 
       y= "Valor de pH")+  
  theme_dark()  
grafica
ggsave("titulacion_repertorio.jpeg", plot=grafica, width=6, 
       height=4, dpi=500) #para guardar en carpeta de trabajo

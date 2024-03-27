#Creador: Catalina Rodríguez
#Gráfica de dispersion 
#Se realiza una serie de experimentos comparativos de cerebros de tres animales destetados cuyas madres estuvieron expuestas a una dieta restrictivas (desnutridas) y se compararon con tres animales cuyas madres se expusieron a una dieta ad libitum (eunutridas). Se desea saber: ¿Qué miRNAs fueron los que más cambiaron entre los animales desnutridos (tratamiento) comparados con los animales eunutridos (control)?
install.packages("packman")
library(pacman)
p_load("readr",
       "ggplot2",
       "ggreapel",# para etiquetar datos en grafica 
       "dplyr")

datos <- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/DesnutridasvsEunutridas.csv")
head(datos)

#extraccion de genes controles (referencia)

controles<- datos %>% 
  filter(Condicion=="Control")
head(controles)

promedio_controles <- controles %>% 
  summarise(Mean_C1=mean(Cx1),
             Mean_C2=mean(Cx2),
             Mean_C3=mean(Cx3),
             Mean_T1=mean(T1),
             Mean_T2=mean(T2),
             Mean_T3=mean(T3) )%>%
              mutate(Gen="Promedio_controles") %>%
              select(7,1,2,3,4,5,6) %>% 
mutate(Gen="promedio_controles") %>% 
select(7,1,2,3,4,5,6)
promedio_controles
##############
#estraer genes de la tabla datos

genes <- datos %>% 
  filter(Condicion == "Target") %>% 
  select(-2)
head(genes)

#sacat el eel 2^DCT

##################
DCT <- genes %>% 
  mutate(DCT_C1=2^-(Cx1-promedio_controles$Mean_C1),
         DCT_C2=2^-(Cx2-promedio_controles$Mean_C2),
          DCT_C3=2^-(Cx3-promedio_controles$Mean_C3),
          DCT_T1=2^-(T1-promedio_controles$Mean_T1),
          DCT_T2=2^-(T2-promedio_controles$Mean_T2),
          DCT_T3=2^-(T3-promedio_controles$Mean_T3)) %>% 
select(-2,-3,-4,-5,-6,-7)
         
DCT         

promedio_genes<-DCT %>% 
  mutate(Mean_DCT_Cx=(DCT_C1+DCT_C2+DCT_C3)/3,
         Mean_DCT_Tx=(DCT_T1+DCT_T2+DCT_T3)/3)
  
promedio_genes

#Grafica

grafica_dispersion <- ggplot(promedio_genes,
                             aes(x= Mean_DCT_Cx,
                                 y= Mean_DCT_Tx ))+
  geom_point(size = 2,
            color = "blue")
grafica_dispersion

grafica_dispersion2 <- grafica_dispersion +
  labs(title = "Condición control vs tratamiento",
       caption = "Creador: Catalina Rodríguez",
       x = expression("Control 2"^"-DCT"),
       y = expression("Tratamiento 2"^"-DCT")) +
  geom_smooth(method = "lm", color = "pink") +
  theme_minimal() + # Estilo de gráfica
  theme(
    text = element_text(family = "Times New Roman"),
    legend.text = element_text(size = 14),
    axis.text = element_text(size = 12),
    panel.background = element_rect(fill = "white"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(color = "black", size = 1)
  )

grafica_dispersion2




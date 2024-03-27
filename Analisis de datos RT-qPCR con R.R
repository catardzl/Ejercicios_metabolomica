#creador: Catalina Rodriguez
#Analisis de datos de tipiempo real 
install.packages("pacman") #pacman sirve para llamar e instalar otros paquetes
library(pacman) # ejecurtar
p_load("readr", #reader llamar base de datos 
       "dplyr") #dplayer facilita el manejo de datos

p_load("dplyr")

###########
#llamar la base de datos 
datos_pcr <- read_csv(file="https://raw.githubusercontent.com/ManuelLaraMVZ/Transcript-mica/main/Genes.csv")
head(datos_pcr)
############
#Obtencion de los genes de referencia y de interes

actina <- datos_pcr %>% 
  slice(1)
actina
genes_interes <- datos_pcr %>%
  slice(-1)
genes_interes
###################
# promediar controles y tratamientos

promedio_actina <- actina %>%
  mutate(Mean_Cx=(C1+C2+C3)/3) %>%
mutate(Mean_Tx=(T1+T2+T3)/3) %>%
  select(Gen,Mean_Cx,Mean_Tx)
promedio_actina

promedio_GI <- genes_interes %>%
  mutate(Mean_Cx=(C1+C2+C3)/3) %>%
mutate(Mean_Tx=(T1+T2+T3)/3) %>%
select(Gen,Mean_Cx,Mean_Tx)
promedio_GI
##########################################

#Analisis de DCT

DCT <- promedio_GI %>%
   mutate(DCT_Cx=(Mean_Cx-promedio_actina$Mean_Cx)) %>%
  mutate(DCT_Tx=(Mean_Tx-promedio_actina$Mean_Tx)) %>%
  select (Gen, DCT_Cx, DCT_Tx)


DCT
##########################

#Analisis DDCT

DDCT <- DCT %>%
  mutate(DDCT=(DCT_Tx-DCT_Cx)) %>%
mutate("2DDCT"=(2^(-DDCT)))
DDCT

##########################
#Guardar tabla

write.csv(DDCT, "2DDCT.csv", row.names = FALSE)

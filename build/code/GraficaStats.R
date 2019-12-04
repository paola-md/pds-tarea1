#!/usr/bin/env Rscript
# ================= Paquetes ================= 
instalar <- function(paquete) {
  
  if (!require(paquete,character.only = TRUE, quietly = TRUE, warn.conflicts = FALSE)) {
    install.packages(as.character(paquete), dependecies = TRUE, repos = "http://cran.us.r-project.org")
    library(paquete, character.only = TRUE, quietly = TRUE, warn.conflicts = FALSE)
  }
}

paquetes <- c('magrittr','dplyr', 'tidyr', 'readr',
              'ggplot2', 'stringr')

lapply(paquetes, instalar)

# ================= Funciones ================= 
setwd(getSrcDirectory()[1]) #En bash
RESULTS <- "./../results/"
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) #En RStudio

crea_grafica <- function(nom_archivo, nom_interes) {
  dir_archivo <- str_c(RESULTS, nom_archivo)
  data_forma <- read_delim(dir_archivo, delim=" ")
  colnames(data_forma) <- c("count", "interes")
  data_forma$count <- as.numeric(data_forma$count)
  
  ggplot(data_forma, aes(reorder(interes, -count, sum) , count, fill = interes)) +
    geom_bar(stat= "identity") +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"),
          axis.title = element_text(size=15), axis.text =  element_text(size=10), 
          axis.text.x = element_text(angle=90)) + 
    labs(x = nom_interes, y = "Número de observaciones")
  nom_grafica <- str_c(RESULTS,"grafica",nom_interes,".png")
  ggsave(nom_grafica, width = 8, height = 6, dpi = 300, units = "in", device='png')
}

# ================= Main ================= 
crea_grafica("stats_forma", "Forma")
crea_grafica("stats_edo", "Estado")
crea_grafica("stats_color", "Color")

crea_grafica("stats_anyo", "Anyo")
crea_grafica("stats_mes", "Mes")
crea_grafica("stats_hora", "Hora")
# install.packages("googlesheets")
library(googlesheets)
library(tidyverse)
library(corrplot)

# gs authorization -------------------------------------------------------
# gs_auth()

# get predictions --------------------------------------------------------
predictions = gs_url("https://docs.google.com/spreadsheets/d/1oYXLahMgeop7UckeJio36OQMV6uhTZvIezR_Th7jy5Y") %>% 
  gs_read(ws = "Predictions") %>% 
        select(4:10) %>% 
        mutate_if(is.character, as.numeric) %>% 
  na.omit() %>% 
  slice(1:6000)

# get correlations ------------------------------------------------------
predictions_cor = cor(predictions, use = "complete.obs")

# create a figure --------------------------------------------------------
dir.create("figs")
png("figs/cor_mat.png", width = 600, height = 600)
corrplot.mixed(predictions_cor)
dev.off()
